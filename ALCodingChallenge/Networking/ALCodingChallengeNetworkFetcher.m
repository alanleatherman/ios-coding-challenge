//
//  ALCodingChallengeNetworkFetcher.m
//  ALCodingChallenge
//
//  Created by Alan Leatherman on 10/29/15.
//  Copyright © 2015 Alan Leatherman. All rights reserved.
//

#import "ALCodingChallengeNetworkFetcher.h"

@interface ALCodingChallengeNetworkFetcher ()

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation ALCodingChallengeNetworkFetcher

+ (instancetype)sharedNetworkFetcher {
    static ALCodingChallengeNetworkFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)initializeRequestWithURL:(NSURL *)url
                withSuccessBlock:(SuccessBlock)completion {
    [self initializeRequestWithURL:url
                        httpMethod:@"GET"
                        parameters:nil
                  withSuccessBlock:completion
                  withFailureBlock:nil];
}

- (void)initializeRequestWithURL:(NSURL *)url
                      httpMethod:(NSString *)method
                      parameters:(NSDictionary *)parameters
                withSuccessBlock:(SuccessBlock)success
                withFailureBlock:(FailureBlock)failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = method;
    
    for (NSString *key in parameters.allKeys) {
        if ([key isKindOfClass:[NSString class]]) {
            [request setValue:parameters[key] forHTTPHeaderField:key];
        }
    }
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    [[sharedSession dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                          if (error) {
                              failure(error);
                          } else {
                              NSError *completionError;
                              NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                 options:kNilOptions
                                                                                                   error:&completionError];
                              success(responseDictionary);
                          }
                      }] resume];
}

@end
