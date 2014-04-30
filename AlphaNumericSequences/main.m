//
//  main.m
//  AlphaNumericSequences
//
//  Created by David Wieringa on 4/30/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "console.h"

// return a random integer from 1..limit
NSInteger randomInt(NSInteger limit);

// return a random uppercase letter
NSString *randomLetter();

// return a random digit from 1..9
NSString *randomDigit();

// show the sequence seperated by spaces for easier reading
void showSequence(NSString *sequence);


int main(int argc, const char * argv[])
{

    @autoreleasepool {

        // seed the random number generator
        srand((unsigned int)time(NULL));

        // determine the desired sequence length
        int seqSize;
        do {
            seqSize = getIntegerFromConsole(@"Enter the desired sequence size (2-15): ");
        } while (seqSize < 2 || seqSize > 15);
        
        // determine how many letters vs numbers to include (starting real simple)
        int numLetters = seqSize / 2;
        int numDigits = seqSize - numLetters;
        int numLettersUsed = 0;
        int numDigitsUsed = 0;
        
        // loop through sequence size to build the sequence
        NSString *sequence = @""; // NSMutableArray would be better, but we haven't covered that yet
        while (sequence.length < seqSize) {
            
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
            } while ([sequence rangeOfString:nextChar].location != NSNotFound); // ensure no duplicate characters
            
            // append new character to string
            sequence = [sequence stringByAppendingString:nextChar];
        }
        
        // output sequence with spacing for easier reading
        showSequence(sequence);
        
        // sort sequence (I'll save this for another day when we have more tools)
        
        // output sorted sequence with spacing
    }
    return 0;
}

// return a random integer from 0..n-1
NSInteger randomInt(NSInteger n)
{
    // I'm avoiding using modulus (%) to fix a range since it skews the results
    // ie: http://stackoverflow.com/questions/2999075/generate-a-random-number-within-range/2999130#2999130
    // http://eternallyconfuzzled.com/arts/jsw_art_rand.aspx
    
    // In the future, it would be better to use arc4random
    // http://nshipster.com/random/
    
    int rmax = RAND_MAX;
    int divisor = rmax/(n);
    int val;
    int r;
    
    do {
        r = rand();
        val = r / divisor;
    } while (val >= n);
    
    return val;

}

NSString *randomChar(NSString *options)
{
    // oops, need method calls (on NSString) which we haven't covered yet
    return [options substringWithRange:NSMakeRange(randomInt(options.length), 1)];
}

NSString *randomLetter()
{
    return randomChar(@"ABCDEFGHIJKLMNOPQRSTUVWXYZ");
}

NSString *randomDigit()
{
    return randomChar(@"123456789");
}

void showSequence(NSString *sequence)
{
    // reformat the string so that each character is separated by spaces for easier reading
    NSString *output = @""; // NSMutableString would be better, but I'm trying to avoid things we haven't discussed
    for (int i = 0; i < sequence.length; i++) {
        // move character from sequence to output string
        // (oops, need method calls which we haven't discussed yet)
        output = [output stringByAppendingString:[sequence substringWithRange:NSMakeRange(i,1)]];

        // add spaces to delimit the characters for easier reading
        output = [output stringByAppendingString:@"  "];
    }
    
    NSLog(@"Random sequence:  %@",output);
}