//
//  ALMixCollectionViewCell.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/4/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@interface ALMixCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UIImageView *mixImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end
