//
//  RandomStringGenerator.m
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Afrozaar. All rights reserved.
//

#import "RandomStringGenerator.h"

@implementation RandomStringGenerator

NSString *const RandomStringGeneratorLetters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *)randomStringWithLength:(NSUInteger)length {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [RandomStringGeneratorLetters characterAtIndex: arc4random_uniform((uint32_t)[RandomStringGeneratorLetters length]) % [RandomStringGeneratorLetters length]]];
    }
    return randomString;
}

@end
