//
//  ALUserModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/4/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALUserModel.h"

@interface ALUserModel ()

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *userPath;
@property (nonatomic, copy)   NSString *userWebPath;
@property (nonatomic, copy)   NSString *userImageLowResPath;
@property (nonatomic, copy)   NSString *userImageNormalResPath;
@property (nonatomic, copy)   NSString *userImageHighResPath;

@end

@implementation ALUserModel

- (instancetype) initUserModelWithUserId:(NSUInteger)userId
                                userName:(NSString *)userName
                                userPath:(NSString *)userPath
                             userWebPath:(NSString *)userWebPath
                              lowResPath:(NSString *)lowResPath
                           normalResPath:(NSString *)normalResPath
                             highResPath:(NSString *)highResPath {
    self = [super init];
    
    if (self) {
        _userId = userId;
        _userName = userName;
        _userPath = userPath;
        _userWebPath = userWebPath;
        _userImageLowResPath = lowResPath;
        _userImageNormalResPath = normalResPath;
        _userImageHighResPath = highResPath;
    }
    
    return self;
}

@end
