//
//  ABAPI.m
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import "ABAPI.h"
#import <AFNetworking/AFNetworking.h>

@implementation ABAPI

+ (void)get:(NSString *)path setHeader:(NSDictionary *)header setParameter:(NSDictionary *)params progress:(APIProgressBlock)progressBlock completion:(APIResponseBlock)completionBlock {
    
    if ([ABAPIConstants isValidPath:path]) {
        AFHTTPSessionManager *manager = [ABAPI requestManagerWithHeader:header];
        
        [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progressBlock) progressBlock(downloadProgress.fractionCompleted);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithSuccessTask:task responseObject:responseObject];
            
            if(completionBlock) completionBlock(response, nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithFailureTask:task error:error];
            
            if(completionBlock) completionBlock(response, error);
            
        }];
    }
    
}

+ (void)post:(NSString *)path setHeader:(NSDictionary *)header setParameter:(NSDictionary *)params progress:(APIProgressBlock)progressBlock completion:(APIResponseBlock)completionBlock {
    
    if ([ABAPIConstants isValidPath:path]) {
        AFHTTPSessionManager *manager = [ABAPI requestManagerWithHeader:header];
        
        [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progressBlock) progressBlock(uploadProgress.fractionCompleted);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithSuccessTask:task responseObject:responseObject];
            
            if(completionBlock) completionBlock(response, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithFailureTask:task error:error];
            
            if(completionBlock) completionBlock(response, error);
        }];
    }
    
}

+ (void)put:(NSString *)path setHeader:(NSDictionary *)header setParameter:(NSDictionary *)params completion:(APIResponseBlock)completionBlock {
    
    if ([ABAPIConstants isValidPath:path]) {
        AFHTTPSessionManager *manager = [ABAPI requestManagerWithHeader:header];
        
        [manager PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithSuccessTask:task responseObject:responseObject];
            
            if(completionBlock) completionBlock(response, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithFailureTask:task error:error];
            
            if(completionBlock) completionBlock(response, error);
        }];
    }
    
}

+ (void)del:(NSString *)path setHeader:(NSDictionary *)header setParameter:(NSDictionary *)params completion:(APIResponseBlock)completionBlock {
    
    if ([ABAPIConstants isValidPath:path]) {
        AFHTTPSessionManager *manager = [ABAPI requestManagerWithHeader:header];
        
        [manager DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithSuccessTask:task responseObject:responseObject];
            
            if(completionBlock) completionBlock(response, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithFailureTask:task error:error];
            
            if(completionBlock) completionBlock(response, error);
        }];
    }
    
}

+ (AFHTTPSessionManager *)requestManagerWithHeader:(NSDictionary *)header {
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [ABAPI userAgent];
    
    if ([ABAPIConstants notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
//    NSMutableIndexSet *acceptedCodes = [[NSMutableIndexSet alloc]
//                                        initWithIndexSet:manager.responseSerializer.acceptableStatusCodes];
//    [acceptedCodes addIndex:404];
//    [acceptedCodes addIndex:409];
//    
//    manager.responseSerializer.acceptableStatusCodes = [acceptedCodes copy];
    
    if ([ABAPIConstants notNull:header]) {
        for(id key in header) {
            if ([ABAPIConstants notNull:[header objectForKey:key]]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
    }
    
    
    return manager;
}

+ (NSString *)userAgent {
    return nil;
}

@end
