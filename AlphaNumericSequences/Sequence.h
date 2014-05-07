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

@property (readonly) NSInteger length;
@property (strong, readonly) NSArray *elements;
@property (strong, readonly) NSArray *elementsSorted;

- (NSString *)asString;
- (NSString *)asStringSorted;

@end
