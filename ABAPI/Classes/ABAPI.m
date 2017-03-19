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

+ (NSString *)endpoint {
    return @"https://api-artavenue.tapt.io/";
}

+ (NSString *)version {
    return @"v0";
}


-(void)get:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if ([ABAPI notNull:url]) {
        NSString *path = [[[ABAPI endpoint] stringByAppendingString:[ABAPI version]] stringByAppendingString:url];
        
        AFHTTPSessionManager *manager = [self requestManagerWithHeader:header];
        
        [manager GET:path parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithTask:task responseObject:responseObject];
            
            if(block) {
                block(response, nil);
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithOperation:operation error:error];
            
            if(block) {
                block(response, nil);
            }
        }];
    } else {
        NSLog(@"URL is nil/null");
    }
    
}

-(void)post:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if ([ABAPI notNull:url]) {
        NSString *path = [[[ABAPI endpoint] stringByAppendingString:[ABAPI version]] stringByAppendingString:url];
        
        ABResponseObject *response = [[ABResponseObject alloc] init];
        
        AFHTTPSessionManager *manager = [self requestManagerWithHeader:header];
        
        
        [manager POST:path parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithTask:task responseObject:responseObject];
            
            if(block) {
                block(response, nil);
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithOperation:operation error:error];
            
            if(block) {
                block(response, nil);
            }
        }];
    } else {
        NSLog(@"URL is nil/null");
    }
    
    
    
}

-(void)put:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if ([ABAPI notNull:url]) {
        NSString *path = [[[ABAPI endpoint] stringByAppendingString:[ABAPI version]]stringByAppendingString:url];
        
        ABResponseObject *response = [[ABResponseObject alloc] init];
        
        AFHTTPSessionManager *manager = [self requestManagerWithHeader:header];
        
        [manager PUT:path parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithTask:task responseObject:responseObject];
            
            if(block) {
                block(response, nil);
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithOperation:operation error:error];
            
            if(block) {
                block(response, nil);
            }
        }];
    } else {
        NSLog(@"URL is nil/null");
    }
    
    
    
}

-(void)del:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
    
    if ([ABAPI notNull:url]) {
        NSString *path = [[[ABAPI endpoint] stringByAppendingString:[ABAPI version]] stringByAppendingString:url];
        
        ABResponseObject *response = [[ABResponseObject alloc] init];
        
        AFHTTPSessionManager *manager = [self requestManagerWithHeader:header];
        
        [manager DELETE:path parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithTask:task responseObject:responseObject];
            
            if(block) {
                block(response, nil);
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            ABResponseObject *response = [[ABResponseObject alloc] initWithOperation:operation error:error];
            
            if(block) {
                block(response, nil);
            }
        }];
    } else {
        NSLog(@"URL is nil/null");
    }
    
    
    
    
}

- (AFHTTPSessionManager *)requestManagerWithHeader:(NSDictionary *)header {
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    [policy setValidatesDomainName:NO];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *userAgent = [manager.requestSerializer valueForHTTPHeaderField:@"User-Agent"];
    NSString *strApplicationUUID = [self userAgent];
    
    if ([ABAPI notNull:strApplicationUUID]) {
        userAgent = strApplicationUUID;
    }
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
//    NSMutableIndexSet *acceptedCodes = [[NSMutableIndexSet alloc]
//                                        initWithIndexSet:manager.responseSerializer.acceptableStatusCodes];
//    [acceptedCodes addIndex:404];
//    [acceptedCodes addIndex:409];
//    
//    manager.responseSerializer.acceptableStatusCodes = [acceptedCodes copy];
    
    for(id key in header)
        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
    
    return manager;
}

- (NSString *) userAgent {
    NSString *version = @"noVersion";
    NSString *userID = @"noID";
    
    if ([ABAPI notNull:[ABAPI version]]) {
        version = [ABAPI version];
    }
    
    NSString *strApplicationUUID = [NSString stringWithFormat:@" Ver [%@] iOS", version];
    
    return strApplicationUUID;
}

+ (BOOL)notNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return false;
    }
    else {
        return true;
    }
}

+ (BOOL)isNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return true;
    }
    else {
        return false;
    }
}

+ (BOOL)notNil:(id)object {
    if (object == nil) {
        return false;
    }
    else {
        return true;
    }
}

+ (BOOL)isNil:(id)object {
    if (object == nil) {
        return true;
    }
    else {
        return false;
    }
}

+ (BOOL)notBlank: (NSString *) text {
    if ([ABAPI notNull:text]) {
        if (![text isEqualToString:@""]) {
            return YES;
        }
    }
    
    return NO;
}

//
//-(void)progressPost:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(void (^)(NSDictionary *response, NSError *error))block {
//
//    if (![Utils notNull:url]) {
//        url = @"";
//    }
//
//    NSString *path = [[[Utils apiEndpoint] stringByAppendingString:[Utils apiVersion]] stringByAppendingString:url];
//
//    __block NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                           @"",@"httpstatuscode",
//                                           @"",@"success_data",
//                                           @"",@"success_operation",
//                                           @"",@"failure_operation",
//                                           @"",@"failure_error",
//                                           nil];
//
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = policy;
//
//
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//
//    NSString *userAgent = [manager.requestSerializer  valueForHTTPHeaderField:@"User-Agent"];
//    NSString *strApplicationUUID = [self userAgent];
//
//    if ([Utils notNull:strApplicationUUID]) {
//        userAgent = strApplicationUUID;
//    }
//
//    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//
//    NSMutableIndexSet *acceptedCodes = [[NSMutableIndexSet alloc]
//                                        initWithIndexSet:manager.responseSerializer.acceptableStatusCodes];
//    [acceptedCodes addIndex:404];
//    [acceptedCodes addIndex:409];
//
//    manager.responseSerializer.acceptableStatusCodes = [acceptedCodes copy];
//
//
//
//    for(id key in header)
//        [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
//
//    NSString *postID = [param objectForKey:@"id"];
//
//
//    [manager POST:path parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //Update the progress view
//            if ([Utils notNull:postID]) {
//                NSDictionary *progressPost = [[NSDictionary alloc] initWithObjectsAndKeys:postID, @"id", [NSNumber numberWithFloat:uploadProgress.fractionCompleted], @"progress", nil];
//                NSArray *prog = [[NSArray alloc] initWithObjects:progressPost, nil];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"Progress Update" object:prog];
//
//                UIApplicationState state = [UIApplication sharedApplication].applicationState;
//
//                if (uploadProgress.fractionCompleted >= 1.0f && (state == UIApplicationStateBackground || ![[Defaults viewVisible] isEqualToString:@"Discover"])) {
//                    RLMResults *progressArray = [[PendingPost objectsWhere:@"postID == %@", postID] sortedResultsUsingProperty:@"postID" ascending:YES];
//
//                    for (PendingPost *pending in progressArray) {
//                        [PendingPost deletePost:pending];
//                    }
//
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Refresh For Progress" object:prog];
//                }
//
//            }
//        });
//
//
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
//
//        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
//        result[@"success_data"] =  responseObject;
//        //        result[@"success_operation"] = nil;
//        if(block) {
//            block(result, nil);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
//
//        result[@"httpstatuscode"] = [NSString stringWithFormat:@"%ld", (long)r.statusCode];
//
//        result[@"failure_operation"] = error;
//        result[@"failure_error"] = error;
//        if(block) {
//            block(result, error);
//        }
//    }];
//
//}

@end
