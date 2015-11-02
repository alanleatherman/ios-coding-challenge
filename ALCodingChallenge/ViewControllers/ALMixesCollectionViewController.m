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
#import "ALMixSetPageModel.h"

@interface ALMixesCollectionViewController ()

@property (nonatomic, strong) ALMixSetPageModel *pageModel;

@end

@implementation ALMixesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *mixesURL = [NSURL URLWithString:mixesURLString];
    
    ALCodingChallengeNetworkFetcher *sharedFetcher = [ALCodingChallengeNetworkFetcher sharedNetworkFetcher];
    
    [sharedFetcher initializeRequestWithURL:mixesURL
                                 httpMethod:@"GET"
                                 parameters:nil
                           withSuccessBlock:^(NSDictionary *jsonDictionary) {
                               if (!self.pageModel && jsonDictionary.count > 0) {
                                   self.pageModel = [ALMixSetPageModel mixSetPageModelWithDictionary:jsonDictionary];
                                   
                               }
                           }
                           withFailureBlock:^(NSError *error) {
                               NSLog(@"There was an error retrieving mixes data");
                           }
     ];
}

@end
