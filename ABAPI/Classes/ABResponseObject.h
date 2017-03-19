//
//  ABResponseObject.h
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import <Foundation/Foundation.h>

@interface ABResponseObject : NSObject
//NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                               @"",@"httpstatuscode",
//                               @"",@"success_data",
//                               @"",@"success_operation",
//                               @"",@"failure_operation",
//                               @"",@"failure_error",
//                               nil];

/// Status code received from the HTTP Request
@property (nonatomic) NSInteger statusCode;

/// Data received from successful request
@property (strong, nonatomic) id successData;

/// Task received from successful request
@property (strong, nonatomic) NSURLSessionDataTask *successTask;

/// Error received from failed request
@property (strong, nonatomic) NSError *failureError;

/// Operation received from failed request
@property (strong, nonatomic) NSURLSessionTask *failureOperation;

/// Description string for the success part of the response object
@property (strong, nonatomic, readonly) NSString *successDescription;

/// Description string for the failure part of the response object
@property (strong, nonatomic, readonly) NSString *failureDescription;

/// Initializes a ABResponseObject using the success task and the success data response
- (instancetype)initWithTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject;

/// Initializes an ABResponseObject using the failure operation and the error
- (instancetype)initWithOperation:(NSURLSessionTask *)operation error:(NSError *)error;

/// Print the description string for the success part of the response object
- (void)printSuccessDescription;

/// Print the description string for the failure part of the response object
- (void)printFailureDescription;

/// Print the description string for the response
- (void)printDescription;
@end
