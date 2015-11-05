//
//  ALMixSetPaginationModel.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@interface ALMixSetPaginationModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger currentPage;
@property (nonatomic, assign, readonly) NSUInteger mixesPerPage;
@property (nonatomic, assign, readonly) NSUInteger previousPage;
@property (nonatomic, assign, readonly) NSUInteger nextPage;
@property (nonatomic, assign, readonly) NSUInteger totalPages;
@property (nonatomic, copy, readonly)   NSString   *nextPagePath;

- (instancetype)initMixSetPaginationModelWithCurrentPage:(NSUInteger)currentPage
                                            mixesPerPage:(NSUInteger)mixesPerPage
                                            previousPage:(NSUInteger)previousPage
                                                nextPage:(NSUInteger)nextPage
                                              totalPages:(NSUInteger)totalPages
                                            nextPagePath:(NSString *)nextPagePath;
- (void)updateMixSetPaginationModelWithCurrentPage:(NSUInteger)currentPage
                                      previousPage:(NSUInteger)previousPage
                                          nextPage:(NSUInteger)nextPage;

@end
