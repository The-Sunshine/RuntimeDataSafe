//
//  NSObject+IMPChangeTool.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "NSObject+IMPChangeTool.h"

@implementation NSObject (IMPChangeTool)

+ (void)SwizzlingSystemMethodString:(NSString *)systemMethodString SystemSEL:(SEL)SystemSEL SafeMethodString:(NSString *)safeMethodString SafeSEL:(SEL)safeSEL
{
    Method system = class_getInstanceMethod(NSClassFromString(systemMethodString), SystemSEL);
    Method safe = class_getInstanceMethod(NSClassFromString(safeMethodString), safeSEL);
    method_exchangeImplementations(system, safe);
}

@end
