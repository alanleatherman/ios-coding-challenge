//
//  ALCodingChallengeHelpers.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/2/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@interface ALCodingChallengeHelpers : NSObject

+ (BOOL)isValidValue:(id)value;
+ (void)displayAlertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc;

@end
