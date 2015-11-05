//
//  MixSetPageModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixSetPageModel.h"
#import "ALMixModel.h"
#import "ALMixSetPaginationModel.h"
#import "ALUserModel.h"
#import "ALCodingChallengeHelpers.h"

@interface ALMixSetPageModel ()

@property (nonatomic, copy)   NSArray *mixSetArray;
@property (nonatomic, copy)   NSString *mixSetName;
@property (nonatomic, copy)   NSString *mixSetPath;
@property (nonatomic, copy)   NSString *mixSetWebPath;
@property (nonatomic, copy)   ALMixSetPaginationModel *paginationModel;
@property (nonatomic, assign) BOOL isLoggedIn;

@end

@implementation ALMixSetPageModel

+ (ALMixSetPageModel *)mixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary {
    ALMixSetPageModel *pageModel;
    ALMixSetPaginationModel *paginationModel;
    NSMutableArray *mixSetsArray;
    NSString *mixSetName, *mixSetPath, *mixSetWebPath;
    BOOL isLoggedIn;
    
    if (jsonDictionary.count > 0) {
        // Use helper method to check if valid value before calling unsignedIntegerValue (will crash if null)
        isLoggedIn = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"logged_in"]] ? [jsonDictionary[@"logged_in"] boolValue] : NO;
    
        NSDictionary *mixSetDictionary = jsonDictionary[@"mix_set"];
        
        if (mixSetDictionary.count > 0) {
            mixSetName = mixSetDictionary[@"name"] ?: @"";
            mixSetPath = mixSetDictionary[@"path"] ?: @"";
            mixSetWebPath = mixSetDictionary[@"web_path"] ?: @"";
            
            NSDictionary *mixDictionary = mixSetDictionary[@"mixes"];
            mixSetsArray = [[NSMutableArray alloc] initWithCapacity:mixDictionary.count];
            
            ALMixModel *mixModel;
            
            for (NSDictionary *mix in mixDictionary) {
                mixModel = [ALMixModel createMixModelWithDictionary:mix];
                
                [mixSetsArray addObject:mixModel];
            }
        
            NSDictionary *paginationDictionary = mixSetDictionary[@"pagination"];
            
            if (paginationDictionary.count > 0) {
                NSUInteger currentPage, mixesPerPage, previousPage, nextPage, totalPages;
                NSString *nextPagePath;
                
                // Use helper method to check if valid value before calling unsignedIntegerValue (will crash if null)
                currentPage = [ALCodingChallengeHelpers isValidValue:paginationDictionary[@"current_page"]] ? [paginationDictionary[@"current_page"] unsignedIntegerValue] : 0;
                mixesPerPage = [ALCodingChallengeHelpers isValidValue:paginationDictionary[@"per_page"]] ? [paginationDictionary[@"per_page"] unsignedIntegerValue] : 0;
                previousPage = [ALCodingChallengeHelpers isValidValue:paginationDictionary[@"previous_page"]] ? [paginationDictionary[@"previous_page"] unsignedIntegerValue] : 0;
                nextPage = [ALCodingChallengeHelpers isValidValue:paginationDictionary[@"next_page"]] ? [paginationDictionary[@"next_page"] unsignedIntegerValue] : 0;
                totalPages = [ALCodingChallengeHelpers isValidValue:paginationDictionary[@"total_pages"]] ? [paginationDictionary[@"total_pages"] unsignedIntegerValue] : 0;
                
                nextPagePath = paginationDictionary[@"next_page_path"] ?: @"";
                
                paginationModel = [[ALMixSetPaginationModel alloc] initMixSetPaginationModelWithCurrentPage:currentPage
                                                                                               mixesPerPage:mixesPerPage
                                                                                               previousPage:previousPage
                                                                                                   nextPage:nextPage
                                                                                                 totalPages:totalPages
                                                                                               nextPagePath:nextPagePath];
            }
        }
    }
    
    pageModel = [[ALMixSetPageModel alloc] initMixSetPageModelWithMixSetArray:[mixSetsArray copy]
                                                                   mixSetName:mixSetName
                                                                   mixSetPath:mixSetPath
                                                                mixSetWebPath:mixSetWebPath
                                                              paginationModel:paginationModel
                                                                   isLoggedIn:isLoggedIn];
    
    return pageModel;
}

- (instancetype)initMixSetPageModelWithMixSetArray:(NSArray *)mixSets
                                        mixSetName:(NSString *)name
                                        mixSetPath:(NSString *)path
                                     mixSetWebPath:(NSString *)webPath
                                   paginationModel:(ALMixSetPaginationModel *)pagination
                                        isLoggedIn:(BOOL)loggedIn {
    self = [super init];
    
    if (self) {
        _mixSetArray = mixSets;
        _mixSetName = name;
        _mixSetPath = path;
        _mixSetWebPath = webPath;
        _paginationModel = pagination;
        _isLoggedIn = self.isLoggedIn;
    }
    
    return self;
}


- (void)updateMixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary {
    NSArray *mixes = jsonDictionary[@"mixes"];
    NSMutableArray *mixSetsArray;
    
    if (mixes.count > 0) {
        mixSetsArray = [[NSMutableArray alloc] initWithArray:self.mixSetArray];
        ALMixModel *mixModel;
        
        for (NSDictionary *mix in mixes) {
            mixModel = [ALMixModel createMixModelWithDictionary:mix];
            [mixSetsArray addObject:mixModel];
        }
        
        self.mixSetArray = [mixSetsArray copy];
    }
    
    NSUInteger currentPage, nextPage, previousPage;
    
    currentPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"page"]] ? [jsonDictionary[@"page"] unsignedIntegerValue] : 0;
    nextPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"next_page"]] ? [jsonDictionary[@"next_page"] unsignedIntegerValue] : 0;
    previousPage = [ALCodingChallengeHelpers isValidValue:jsonDictionary[@"previous_page"]] ? [jsonDictionary[@"previous_page"] unsignedIntegerValue] : 0;

    [self.paginationModel updateMixSetPaginationModelWithCurrentPage:currentPage
                                                        previousPage:previousPage
                                                            nextPage:nextPage];
    
}

@end
