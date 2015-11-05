//
//  ALZoomInteractiveTransition.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/5/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//
//  Built upon ZoomTransition by Denys Telezhkin on 29.06.14.
//  Available on Github at: https://github.com/DenHeadless/ZoomInteractiveTransition

typedef void(^ZoomAnimationBlock)(UIImageView * animatedSnapshot, UIView * sourceView, UIView * destinationView);

@protocol ALZoomTransitionProtocol <NSObject>
-(UIView *)viewForZoomTransition:(BOOL)isSource;
@optional
-(UIImageView *)initialZoomViewSnapshotFromProposedSnapshot:(UIImageView *)snapshot;
-(ZoomAnimationBlock)animationBlockForZoomTransition;
@end

@interface ALZoomInteractiveTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) CGFloat transitionDuration;
@property (nonatomic, assign) BOOL handleEdgePanBackGesture;
@property (nonatomic, assign) UIViewKeyframeAnimationOptions transitionAnimationOption;

- (instancetype)initWithNavigationController:(UINavigationController *)nc;
- (void)resetDelegate;

@end

