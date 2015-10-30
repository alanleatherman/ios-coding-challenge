//
//  ALMixModel.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

@interface ALMixModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger mixId;
@property (nonatomic, assign, readonly) NSUInteger mixUserId;
@property (nonatomic, copy, readonly)   NSString *mixName;
@property (nonatomic, copy, readonly)   NSString *mixPath;
@property (nonatomic, copy, readonly)   NSString *mixWebPath;
@property (nonatomic, copy, readonly)   NSString *mixImageLowResPath;
@property (nonatomic, copy, readonly)   NSString *mixImageNormalResPath;
@property (nonatomic, copy, readonly)   NSString *mixImageHighResPath;

- (instancetype)initMixModelWithId:(NSUInteger)mixId
                         mixUserid:(NSUInteger)mixUserId
                           mixName:(NSString *)mixName
                           mixPath:(NSString *)mixPath
                        mixWebPath:(NSString *)mixWebPath
                mixImageLowResPath:(NSString *)lowResPath
             mixImageNormalResPath:(NSString *)normalResPath
               mixImageHighResPath:(NSString *)highResPath;

@end
