//
//  random.m
//  AlphaNumericSequences
//
//  Created by David Wieringa on 5/7/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

// I moved my previous C random functions as-is from main.m to here.  I'll probably clean these up later.

#import "random.h"


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
