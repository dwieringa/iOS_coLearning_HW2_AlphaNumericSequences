//
//  Sequence.m
//  AlphaNumericSequences
//
//  Created by David Wieringa on 5/7/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "Sequence.h"
#import "random.h"

@interface Sequence() {
    NSArray *_elements;
    NSArray *_elementsSorted;
}
- (NSArray *)generateSequence;
- (NSString *)asStringFromArray:(NSArray *)elements;

@end

@implementation Sequence

#pragma mark Initializers

- (instancetype)initWithLength:(NSInteger)length
{
    self = [super init];
    
    if (self) {
        _length = length;
    }
    return self;
}

#pragma mark Getters

// getter for elements array
- (NSArray *)elements
{
    // lazy instantiation: only go through work of generating the sequence once it is needed
    if (!_elements) _elements = [self generateSequence];
    
    return _elements;
}

- (NSArray *)elementsSorted
{
    // lazy instantiation: only go through work of generating the sorted sequence once it is needed
    if (!_elementsSorted) _elementsSorted = [self.elements sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return _elementsSorted;
}

#pragma mark Messages

- (NSString *)asString
{
    return [self asStringFromArray:self.elements];
}

- (NSString *)asStringSorted
{
    return [self asStringFromArray:self.elementsSorted];
}

#pragma mark Helpers

#define DELIMITER @"  "
- (NSString *)asStringFromArray:(NSArray *)array
{
    // create string object to build output into (initializing with capacity is a minor/optional optimization)
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:array.count*(DELIMITER.length+1)];

    // build output string
    for (NSString *element in array) {
        [string appendString:element];
        
        // add spaces to delimit characters for easier reading
        if (element != [array lastObject]) {
            [string appendString:DELIMITER];
        }
    }
    return string;
}

- (NSString *)description
{
    return [self asString];
}

- (NSArray *)generateSequence
{
    // determine how many letters vs numbers to include (starting real simple)
    NSInteger numLetters = self.length / 2;
    NSInteger numDigits = self.length - numLetters;
    NSInteger numLettersUsed = 0;
    NSInteger numDigitsUsed = 0;
    
    // loop through sequence size to build the sequence
    NSMutableArray *sequence = [[NSMutableArray alloc] initWithCapacity:self.length];
    while (sequence.count < self.length) {
        
        // randomly pick if the next character will be a letter of number
        BOOL pickLetter = randomInt(2) == 1;
        
        // don't pick too many of one type
        if (pickLetter && numLettersUsed >= numLetters) {
            pickLetter = NO;
        } else if (!pickLetter && numDigitsUsed >= numDigits) {
            pickLetter = YES;
        }
        if (pickLetter) {
            numLettersUsed += 1;
        } else {
            numDigitsUsed += 1;
        }
        
        // randomly pick character from chosen set
        NSString *nextChar;
        do {
            if (pickLetter) {
                nextChar = randomLetter();
            } else {
                nextChar = randomDigit();
            }
        } while ([sequence containsObject:nextChar]); // ensure no duplicate characters
        
        // append new character to array
        [sequence addObject:nextChar];
    }
    return [sequence copy];
}

@end
