//
//  ABResponseObject.m
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import "ABResponseObject.h"

@implementation ABResponseObject

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.statusCode = 000;
        self.successTask = nil;
        self.successData = nil;
        self.failureError = nil;
        self.failureOperation = nil;
        
    }
    
    return self;
}

- (instancetype)initWithTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
    
    self.statusCode = r.statusCode;
    self.successData = responseObject;
    self.successTask = task;
}

- (instancetype)initWithOperation:(NSURLSessionTask *)operation error:(NSError *)error {
    NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
    
    self.statusCode = r.statusCode;
    self.failureOperation = operation;
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
    
    if ([self notNull:self.successData]) {
        data = [NSString stringWithFormat:@"%@", self.successData];
    }
    
    return data;
}

- (NSString *)successTaskString {
    NSString *task = @"";
    
    if ([self notNull:self.successTask]) {
        task = [NSString stringWithFormat:@"%@", self.successTask];
    }
    
    return task;
}

- (NSString *)failureOperationString {
    NSString *operation = @"";
    
    if ([self notNull:self.failureOperation]) {
        operation = [NSString stringWithFormat:@"%@", self.failureOperation];
    }
    
    return operation;
}

- (NSString *)failureErrorString {
    NSString *error = @"";
    
    if ([self notNull:self.failureError]) {
        error = [NSString stringWithFormat:@"%@", self.failureError];
    }
    
    return error;
}

- (NSString *)successDescription {
    
    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nSuccess Data: %@\nSuccess Task: %@\n", [self statusCodeString], [self successDataString], [self successTaskString]];
    
    return descriptionString;
}

- (NSString *)failureDescription {
    
    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nFailure Operation: %@\nFailure Error: %@\n", [self statusCodeString], [self failureOperationString], [self failureErrorString]];
    
    return descriptionString;
}

- (NSString *)description {

    NSString *descriptionString = [NSString stringWithFormat:@"Status Code: %@\nSuccess Data: %@\nSuccess Task: %@\nFailure Operation: %@\nFailure Error: %@\n", [self statusCodeString], [self successDataString], [self successTaskString], [self failureOperationString], [self failureErrorString]];
    
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

- (BOOL)notNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return false;
    }
    else {
        return true;
    }
}
@end
