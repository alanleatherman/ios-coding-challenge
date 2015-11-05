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

#pragma mark - Alert Controller Helper method

+ (void)displayAlertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                                         }];
        [alert addAction:okButton];
        
        [vc presentViewController:alert animated:YES completion:nil];
    });
}

@end
