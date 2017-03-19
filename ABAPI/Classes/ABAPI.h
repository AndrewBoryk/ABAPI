//
//  ABAPI.h
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import <Foundation/Foundation.h>
#import "ABResponseObject.h"
#import "ABAPIConstants.h"

@interface ABAPI : NSObject

/// GET request for API
+ (void)get:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(APIResponseBlock)block;

/// POST request for API
+ (void)post:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(APIResponseBlock)block;

/// PUT request for API
+ (void)put:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(APIResponseBlock)block;

/// DEL request for API
+ (void)del:(NSString *)url setHeader:(NSDictionary *)header setParameter:(NSDictionary *)param completion:(APIResponseBlock)block;

@end
