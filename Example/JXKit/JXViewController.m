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
    

    UIImage *tempImage = [UIImage imageNamed:@"WX20181023-180131@2x"];
    NSString *QRCodeString = [UIImage jx_QRCodeStringFromImage:tempImage];
    UIImage *newImage = [UIImage jx_QRCodeImageFromString:QRCodeString pt_sideLength:300];
    
    NSLog(@"%@ %lf", NSStringFromCGSize(newImage.size), newImage.scale);
    

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 300, 300)];
    [self.view addSubview:imgView];
    imgView.image = newImage;
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
