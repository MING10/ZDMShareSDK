//
//  ViewController.m
//  ShareSDK
//
//  Created by MING.Z on 14-12-29.
//  Copyright (c) 2014年 MING.Z. All rights reserved.
//

#import "ViewController.h"
#import "ZDMShareView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button  = [UIButton buttonWithType: UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(showShare) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 100, 30, 30);
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)showShare{
    for (UIView *subview in [self.view subviews] ) {
        if ([subview isKindOfClass:[ZDMShareView class]]) {
            [subview removeFromSuperview];
        }
    }
    ZDMShareView *shareView = [[ZDMShareView alloc]initWithFrame:self.view.frame ColumnNumber:4 withName:nil withImage:nil withNight:NO];
    [shareView buildShowShareView];
    [shareView showShareView];
    [shareView release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
