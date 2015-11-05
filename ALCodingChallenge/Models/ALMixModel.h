//
//  ALMixModel.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@class ALUserModel;

@interface ALMixModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger mixId;
@property (nonatomic, strong, readonly) ALUserModel *mixUserModel;
@property (nonatomic, copy, readonly)   NSString *mixName;
@property (nonatomic, copy, readonly)   NSString *mixPath;
@property (nonatomic, copy, readonly)   NSString *mixWebPath;
@property (nonatomic, copy, readonly)   NSString *mixImageLowResPath;
@property (nonatomic, copy, readonly)   NSString *mixImageNormalResPath;
@property (nonatomic, copy, readonly)   NSString *mixImageHighResPath;

+ (ALMixModel *)createMixModelWithDictionary:(NSDictionary *)mixDictionary;
- (instancetype)initMixModelWithId:(NSUInteger)mixId
                      mixUserModel:(ALUserModel *)mixUserModel
                           mixName:(NSString *)mixName
                           mixPath:(NSString *)mixPath
                        mixWebPath:(NSString *)mixWebPath
                mixImageLowResPath:(NSString *)lowResPath
             mixImageNormalResPath:(NSString *)normalResPath
               mixImageHighResPath:(NSString *)highResPath;

@end
