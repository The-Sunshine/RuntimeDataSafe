//
//  ViewController.m
//  runtimeChangeMethod
//
//  Created by eagle on 2018/10/25.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "ViewController.h"
#import "ZYQDataSafeTool.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Person * p = [[Person alloc]init];
    [p eat];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString * key;
    NSString * value;
    [dic setValue:value forKey:key];
    [dic setObject:value forKey:key];
    
    [dic objectForKey:@"name"];
}

@end
