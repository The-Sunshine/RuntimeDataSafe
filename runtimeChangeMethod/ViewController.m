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
    
    [dic setValue:nil forKey:nil];
    [dic setObject:nil forKey:nil];
    
    [dic objectForKey:@"name"];
    
    
}

@end
