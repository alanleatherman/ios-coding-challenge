//
//  ALMixSetPageModel.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@class ALMixSetPaginationModel;

@interface ALMixSetPageModel : NSObject

@property (nonatomic, copy, readonly)   NSArray *mixSetArray;
@property (nonatomic, copy, readonly)   NSString *mixSetName;
@property (nonatomic, copy, readonly)   NSString *mixSetPath;
@property (nonatomic, copy, readonly)   NSString *mixSetWebPath;
@property (nonatomic, copy, readonly)   ALMixSetPaginationModel *paginationModel;
@property (nonatomic, assign, readonly) BOOL isLoggedIn;

+ (ALMixSetPageModel *)mixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary;
- (instancetype)initMixSetPageModelWithMixSetArray:(NSArray *)mixSets
                                        mixSetName:(NSString *)name
                                        mixSetPath:(NSString *)path
                                     mixSetWebPath:(NSString *)webPath
                                   paginationModel:(ALMixSetPaginationModel *)pagination
                                        isLoggedIn:(BOOL)loggedIn;
- (void)updateMixSetPageModelWithDictionary:(NSDictionary *)jsonDictionary;

@end
