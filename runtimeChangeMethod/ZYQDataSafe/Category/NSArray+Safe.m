//
//  NSArray+ZYQArray.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+IMPChangeTool.h"

@implementation NSArray (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self SwizzlingSystemMethodString:@"__NSSingleObjectArrayI" SystemSEL:@selector(objectAtIndex:) SafeMethodString:@"NSArray" SafeSEL: @selector(safe_objectAtIndex:)];
        
        [self SwizzlingSystemMethodString:@"NSArray" SystemSEL:@selector(arrayByAddingObject:) SafeMethodString:@"NSArray" SafeSEL:@selector(safe_arrayByAddingObject:)];

        [self SwizzlingSystemMethodString:@"__NSPlaceholderArray" SystemSEL:@selector(initWithObjects:count:) SafeMethodString:@"NSArray" SafeSEL:@selector(initWithObjects_safe:count:)];
    });
}

- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (self.count > index)
    {
        return [self safe_objectAtIndex:index];
    }
    
    return nil;
}

- (NSArray *)safe_arrayByAddingObject:(id)obj
{
    if (!obj) {
        return self;
    }
    
    return [self arrayByAddingObject:obj];
}


- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)count
{
    NSUInteger newCount = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        if (!objects[i])
        {
            break;
        }
        newCount++;
    }
    
    self = [self initWithObjects_safe:objects count:newCount];
    
    return self;
}
@end
