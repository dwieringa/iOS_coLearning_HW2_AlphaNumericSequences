//
//  console.m
//  ConsoleIO
//
//  Created by David Groulx on 4/24/14.
//  Copyright (c) 2014 David Groulx. All rights reserved.
//

#import "console.h"

#import <stdio.h>
#import <stdlib.h>

@import Foundation;

int getIntegerFromConsole(NSString* prompt) {
  NSLog(@"%@", prompt);
  NSFileHandle *fileHandle = [NSFileHandle fileHandleWithStandardInput];
  NSData *inputData;
  NSString *inputString;

  inputData = [fileHandle availableData];
  inputString = [[NSString alloc] initWithData: inputData encoding:NSUTF8StringEncoding];
  return [inputString intValue];
}

float getDecimalFromConsole(NSString* prompt) {
  NSLog(@"%@", prompt);
  NSFileHandle *fileHandle = [NSFileHandle fileHandleWithStandardInput];
  NSData *inputData;
  NSString *inputString;
  
  inputData = [fileHandle availableData];
  inputString = [[NSString alloc] initWithData: inputData encoding:NSUTF8StringEncoding];
  return [inputString floatValue];
}

NSString* getStringFromConsole(NSString* prompt) {
  NSLog(@"%@", prompt);
  NSFileHandle *fileHandle = [NSFileHandle fileHandleWithStandardInput];
  NSData *inputData;
  NSString *inputString;
  
  inputData = [fileHandle availableData];
  inputString = [[NSString alloc] initWithData: inputData encoding:NSUTF8StringEncoding];
  return inputString;
}

