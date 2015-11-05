//
//  ViewController.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/27/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixesCollectionViewController.h"
#import "ALCodingChallengeNetworkFetcher.h"
#import "ALCodingChallengeConstants.h"
#import "ALMixCollectionViewCell.h"
#import "ALMixesCollectionViewFlowLayout.h"
#import "ALMixModel.h"
#import "ALMixSetPaginationModel.h"
#import "ALMixSetPageModel.h"
#import "ALUserModel.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface ALMixesCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *userImageView;
@property (nonatomic, weak) IBOutlet UIVisualEffectView *blurEffectView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *userImageActivityIndicatorView;
@property (nonatomic, weak) ALMixCollectionViewCell *centerMixCell;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *blurEffectViewTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *blurEffectViewBottomConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *userImageBottomConstraint;

@property (nonatomic, strong) ALMixesCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) ALMixSetPageModel *pageModel;
@property (nonatomic, assign) BOOL isUpdatingPagination;

@property (nonatomic, assign) NSTimeInterval centerCellSelectTime;
@property (nonatomic, assign) BOOL isSelectingCenterCell;
@property (nonatomic, assign) BOOL hasSetFinalNavigationBar;

- (ALMixCollectionViewCell *)getMixCellForCurrentCenterIndexPath;

@end

@implementation ALMixesCollectionViewController

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    return [self initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"ALCodingChallenge", @"Navigation Title for Mixes CollectionVC");
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kMixSetNavigationTextColor}];
    
    self.navigationController.navigationBar.barTintColor = kMixSetNavigationBackgroundColor;
    self.navigationController.view.backgroundColor = kDefaultMixSetNavigationBackgroundViewColor;
    
    self.collectionView.backgroundView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedCollectionView:)];
    longPressGesture.minimumPressDuration = kLongPressDuration;
    [self.collectionView addGestureRecognizer:longPressGesture];
    
    self.flowLayout = [[ALMixesCollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:self.flowLayout
                                        animated:YES];
    
    self.centerCellSelectTime = 0.0f;
    self.userImageView.clipsToBounds = YES;
    
    if (self.flowLayout.screenSize.height <= 667) {
        self.userImageBottomConstraint.constant = self.userImageBottomConstraint.constant + kUserImageSmallScreenBottomConstraint;
    }

    NSURL *mixesURL = [NSURL URLWithString:mixesURLString];
    
    [self.activityIndicatorView startAnimating];
    
    ALCodingChallengeNetworkFetcher *sharedFetcher = [ALCodingChallengeNetworkFetcher sharedNetworkFetcher];
    
    [sharedFetcher initializeRequestWithURL:mixesURL
                                 httpMethod:@"GET"
                                 parameters:nil
                           withSuccessBlock:^(NSDictionary *jsonDictionary) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [self.activityIndicatorView stopAnimating];
                                   self.activityIndicatorView.hidden = YES;
                               });
                               
                               if (!self.pageModel && jsonDictionary.count > 0) {
                                   self.pageModel = [ALMixSetPageModel mixSetPageModelWithDictionary:jsonDictionary];
                                   self.flowLayout.cellCount = self.pageModel.mixSetArray.count;
                                   ALMixModel *mixModel = self.pageModel.mixSetArray[0];

                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:mixModel.mixImageNormalResPath]];
                                       
                                       [self.userImageActivityIndicatorView startAnimating];
                                       [self.userImageView sd_setImageWithURL:[NSURL URLWithString:mixModel.mixUserModel.userImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [self.userImageActivityIndicatorView stopAnimating];
                                       }];
                                       
                                       [self.collectionView reloadData];
                                   });
                               } else {
                                   [self displayAlertWithTitle:NSLocalizedString(@"Error", nil)
                                                       message:NSLocalizedString(@"There was an error fetching data for the coding challenge, please try again", @"Network error message")];
                               }
                           }
                           withFailureBlock:^(NSError *error) {
                               [self displayAlertWithTitle:NSLocalizedString(@"Error", nil)
                                                   message:NSLocalizedString(@"There was an error fetching data for the coding challenge, please try again", @"Network error message")];
                           }
     ];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.flowLayout.cellCount ?: 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"MixCell";
    
    ALMixCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    ALMixModel *model = self.pageModel.mixSetArray[indexPath.row];
    
    if (model) {
        cell.authorLabel.text = model.mixUserModel.userName;
        cell.nameLabel.text = model.mixName;
        
        [cell.activityIndicatorView startAnimating];
        [cell.mixImageView sd_setImageWithURL:[NSURL URLWithString:model.mixImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.activityIndicatorView stopAnimating];
        }];
    }
    
    return cell;
}

#pragma mark collection view cell paddings

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.flowLayout.centerCellRect.origin.x, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.flowLayout.centerCellRect.origin.x;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected %@", indexPath);
}

#pragma mark - Collection View Helper Methods

- (ALMixCollectionViewCell *)getMixCellForCurrentCenterIndexPath {
    NSIndexPath *centerIndexPath = [self getIndexPathForCenterMixCell];
    ALMixCollectionViewCell *centerCell = (ALMixCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:centerIndexPath];
    
    return centerCell;
}

- (NSIndexPath *)getIndexPathForCenterMixCell {
    CGPoint centerPoint = CGPointMake(self.flowLayout.screenSize.width / 2 + self.collectionView.contentOffset.x, self.flowLayout.screenSize.width / 2 + self.collectionView.contentOffset.y);
    NSIndexPath *centerIndexPath = [self.collectionView indexPathForItemAtPoint:centerPoint];

    return centerIndexPath;
}

#pragma mark - Handle Collection View Gestures

- (void)longPressedCollectionView:(UILongPressGestureRecognizer *)gesture {
    ALMixCollectionViewCell *cell = [self getMixCellForCurrentCenterIndexPath];
    NSIndexPath *centerPath = [self getIndexPathForCenterMixCell];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform = CGAffineTransformMakeScale(kLongPressCenterCellMaxScale, kLongPressCenterCellMaxScale);
            cell.authorLabel.alpha = 0.0f;
            cell.nameLabel.alpha = 0.0f;
            cell.layer.zPosition = 1.f;
        } completion:^(BOOL finished) {
        }];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform = CGAffineTransformMakeScale(1, 1);
            cell.authorLabel.alpha = 1.0f;
            cell.nameLabel.alpha = 1.0f;
            cell.layer.zPosition = 0.f;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - ScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Scrolled: %@ of ContentSize: %@", NSStringFromCGPoint(scrollView.contentOffset), NSStringFromCGSize(scrollView.contentSize));
    
    NSIndexPath *centerIndexPath = [self getIndexPathForCenterMixCell];
    ALMixCollectionViewCell *centerCell = [self getMixCellForCurrentCenterIndexPath];
    
    // Dont set for 0 because will set when retrieving data model initially
    if (self.centerMixCell != centerCell && centerIndexPath != 0) {
        ALMixModel *mixModel = self.pageModel.mixSetArray[centerIndexPath.row];
        self.centerMixCell = centerCell;
        [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:mixModel.mixImageNormalResPath]];
        
        [self.userImageActivityIndicatorView startAnimating];
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:mixModel.mixUserModel.userImageNormalResPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.userImageActivityIndicatorView stopAnimating];
        }];
    }
    
    
    CGFloat percentScrolled = scrollView.contentOffset.x / scrollView.contentSize.width;
    CGFloat percentToScroll = 1 - percentScrolled;
    CGFloat constraintValue = kDefaultBlurEffectViewConstraint * percentToScroll;
    
    self.blurEffectViewTopConstraint.constant = constraintValue;
    self.blurEffectViewBottomConstraint.constant = constraintValue;
    
    NSLog(@"Percent To Scroll: %f", percentToScroll);
    
    [UIView animateWithDuration:kMixSetNavigationBarBackgroundColorAnimationDuration animations:^{
        self.navigationController.view.backgroundColor = [UIColor colorWithRed:percentToScroll green:percentToScroll blue:percentToScroll alpha:1.f * percentToScroll];
    }];
        
    if (self.isUpdatingPagination == NO && percentToScroll < kLoadPagePercentToScroll) {
        [self fetchNextPage];
        self.isUpdatingPagination = YES;
    }
}

#pragma mark - Pagination Request Method

- (void)fetchNextPage {
    if (self.pageModel.paginationModel.nextPage <= self.pageModel.paginationModel.totalPages) {
        NSString *nextPageIntegerString = [NSString stringWithFormat:@"%li", self.pageModel.paginationModel.nextPage];
        NSString *nextPageString = [paginationMixesURLString stringByReplacingOccurrencesOfString:@"%li" withString:nextPageIntegerString];
        NSURL *nextPageURL = [NSURL URLWithString:nextPageString];
        
        [self.activityIndicatorView startAnimating];
        
        ALCodingChallengeNetworkFetcher *sharedFetcher = [ALCodingChallengeNetworkFetcher sharedNetworkFetcher];
        
        [sharedFetcher initializeRequestWithURL:nextPageURL
                                     httpMethod:@"GET"
                                     parameters:nil
                               withSuccessBlock:^(NSDictionary *jsonDictionary) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [self.activityIndicatorView stopAnimating];
                                       self.activityIndicatorView.hidden = YES;
                                   });
                                   
                                   if (jsonDictionary.count > 0) {
                                       [self.pageModel updateMixSetPageModelWithDictionary:jsonDictionary];
                                       self.flowLayout.cellCount = self.pageModel.mixSetArray.count;
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           self.isUpdatingPagination = NO;
                                           [self.collectionView reloadData];
                                       });
                                   } else {
                                       [self displayAlertWithTitle:NSLocalizedString(@"Error", nil)
                                                           message:NSLocalizedString(@"There was an error fetching data for the coding challenge, please try again", @"Network error message")];
                                   }
                               }
                               withFailureBlock:^(NSError *error) {
                                   [self displayAlertWithTitle:NSLocalizedString(@"Error", nil)
                                                       message:NSLocalizedString(@"There was an error fetching data for the coding challenge, please try again", @"Network error message")];
                               }
         ];
    }
}

#pragma mark - Alert Controller Helper method

- (void)displayAlertWithTitle:(NSString *)title message:(NSString *)message {
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
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
