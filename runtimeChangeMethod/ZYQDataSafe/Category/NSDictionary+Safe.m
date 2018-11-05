//
//  NSDictionary+SafeDictionary.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+IMPChangeTool.h"

@implementation NSDictionary (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzlingSystemMethodString:@"__NSPlaceholderDictionary" SystemSEL:@selector(initWithObjects:forKeys:count:) SafeMethodString:@"NSDictionary" SafeSEL:@selector(initWithObjects_safe:forKeys:count:)];
    });
}

-(instancetype)initWithObjects_safe:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count
{
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        if (!(keys[i] && objects[i]))
        {
            break;
        }
        else
        {
            rightCount++;
        }
    }
    
    self = [self initWithObjects_safe:objects forKeys:keys count:rightCount];
    
    return self;
}

@end
