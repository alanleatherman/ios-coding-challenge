//
//  ALMixesCollectionViewFlowLayout.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/4/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixesCollectionViewFlowLayout.h"

#define kCellWidth 275.f
#define kCellHeight 300.f

@interface ALMixesCollectionViewFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

@property (nonatomic, strong) NSMutableSet *visibleIndexPathsSet;
@property (nonatomic, assign) CGFloat latestDelta;


@end

@implementation ALMixesCollectionViewFlowLayout

-(id)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = 25;
        self.minimumLineSpacing = 25;
        self.itemSize = CGSizeMake(kCellWidth, kCellHeight);
        self.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
        
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        _visibleIndexPathsSet = [NSMutableSet set];
        
        _screenSize = [[UIScreen mainScreen] bounds].size;
        
        _centerCellRect = CGRectMake((_screenSize.width - kCellWidth) / 2,
                                     _screenSize.height / 4,
                                     kCellWidth,
                                     kCellHeight);
        
        
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter;
    
    horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake((self.cellCount * self.itemSize.width) + (kCellWidth * 1.5), self.collectionView.frame.size.height);
}

@end
