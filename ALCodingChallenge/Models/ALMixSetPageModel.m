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

@interface ALMixSetPageModel ()

@property (nonatomic, copy)   NSArray *mixSetArray;
@property (nonatomic, copy)   NSString *mixSetName;
@property (nonatomic, copy)   NSString *mixSetPath;
@property (nonatomic, copy)   ALMixSetPaginationModel *paginationModel;
@property (nonatomic, assign) BOOL isLoggedIn;

@end

@implementation ALMixSetPageModel

+ (ALMixSetPageModel *)mixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary {
    ALMixSetPageModel *pageModel;
    ALMixSetPaginationModel *paginationModel;
    NSMutableArray *mixSetsArray;
    NSString *mixSetName, *mixSetPath;
    BOOL isLoggedIn;
    
    NSDictionary *mixSetDictionary = jsonDictionary[@"mix_set"];
    
    if (mixSetDictionary.count > 0) {
        NSDictionary *mixDictionary = mixSetDictionary[@"mixes"];
        
        ALMixModel *mixModel;
        mixSetsArray = [[NSMutableArray alloc] initWithCapacity:mixDictionary.count];
        NSDictionary *userDictionary, *mixCoverURLsDictionary;
        NSUInteger mixId, mixUserId = 0;
        NSString *mixName, *mixPath, *mixWebPath, *mixImageLowResPath, *mixImageNormalResPath, *mixImageHighResPath;
        
        for (NSDictionary *mix in mixDictionary) {
            userDictionary = mix[@"user"];
            
            if (userDictionary.count > 0) {
                mixUserId = [userDictionary[@"id"] unsignedIntegerValue] ?: 0;
            }
            
            mixId = [mix[@"id"] unsignedIntegerValue] ?: 0;
            mixName = mix[@"name"] ?: @"";
            mixPath = mix[@"path"] ?: @"";
            mixWebPath = mix[@"web_path"] ?: @"";
            
            mixCoverURLsDictionary =  mix[@"cover_urls"];
            
            if (mixCoverURLsDictionary.count > 0) {
                mixImageLowResPath = mix[@"sq100"] ?: @"";
                mixImageNormalResPath = mix[@"cropped_imgix_url"] ?: @"";
                mixImageHighResPath = mix[@"max1024"] ?: @"";
            }
            
            
            mixModel = [[ALMixModel alloc] initMixModelWithId:mixId
                                                    mixUserid:mixUserId
                                                      mixName:mixName
                                                      mixPath:mixPath
                                                   mixWebPath:mixWebPath
                                           mixImageLowResPath:mixImageLowResPath
                                        mixImageNormalResPath:mixImageNormalResPath
                                          mixImageHighResPath:mixImageHighResPath];
            [mixSetsArray addObject:mixModel];
        }
    }
    
    NSDictionary *paginationDictionary = jsonDictionary[@"pagination"];
    
    if (paginationDictionary.count > 0) {
        NSUInteger currentPage, mixesPerPage, previousPage, nextPage, totalPages;
        NSString *nextPagePath;
        
        currentPage = [paginationDictionary[@"current_page"] unsignedIntegerValue] ?: 0;
        mixesPerPage = [paginationDictionary[@"per_page"] unsignedIntegerValue] ?: 0;
        previousPage = [paginationDictionary[@"previous_page"] unsignedIntegerValue] ?: 0;
        nextPage = [paginationDictionary[@"next_page"] unsignedIntegerValue] ?: 0;
        totalPages = [paginationDictionary[@"total_pages"] unsignedIntegerValue] ?: 0;
        
        nextPagePath = paginationDictionary[@"next_page_path"] ?: @"";
        
        paginationModel = [[ALMixSetPaginationModel alloc] initMixSetPaginationModelWithCurrentPage:currentPage
                                                                                       mixesPerPage:mixesPerPage
                                                                                       previousPage:previousPage
                                                                                           nextPage:nextPage
                                                                                         totalPages:totalPages
                                                                                       nextPagePath:nextPagePath];
    }
    
    pageModel = [[ALMixSetPageModel alloc] initMixSetPageModelWithMixSetArray:mixSetsArray
                                                                   mixSetName:mixSetName
                                                                   mixSetPath:mixSetPath
                                                              paginationModel:paginationModel
                                                                   isLoggedIn:isLoggedIn];
    
    return pageModel;
}

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

- (void)updateMixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary {
    
}

@end
