//
//  ABAPIConstants.m
//  Pods
//
//  Created by Andrew Boryk on 3/18/17.
//
//

#import "ABAPIConstants.h"

@implementation ABAPIConstants

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
    if ([ABAPIConstants notNull:text]) {
        if (![text isEqualToString:@""]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isValidPath:(NSString *)path {
    if ([ABAPIConstants notNull:path]) {
        NSString *testBlankString = [path stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([ABAPIConstants notBlank:testBlankString]) {
            return YES;
        } else {
            NSLog(@"URL is blank");
            return NO;
        }
        
    } else {
        NSLog(@"URL is nil/null");
        return NO;
    }
}

@end
