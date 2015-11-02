//
//  ALCodingChallengeHelpers.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/2/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALCodingChallengeHelpers.h"

@implementation ALCodingChallengeHelpers

+ (BOOL)isValidValue:(id)value {
    if (!value) {
        return NO;
    } else if (value == [NSNull null]) {
        return NO;
    }
    
    return YES;
}

@end
