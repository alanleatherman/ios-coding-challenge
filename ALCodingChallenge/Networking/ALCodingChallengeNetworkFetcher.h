//
//  ALCodingChallengeNetworkFetcher.h
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

typedef void (^SuccessBlock)(NSDictionary *);
typedef void (^FailureBlock)(NSError *);

@interface ALCodingChallengeNetworkFetcher : NSObject

+ (instancetype)sharedNetworkFetcher;

- (void)initializeRequestWithURL:(NSURL *)url
                withSuccessBlock:(SuccessBlock)completion;
- (void)initializeRequestWithURL:(NSURL *)url
                      httpMethod:(NSString *)method
                      parameters:(NSDictionary *)parameters
                withSuccessBlock:(SuccessBlock)success
                withFailureBlock:(FailureBlock)failure;

@end
