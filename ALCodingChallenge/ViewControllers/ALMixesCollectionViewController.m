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

@interface ALMixesCollectionViewController ()

@end

@implementation ALMixesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *mixesURL = [NSURL URLWithString:mixesURLString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
