//
//  random.h
//  AlphaNumericSequences
//
//  Created by David Wieringa on 5/7/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#ifndef AlphaNumericSequences_random_h
#define AlphaNumericSequences_random_h

// I moved my previous C random functions as-is from main.m to here.  I'll probably clean these up later.

NSInteger randomInt(NSInteger n);
NSString *randomChar(NSString *options);
NSString *randomLetter();
NSString *randomDigit();

#endif
