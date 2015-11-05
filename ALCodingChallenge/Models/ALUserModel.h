//
//  ALUserModel.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 11/4/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@interface ALUserModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger userId;
@property (nonatomic, copy, readonly)   NSString *userName;
@property (nonatomic, copy, readonly)   NSString *userPath;
@property (nonatomic, copy, readonly)   NSString *userWebPath;
@property (nonatomic, copy, readonly)   NSString *userImageLowResPath;
@property (nonatomic, copy, readonly)   NSString *userImageNormalResPath;
@property (nonatomic, copy, readonly)   NSString *userImageHighResPath;

- (instancetype) initUserModelWithUserId:(NSUInteger)userId
                                userName:(NSString *)userName
                                userPath:(NSString *)userPath
                             userWebPath:(NSString *)userWebPath
                              lowResPath:(NSString *)lowResPath
                           normalResPath:(NSString *)normalResPath
                             highResPath:(NSString *)highResPath;

@end
