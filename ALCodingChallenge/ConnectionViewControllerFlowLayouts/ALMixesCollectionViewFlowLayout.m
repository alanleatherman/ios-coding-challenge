//
//  ALMixesCollectionViewFlowLayout.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/4/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixesCollectionViewFlowLayout.h"

#define kCellWidth 225.f
#define kCellHeight 300.f

@interface ALMixesCollectionViewFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

@property (nonatomic, strong) NSMutableSet *visibleIndexPathsSet;
@property (nonatomic, assign) CGFloat latestDelta;

@property (nonatomic, assign) BOOL isLayingOutAfterCenterCell;
@property (nonatomic, assign) BOOL isLayingOutCenterCell;

@end

@implementation ALMixesCollectionViewFlowLayout

-(id)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = 25;
        self.minimumLineSpacing = 25;
        self.itemSize = CGSizeMake(kCellWidth, kCellHeight);
        self.sectionInset = UIEdgeInsetsMake(50, 0, 0, 0);
        
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
    
    CGPoint finalPoint = CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    
    return finalPoint;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    self.isLayingOutAfterCenterCell = NO;
    self.isLayingOutCenterCell = NO;
    
    NSMutableArray *newAttributes = [NSMutableArray arrayWithCapacity:layoutAttributes.count];
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        // If modifying attributes for center cell change
        
        /*
        if (attributes.indexPath == [self.collectionView indexPathForItemAtPoint:CGPointMake(self.screenSize.width / 2, self.screenSize.height / 2)]) {
            self.isLayingOutAfterCenterCell = YES;
            self.isLayingOutCenterCell = YES;
        }
         */
        
        //[self modifyLayoutAttributes:attributes];
        
        if ((attributes.frame.origin.x + attributes.frame.size.width <= self.collectionViewContentSize.width) &&
            (attributes.frame.origin.y + attributes.frame.size.height <= self.collectionViewContentSize.height)) {
            [newAttributes addObject:attributes];
        }
    }
    
    return newAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)modifyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if (!self.isLayingOutCenterCell) {
        //CATransform3D cellTransform = CATransform3DIdentity;
        //cellTransform = CATransform3DScale(cellTransform, 0.7, 0.7, 1.0);
        //cellTransform = CATransform3DRotate(cellTransform, M_PI_2, 0, 0, 1);
    
        //attributes.transform3D = cellTransform;
        
        attributes.alpha = 0.5f;
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake((self.cellCount * self.itemSize.width) - self.centerCellRect.origin.x, self.collectionView.frame.size.height);
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    return [self initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    
    return attributes;
}

@end
