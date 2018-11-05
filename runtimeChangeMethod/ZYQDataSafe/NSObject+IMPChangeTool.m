//
//  NSObject+IMPChangeTool.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSObject+IMPChangeTool.h"

@implementation NSObject (IMPChangeTool)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzlingSystemMethodString:@"NSObject" SystemSEL:@selector(forwardingTargetForSelector:) SafeMethodString:@"NSObject" SafeSEL: @selector(safe_forwardingTargetForSelector:)];
    });
}

+ (void)swizzlingSystemMethodString:(NSString *)systemMethodString SystemSEL:(SEL)SystemSEL SafeMethodString:(NSString *)safeMethodString SafeSEL:(SEL)safeSEL
{
    Method system = class_getInstanceMethod(NSClassFromString(systemMethodString), SystemSEL);
    Method safe = class_getInstanceMethod(NSClassFromString(safeMethodString), safeSEL);
    method_exchangeImplementations(system, safe);
}

- (id)safe_forwardingTargetForSelector:(SEL)aSelector
{
    // 也可以用映射 NSSelectorFromString 但字符串易出错
    SEL sel = @selector(forwardingTargetForSelector:);
    Method method = class_getInstanceMethod([NSObject class], sel);
    Method selfMethod = class_getInstanceMethod([self class], sel);
    
    // 判断类本身是否实现消息转发流程
    BOOL transmit = method_getImplementation(selfMethod) != method_getImplementation(method);
    
    // 判断是否实现下一步消息转发流程
    if (!transmit)
    {
        SEL sel = @selector(methodSignatureForSelector:);
        Method method = class_getInstanceMethod([NSObject class], sel);
        Method selfMethod = class_getInstanceMethod([self class],sel);
        
        // 判断有没有实现
        transmit = method_getImplementation(selfMethod) != method_getImplementation(method);
    }
    
    //创建一个新类
    if (!transmit)
    {
        NSLog(@"出问题的类 %@,找不到的方法 %@",NSStringFromClass([self class]), NSStringFromSelector(aSelector));

        NSString * className = @"ZYQPersonClass";
        Class cls = NSClassFromString(className);
        
        // 如果类不存在 动态创建一个类
        if (!cls)
        {
            // 创建类和元类
            cls = objc_allocateClassPair([NSObject class], className.UTF8String, 0);
            
            class_addMethod(cls, aSelector, (IMP)testRuntimeIMP, "@@:@");
            
            // 注册类到 Runtime
            objc_registerClassPair(cls);
        }
        
        // 如果类没有对应的方法，则动态添加一个
        if (class_getInstanceMethod(NSClassFromString(className), aSelector))
        {
            class_addMethod(cls, aSelector, (IMP)testRuntimeIMP, "@@:@");
        }
        
        return [[NSClassFromString(className) alloc] init];
    }
    
    // 类本身实现了消息转发流程
    // 走正常的消息转发流程
    return [self safe_forwardingTargetForSelector:aSelector];
}

void testRuntimeIMP(id self,SEL _cmd)
{
    NSLog(@"动态添加了方法 %@", NSStringFromSelector(_cmd));
}

@end
