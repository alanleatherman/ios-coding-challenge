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

#import <SDWebImage/UIImageView+WebCache.h>
#import <ZoomInteractiveTransition/ZoomInteractiveTransition.h>

@interface ALMixDetailViewController () <ZoomTransitionProtocol>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *userImageView;
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
    
    //self.navigationController.navigationBar.topItem.title = @"";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZoomTransitionProtocol

-(UIView *)viewForZoomTransition:(BOOL)isSource
{
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
