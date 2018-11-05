//
//  NSMutableArray+Safe.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+IMPChangeTool.h"

@implementation NSMutableArray (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(addObject:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_addObject:)];
        
        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(insertObject:atIndex:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_insertObject:atIndex:)];

        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(replaceObjectAtIndex:withObject:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_replaceObjectAtIndex:withObject:)];
        
        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(removeObjectAtIndex:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_removeObjectAtIndex:)];
        
        [self swizzlingSystemMethodString:@"NSMutableArray" SystemSEL:@selector(removeObjectsAtIndexes:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_removeObjectsAtIndexes:)];

        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(removeObjectsInRange:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_removeObjectsInRange:)];
        
        [self swizzlingSystemMethodString:@"__NSArrayM" SystemSEL:@selector(objectAtIndex:) SafeMethodString:@"NSMutableArray" SafeSEL:@selector(safe_objectAtIndex:)];
    });
}


- (void)safe_addObject:(id)anObject
{
    if (!anObject) {
        return;
    }
    
    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) return;
    
    if (index > self.count){
        
        return [self safe_addObject:anObject];
    }
    
    [self safe_insertObject:anObject atIndex:index];
}

-(void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject) return;
    
    if (index > self.count) return;
    
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index
{
    if (self.count > index) {
        
        return [self safe_removeObjectAtIndex:index];
    }
}

-(void)safe_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    NSMutableIndexSet * set = [NSMutableIndexSet indexSet];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx < self.count) {
            
            [set addIndex:idx];
        }
    }];
    
    [self safe_removeObjectsAtIndexes:set];
}

-(void)safe_removeObjectsInRange:(NSRange)range
{
    if (self.count <= range.location || range.length == 0) return;
    
    if (self.count >= range.location + range.length)
    {
        [self safe_removeObjectsInRange:range];
        return;
    }
    
    NSRange new = NSMakeRange(range.location, self.count - range.location);
    [self safe_removeObjectsInRange:new];
}

- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (self.count > index)
    {
        return [self safe_objectAtIndex:index];
    }
    
    return nil;
}

@end
