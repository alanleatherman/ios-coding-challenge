//
//  ALMixSetPaginationModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixSetPaginationModel.h"
#import "ALCodingChallengeHelpers.h"

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

- (void)updateMixSetPaginationModelWithDictionary:(NSDictionary *)jsonDictionary {
    if (jsonDictionary.count > 0) {
        self.currentPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"current_page"]] ? [jsonDictionary[@"current_page"] unsignedIntegerValue] : self.currentPage;
        self.mixesPerPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"per_page"]] ? [jsonDictionary[@"per_page"] unsignedIntegerValue] : self.mixesPerPage;
        self.previousPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"previous_page"]] ? [jsonDictionary[@"previous_page"] unsignedIntegerValue] : self.previousPage;
        self.nextPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"next_page"]] ? [jsonDictionary[@"next_page"] unsignedIntegerValue] : self.nextPage;
        self.totalPages = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"total_pages"]] ? [jsonDictionary[@"total_pages"] unsignedIntegerValue] : self.totalPages;
        
        self.nextPagePath = jsonDictionary[@"next_page_path"] ?: self.nextPagePath;
    }
}

@end
