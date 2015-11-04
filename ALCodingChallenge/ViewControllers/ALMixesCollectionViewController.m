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
#import "ALMixesCollectionViewFlowLayout.h"
#import "ALMixSetPageModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define kDefaultBlurEffectViewConstraint 55.f


@interface ALMixesCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIVisualEffectView *blurEffectView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *blurEffectViewTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *blurEffectViewBottomConstraint;

@property (nonatomic, strong) ALMixesCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) ALMixSetPageModel *pageModel;

@end

@implementation ALMixesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"Coding Challenge", @"Navigation Title for Mixes CollectionVC");
    self.collectionView.backgroundView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.flowLayout = [[ALMixesCollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:self.flowLayout
                                        animated:YES];

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
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
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
    //static NSString *reuseIdentifier = @"TopicCollectionViewCell";
    //TopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
    //forIndexPath:indexPath];
    
    static NSString *reuseIdentifier = @"ColorCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    NSInteger colorInteger = arc4random_uniform(4);
    if (colorInteger == 0) {
        cell.backgroundColor = [UIColor blueColor];
    } else if (colorInteger == 1) {
        cell.backgroundColor = [UIColor redColor];
    } else if (colorInteger == 2) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - ScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Scrolled: %@ of ContentSize: %@", NSStringFromCGPoint(scrollView.contentOffset), NSStringFromCGSize(scrollView.contentSize));
    
    CGFloat percentScrolled = scrollView.contentOffset.x / scrollView.contentSize.width;
    CGFloat percentToScroll = 1 - percentScrolled;
    CGFloat constraintValue = kDefaultBlurEffectViewConstraint * percentToScroll;
    
    self.blurEffectViewTopConstraint.constant = constraintValue;
    self.blurEffectViewBottomConstraint.constant = constraintValue;
    
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
