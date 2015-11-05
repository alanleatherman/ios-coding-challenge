//
//  MixDetailViewController.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/5/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@class ALMixModel;

@interface ALMixDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *mixImageView;

- (void)initilizeWithMixModel:(ALMixModel *)mixModel;

@end
