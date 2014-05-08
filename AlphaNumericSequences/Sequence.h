//
//  Sequence.h
//  AlphaNumericSequences
//
//  Created by David Wieringa on 5/7/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sequence : NSObject

- (instancetype)initWithLength:(NSInteger)length;

@property (readonly) NSInteger length;  // readonly since it is defined at initialization and should not change
@property (strong, readonly) NSArray *elements;
@property (strong, readonly) NSArray *elementsSorted;

// Note: elements & elementsSorted properties are readonly since they are managed internal to Sequence class and should not be modified by anything else.

// Methods/Messages
- (NSString *)asString;  // convert a sequence to a human-readable string
- (NSString *)asStringSorted;

@end
