//
//  JXViewController.m
//  JXEfficient
//
//  Created by 452720799@qq.com on 12/29/2018.
//  Copyright (c) 2018 452720799@qq.com. All rights reserved.
//

#import "JXViewController.h"
#import <JXEfficient.h>
#import <Masonry/Masonry.h>

@interface JXViewController ()

@property (nonatomic, strong) JXNaviView *naviView;

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.naviView = [JXNaviView naviView];
    [self.view addSubview:self.naviView];
    
    
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(H_NAVBAR);
    }];
//    self.naviView.backgroundColor = COLOR_RANDOM;
    
//    self.naviView.backButtonHidden = YES;
    self.naviView.leftButtonTitle = @"关闭";
    
    self.naviView.rightButtonTitle = @"右一右1";
    self.naviView.rightSubButtonTitle = @"右二右二";
    
    self.naviView.title = @"快点发水电费快点电费快点电费快点发快点发水水水水水";
    
//    self.naviView.bgColorStyle = YES;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
