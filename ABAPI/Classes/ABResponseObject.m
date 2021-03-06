//
//  ABResponseObject.m
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import "ABResponseObject.h"
#import "ABAPIConstants.h"

@implementation ABResponseObject

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.statusCode = 000;
        self.successTask = nil;
        self.successData = nil;
        self.failureError = nil;
        self.failureTask = nil;
        
    }
    
    return self;
}

- (instancetype)initWithSuccessTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
    
    self.statusCode = r.statusCode;
    self.successData = responseObject;
    self.successTask = task;
}

- (instancetype)initWithFailureTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
    
    self.statusCode = r.statusCode;
    self.failureTask = task;
    self.failureError = error;
}

- (NSString *)statusCodeString {
    NSString *status = @"";
    
    if (!isnan(self.statusCode)) {
        status = [NSString stringWithFormat:@"%ld", (long)self.statusCode];
    }
    
    return status;
}

- (NSString *)successDataString {
    NSString *data = @"";
    
    if ([ABAPIConstants notNull:self.successData]) {
        data = [NSString stringWithFormat:@"%@", self.successData];
    }
    
    return data;
}

- (NSString *)successTaskString {
    NSString *task = @"";
    
    if ([ABAPIConstants notNull:self.successTask]) {
        task = [NSString stringWithFormat:@"%@", self.successTask];
    }
    
    return task;
}

- (NSString *)failureTaskString {
    NSString *operation = @"";
    
    if ([ABAPIConstants notNull:self.failureTask]) {
        operation = [NSString stringWithFormat:@"%@", self.failureTask];
    }
    
    return operation;
}

- (NSString *)failureErrorString {
    NSString *error = @"";
    
    if ([ABAPIConstants notNull:self.failureError]) {
        error = [NSString stringWithFormat:@"%@", self.failureError];
    }
    
    return error;
}

- (NSString *)successDescription {
    
    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nSuccess Data: %@\nSuccess Task: %@\n", [self statusCodeString], [self successDataString], [self successTaskString]];
    
    return descriptionString;
}

- (NSString *)failureDescription {
    
    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nFailure Operation: %@\nFailure Error: %@\n", [self statusCodeString], [self failureTaskString], [self failureErrorString]];
    
    return descriptionString;
}

- (NSString *)description {

    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nSuccess Data: %@\nSuccess Task: %@\nFailure Operation: %@\nFailure Error: %@\n", [self statusCodeString], [self successDataString], [self successTaskString], [self failureTaskString], [self failureErrorString]];
    
    return descriptionString;
}

- (void)printSuccessDescription {
    NSLog(@"%@", self.successDescription);
}

- (void)printFailureDescription {
    NSLog(@"%@", self.failureDescription);
}

- (void)printDescription {
    NSLog(@"%@", self.description);
}

@end
