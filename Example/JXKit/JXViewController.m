//
//  JXViewController.m
//  JXKit
//
//  Created by 452720799@qq.com on 06/01/2018.
//  Copyright (c) 2018 452720799@qq.com. All rights reserved.
//

#import "JXViewController.h"
#import "JXKit.h"

@interface JXViewController ()

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

//    [self.view jx_showToast:@"skdkfj" animated:YES];
    
    [self.view jx_showProgressHUD:@"加载中" animation:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view jx_hideProgressHUD:YES];
    });

    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
