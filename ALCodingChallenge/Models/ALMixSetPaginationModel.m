//
//  ALMixSetPaginationModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixSetPaginationModel.h"

@interface ALMixSetPaginationModel ()

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger mixesPerPage;
@property (nonatomic, assign) NSUInteger previousPage;
@property (nonatomic, assign) NSUInteger nextPage;
@property (nonatomic, assign) NSUInteger totalPages;
@property (nonatomic, copy)   NSString   *nextPagePath;

@end

@implementation ALMixSetPaginationModel

- (instancetype)initMixSetPaginationModelWithCurrentPage:(NSUInteger)currentPage
                                            mixesPerPage:(NSUInteger)mixesPerPage
                                            previousPage:(NSUInteger)previousPage
                                                nextPage:(NSUInteger)nextPage
                                              totalPages:(NSUInteger)totalPages
                                            nextPagePath:(NSString *)nextPagePath {
    self = [super init];
    
    if (self) {
        _currentPage = currentPage;
        _mixesPerPage = mixesPerPage;
        _previousPage = previousPage;
        _nextPage = nextPage;
        _totalPages = totalPages;
        _nextPagePath = nextPagePath;
    }
    
    return self;
}

@end
