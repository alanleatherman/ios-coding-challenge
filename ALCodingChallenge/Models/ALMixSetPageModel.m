//
//  MixSetPageModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixSetPageModel.h"

@interface ALMixSetPageModel ()

@property (nonatomic, copy)   NSArray *mixSetArray;
@property (nonatomic, copy)   NSString *mixSetName;
@property (nonatomic, copy)   NSString *mixSetPath;
@property (nonatomic, copy)   ALMixSetPaginationModel *paginationModel;
@property (nonatomic, assign) BOOL isLoggedIn;

@end

@implementation ALMixSetPageModel

- (instancetype)initMixSetPageModelWithMixSetArray:(NSArray *)mixSets
                                        mixSetName:(NSString *)name
                                        mixSetPath:(NSString *)path
                                   paginationModel:(ALMixSetPaginationModel *)pagination
                                        isLoggedIn:(BOOL)loggedIn {
    self = [super init];
    
    if (self) {
        _mixSetArray = mixSets;
        _mixSetName = name;
        _mixSetPath = path;
        _paginationModel = pagination;
        _isLoggedIn = self.isLoggedIn;
    }
    
    return self;
}

@end
