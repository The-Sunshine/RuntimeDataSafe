//
//  NSMutableDictionary+Safe.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+IMPChangeTool.h"

@implementation NSMutableDictionary (Safe)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self SwizzlingSystemMethodString:@"__NSDictionaryM" SystemSEL:@selector(setObject:forKey:) SafeMethodString:@"NSMutableDictionary" SafeSEL:@selector(safe_setObject:forKey:)];
     
        [self SwizzlingSystemMethodString:@"__NSDictionaryM" SystemSEL:@selector(setValue:forKey:) SafeMethodString:@"NSMutableDictionary" SafeSEL:@selector(safe_setValue:forKey:)];
    });
}

-(void)safe_setValue:(id)value forKey:(NSString *)key
{
    if (!key) return;
    
    [self safe_setValue:value forKey:key];
}

-(void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) return;
    
    [self safe_setObject:anObject forKey:aKey];
}

@end
