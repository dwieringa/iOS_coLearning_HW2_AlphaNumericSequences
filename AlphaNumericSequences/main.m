//
//  main.m
//  AlphaNumericSequences
//
//  Created by David Wieringa on 4/30/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sequence.h"
#import "console.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        // determine the desired sequence length
        int seqSize;
        do {
            seqSize = getIntegerFromConsole(@"Enter the desired sequence size (2-15): ");
        } while (seqSize < 2 || seqSize > 15);

        Sequence *sequence = [[Sequence alloc] initWithLength:seqSize];
        
        // output sequence with spacing for easier reading
        NSLog(@"Sequence: %@", [sequence asString]);

        // output sorted sequence with spacing
        NSLog(@" ");
        NSLog(@"Sorted  : %@", [sequence asStringSorted]);
    }
    return 0;
}
