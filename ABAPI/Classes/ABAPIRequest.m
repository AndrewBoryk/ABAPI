//
//  ABAPIRequest.m
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import "ABAPIRequest.h"
#import "ABAPI.h"

@implementation ABAPIRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.params = [[NSMutableDictionary alloc] init];
        self.header = [[NSDictionary alloc] init];
        self.url = @"";
        self.base = nil;
        self.apiKey = nil;
        self.version = nil;
        self.relativePath = nil;
    }
    
    return self;
}

- (instancetype)initWithURL:(NSString *)url {
    self = [self initWithURL:url params:nil header:nil];
    
    return self;
}

- (instancetype)initWithURL:(NSString *)url params:(NSDictionary *)params {
    self = [self initWithURL:url params:params header:nil];
    
    return self;
}

- (instancetype)initWithURL:(NSString *)url header:(NSDictionary *)header {
    self = [self initWithURL:url params:nil header:header];
    
    return self;
}

- (instancetype)initWithURL:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header {
    self = [self init];
    
    if (self) {
        
        if ([ABAPIConstants notNull:url]) {
            self.url = url;
        }
        
        if ([ABAPIConstants notNull:params]) {
            self.params = params;
        }
        
        if ([ABAPIConstants notNull:header]) {
            self.header = header;
        }
    }
    
    return self;
}

- (void)request:(ABAPIRequestType)type completion:(APIResponseBlock)block {
    [ABAPIRequest request:self withType:type completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

- (void)GET:(APIResponseBlock)block {
    [self request:GET completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

- (void)POST:(APIResponseBlock)block {
    [self request:POST completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

- (void)PUT:(APIResponseBlock)block {
    [self request:PUT completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

- (void)DELETE:(APIResponseBlock)block {
    [self request:DELETE completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

+ (void)request:(ABAPIRequest *)request withType:(ABAPIRequestType)type completion:(APIResponseBlock)block {
    switch (type) {
            
        case GET: {
            [ABAPIRequest GET:request completion:^(ABResponseObject *response, NSError *error) {
                if (block) block(response, error);
            }];
            break; }
            
        case POST: {
            [ABAPIRequest POST:request completion:^(ABResponseObject *response, NSError *error) {
                if (block) block(response, error);
            }];
            break; }
            
        case PUT: {
            [ABAPIRequest PUT:request completion:^(ABResponseObject *response, NSError *error) {
                if (block) block(response, error);
            }];
            break; }
            
        case DELETE: {
            [ABAPIRequest DELETE:request completion:^(ABResponseObject *response, NSError *error) {
                if (block) block(response, error);
            }];
            break; }
            
        default:
            NSLog(@"Invalid Request Type (Must be GET, POST, PUT, or DELETE)");
            break;
    }
}

+ (void)GET:(ABAPIRequest *)request completion:(APIResponseBlock)block {
    [ABAPI get:request.url setHeader:request.header setParameter:request.params completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

+ (void)POST:(ABAPIRequest *)request completion:(APIResponseBlock)block {
    [ABAPI post:request.url setHeader:request.header setParameter:request.params completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

+ (void)PUT:(ABAPIRequest *)request completion:(APIResponseBlock)block {
    [ABAPI put:request.url setHeader:request.header setParameter:request.params completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

+ (void)DELETE:(ABAPIRequest *)request completion:(APIResponseBlock)block {
    [ABAPI del:request.url setHeader:request.header setParameter:request.params completion:^(ABResponseObject *response, NSError *error) {
        if (block) block(response, error);
    }];
}

- (void)setParams:(NSMutableDictionary *)params {
    _params = (NSMutableDictionary *)params;
}

- (void)setUrl:(NSDictionary *)url {
    if ([ABAPIConstants notNull:url]) {
        _url = url;
    } else {
        _url = @"";
    }
}

- (void)setBase:(NSDictionary *)base {
    if ([ABAPIConstants notNull:base]) {
        _base = base;
    } else {
        _base = @"";
    }
}

@end
