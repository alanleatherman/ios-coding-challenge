//
//  ALMixModel.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALMixModel.h"

@interface ALMixModel ()

@property (nonatomic, assign) NSUInteger mixId;
@property (nonatomic, assign) NSUInteger mixUserId;
@property (nonatomic, copy)   NSString *mixName;
@property (nonatomic, copy)   NSString *mixPath;
@property (nonatomic, copy)   NSString *mixWebPath;
@property (nonatomic, copy)   NSString *mixImageLowResPath;
@property (nonatomic, copy)   NSString *mixImageNormalResPath;
@property (nonatomic, copy)   NSString *mixImageHighResPath;

@end

@implementation ALMixModel

- (instancetype)initMixModelWithId:(NSUInteger)mixId
                         mixUserid:(NSUInteger)mixUserId
                           mixName:(NSString *)mixName
                           mixPath:(NSString *)mixPath
                        mixWebPath:(NSString *)mixWebPath
                mixImageLowResPath:(NSString *)lowResPath
             mixImageNormalResPath:(NSString *)normalResPath
               mixImageHighResPath:(NSString *)highResPath {
    self = [super init];
    
    if (self) {
        _mixId = mixId;
        _mixUserId = mixUserId;
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
