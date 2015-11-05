//
//  ALMixModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixModel.h"

#import "ALCodingChallengeHelpers.h"
#import "ALUserModel.h"

@interface ALMixModel ()

@property (nonatomic, assign) NSUInteger mixId;
@property (nonatomic, strong) ALUserModel *mixUserModel;;
@property (nonatomic, copy)   NSString *mixName;
@property (nonatomic, copy)   NSString *mixPath;
@property (nonatomic, copy)   NSString *mixWebPath;
@property (nonatomic, copy)   NSString *mixImageLowResPath;
@property (nonatomic, copy)   NSString *mixImageNormalResPath;
@property (nonatomic, copy)   NSString *mixImageHighResPath;

@end

@implementation ALMixModel

+ (ALMixModel *)createMixModelWithDictionary:(NSDictionary *)mixDictionary {
    ALMixModel *mixModel;
    ALUserModel *userModel;
    NSDictionary *userDictionary, *userMixCoverURLsDictionary, *mixCoverURLsDictionary;
    NSUInteger mixId, mixUserId = 0;
    NSString *mixName, *mixPath, *mixWebPath, *mixImageLowResPath, *mixImageNormalResPath, *mixImageHighResPath;
    NSString *userName, *userPath, *userWebPath, *userLowResPath, *userNormalResPath, *userHighResPath;
    
    userDictionary = mixDictionary[@"user"];
    
    if (userDictionary.count > 0) {
        // Use helper method to check if valid value before calling unsignedIntegerValue (will crash if null)
        mixUserId = [ALCodingChallengeHelpers isValidValue:userDictionary[@"id"]] ? [userDictionary[@"id"] unsignedIntegerValue] : 0;
        userName = userDictionary[@"login"] ?: @"";
        userPath = userDictionary[@"path"] ?: @"";
        userWebPath = userDictionary[@"web_path"] ?: @"";
        
        userMixCoverURLsDictionary = userDictionary[@"avatar_urls"];
        userLowResPath = userMixCoverURLsDictionary[@"sq100"] ?: @"";
        userNormalResPath = userMixCoverURLsDictionary[@"cropped_imgix_url"] ?: @"";
        userHighResPath = userMixCoverURLsDictionary[@"max1024"] ?: @"";
        
        userModel = [[ALUserModel alloc] initUserModelWithUserId:mixUserId
                                                        userName:userName
                                                        userPath:userPath
                                                     userWebPath:userWebPath
                                                      lowResPath:userLowResPath
                                                   normalResPath:userNormalResPath
                                                     highResPath:userHighResPath];
    }
    
    mixId = [ALCodingChallengeHelpers isValidValue:mixDictionary[@"id"]] ? [mixDictionary[@"id"] unsignedIntegerValue] : 0;
    mixName = mixDictionary[@"name"] ?: @"";
    mixPath = mixDictionary[@"path"] ?: @"";
    mixWebPath = mixDictionary[@"web_path"] ?: @"";
    
    mixCoverURLsDictionary =  mixDictionary[@"cover_urls"];
    
    if (mixCoverURLsDictionary.count > 0) {
        mixImageLowResPath = mixCoverURLsDictionary[@"sq100"] ?: @"";
        mixImageNormalResPath = mixCoverURLsDictionary[@"cropped_imgix_url"] ?: @"";
        mixImageHighResPath = mixCoverURLsDictionary[@"max1024"] ?: @"";
    }
    
    
    mixModel = [[ALMixModel alloc] initMixModelWithId:mixId
                                         mixUserModel:userModel
                                              mixName:mixName
                                              mixPath:mixPath
                                           mixWebPath:mixWebPath
                                   mixImageLowResPath:mixImageLowResPath
                                mixImageNormalResPath:mixImageNormalResPath
                                  mixImageHighResPath:mixImageHighResPath];
    
    return mixModel;
}


- (instancetype)initMixModelWithId:(NSUInteger)mixId
                      mixUserModel:(ALUserModel *)mixUserModel
                           mixName:(NSString *)mixName
                           mixPath:(NSString *)mixPath
                        mixWebPath:(NSString *)mixWebPath
                mixImageLowResPath:(NSString *)lowResPath
             mixImageNormalResPath:(NSString *)normalResPath
               mixImageHighResPath:(NSString *)highResPath {
    self = [super init];
    
    if (self) {
        _mixId = mixId;
        _mixUserModel = mixUserModel;
        _mixName = mixName;
        _mixPath = mixPath;
        _mixWebPath = mixWebPath;
        _mixImageLowResPath = lowResPath;
        _mixImageNormalResPath = normalResPath;
        _mixImageHighResPath = highResPath;
    }
    
    return self;
}

@end
