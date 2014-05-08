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
    // define storage for the elements & elementsSorted properties.
    // This isn't done automatically by XCode since I've made the properties readonly and provided custom getters
    NSArray *_elements;
    NSArray *_elementsSorted;
}
- (NSArray *)generateSequence;
- (NSString *)asStringFromArray:(NSArray *)elements;

@end

@implementation Sequence

#pragma mark Initializers

// initializer: init a Sequence object with specified length
- (instancetype)initWithLength:(NSInteger)length
{
    self = [super init];
    
    if (self) {
        _length = length;

        // note: I could generate the sequence here, but am using lazy instantiation to generate it at the last moment when it we know for sure it will be used (ie in the getter method)
    }
    return self;
}

#pragma mark Getters

// getter for elements property (each character of the sequence is an element of an NSArray)
- (NSArray *)elements
{
    // lazy instantiation: only go through work of generating the sequence once it is needed
    if (!_elements) _elements = [self generateSequence];
    
    return _elements;
}

// getter for the sorted elements property
- (NSArray *)elementsSorted
{
    // lazy instantiation: only go through work of generating the sorted sequence once it is needed
    if (!_elementsSorted) _elementsSorted = [self.elements sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return _elementsSorted;
}

#pragma mark Messages

// returns the Sequence in an NSString type for easy output via NSLog
// invoked with [sequence asString]
- (NSString *)asString
{
    return [self asStringFromArray:self.elements];
}

// returns the sorted version of the Sequence in an NSString type for easy output via NSLog
// invoked with [sequence asString]
- (NSString *)asStringSorted
{
    return [self asStringFromArray:self.elementsSorted];
}

#pragma mark Helpers

// a helper method that translates a sequence (NSArray) to a formatted string for human reading
// This gets used by both asString and asStringSorted above.
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

// support for properly printing a Sequence via %@ in NSLog
- (NSString *)description
{
    // return a human-readable formatted NSString in it's original/unsorted form
    return [self asString];
}

// the guts of generating a random sequence that meets the rules
//
// Rules:
// 1. Sequences should be approximately half letters and half digits
// 2. Digits include 1 through 9 (not 0)
// 3. No letter or digit should be used more than once in the sequence
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
