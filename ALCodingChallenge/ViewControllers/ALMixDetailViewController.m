//
//  MixDetailViewController.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/5/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixDetailViewController.h"
#import "ALMixModel.h"
#import "ALUserModel.h"
#import "ALCodingChallengeConstants.h"
#import "ALCodingChallengeHelpers.h"
#import "ALZoomInteractiveTransition.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ALMixDetailViewController () <ALZoomTransitionProtocol>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *userImageView;
@property (nonatomic, weak) IBOutlet UIImageView *playButtonImageView;
@property (nonatomic, weak) IBOutlet UIVisualEffectView *blurEffectView;

@property (nonatomic, weak) IBOutlet UITextView *mixDescriptionTextView;
@property (nonatomic, weak) IBOutlet UILabel *mixDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *mixAuthorLabel;
@property (nonatomic, weak) IBOutlet UILabel *mixNameLabel;

@property (nonatomic, weak) ALMixModel *mixModel;

@end

@implementation ALMixDetailViewController

- (void)initilizeWithMixModel:(ALMixModel *)mixModel {
    /*
    [self.mixImageView sd_setImageWithURL:[NSURL URLWithString:mixModel.mixImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];
    */
    self.mixModel = mixModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [self.mixModel.mixName stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UITapGestureRecognizer *playTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPlayButton)];
    [self.playButtonImageView addGestureRecognizer:playTapGesture];
    
    [self.mixImageView sd_setImageWithURL:[NSURL URLWithString:self.mixModel.mixImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.mixModel.mixImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:self.mixModel.mixUserModel.userImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    self.mixAuthorLabel.text = self.mixModel.mixUserModel.userName;
    self.mixDescriptionTextView.text = self.mixModel.mixDescription;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:kSpringDefaultDamping initialSpringVelocity:kSpringDefaultInitialVelocity options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.userImageView.alpha = 1.0f;
            CGFloat yTranslation = (self.mixImageView.frame.origin.y + self.mixImageView.frame.size.height) - self.userImageView.frame.origin.y - (CGRectGetHeight(self.userImageView.frame) / 2);
            CGFloat xTranslation = ([[UIScreen mainScreen] bounds].size.width / 2) - 50.f;
            
            self.userImageView.transform = CGAffineTransformMakeTranslation(xTranslation, yTranslation);
            
            self.mixAuthorLabel.alpha = 1.0f;
            self.mixDescriptionTextView.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
    });
}

#pragma mark - Tap Gesture Methods

- (void)tappedPlayButton {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kMixDetailPlayAnimationDuration delay:0.0 usingSpringWithDamping:kSpringDefaultDamping initialSpringVelocity:kSpringDefaultInitialVelocity options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.playButtonImageView.transform = CGAffineTransformMakeScale(kShortPressCenterCellMaxScale, kShortPressCenterCellMaxScale);
        } completion:^(BOOL finished) {
            [ALCodingChallengeHelpers displayAlertWithTitle:NSLocalizedString(@"Not Yet!", @"Not Yet")
                                                    message:NSLocalizedString(@"This feature is not built out for this coding challenge, maybe in the future!", @"Unbuilt feature message")
                                             viewController:self];
            
            [UIView animateWithDuration:kAnimationDefaultDuration delay:0.0 usingSpringWithDamping:kSpringDefaultDamping initialSpringVelocity:kSpringDefaultInitialVelocity options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.playButtonImageView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
            }];
        }];
    });
}

#pragma mark - ZoomTransitionProtocol

-(UIView *)viewForZoomTransition:(BOOL)isSource {
    return self.mixImageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
