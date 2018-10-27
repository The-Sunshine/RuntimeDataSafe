//
//  NSObject+IMPChangeTool.h
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IMPChangeTool)

+ (void)SwizzlingSystemMethodString:(NSString *)systemMethodString SystemSEL:(SEL)SystemSEL SafeMethodString:(NSString *)safeMethodString SafeSEL:(SEL)safeSEL;

@end

NS_ASSUME_NONNULL_END
