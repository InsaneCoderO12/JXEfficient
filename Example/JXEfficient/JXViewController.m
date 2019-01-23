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

@property (nonatomic, strong) JXVideoPlayerView *videoPlayerView;

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    
    self.videoPlayerView = [JXVideoPlayerView videoPlayerView];
    [self.view addSubview:self.videoPlayerView];
    [self.videoPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(15.0);
        make.right.mas_equalTo(self.view).with.offset(-15.0);
        make.top.mas_equalTo(self.view).with.offset(JX_NAVBAR_H + 20.0);
        make.height.mas_equalTo(200.0);
    }];
//    self.videoPlayerView.progressViewHidden = YES;
    
    self.videoPlayerView.statusDidChanged = ^(JXVideoPlayerViewStatus status) {
        switch (status) {
            case JXVideoPlayerViewStatusUnavailable:
            {
                NSLog(@"JXVideoPlayerViewStatusUnavailable");
            } break;
                
            case JXVideoPlayerViewStatusCannotBePlayedOrUnknown:
            {
                NSLog(@"JXVideoPlayerViewStatusCannotBePlayedOrUnknown");
            } break;
                
            case JXVideoPlayerViewStatusDidSetURL:
            {
                NSLog(@"JXVideoPlayerViewStatusDidSetURL");
            } break;
                
            case JXVideoPlayerViewStatusReadyToPlay:
            {
                NSLog(@"JXVideoPlayerViewStatusReadyToPlay");
            } break;
                
            case JXVideoPlayerViewStatusPlaying:
            {
                NSLog(@"JXVideoPlayerViewStatusPlaying");
            } break;
                
            case JXVideoPlayerViewStatusPause:
            {
                NSLog(@"JXVideoPlayerViewStatusPause");
            } break;
                
            case JXVideoPlayerViewStatusEndPlaying:
            {
                NSLog(@"JXVideoPlayerViewStatusEndPlaying");
            } break;
                
            case JXVideoPlayerViewStatusFailure:
            {
                NSLog(@"JXVideoPlayerViewStatusFailure");
            } break;
                
            default: break;
        }
    };
    self.videoPlayerView.loadingProgress = ^(CGFloat loadedTime, CGFloat duration) {
        //        NSLog(@"缓冲 %lf", loadedTime / duration);
    };
    self.videoPlayerView.playingProgress = ^(CGFloat currentTime, CGFloat duration) {
        //        NSLog(@"    播放 %lf", currentTime / duration);
    };
    
    NSURL *URL = [NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/01/03/mp4/190103220322870892.mp4"];
    //    NSURL *URL = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //    NSURL *URL = [NSURL URLWithString:@"https://www.w3schools.com/html/movie.mp4"];
    [self.videoPlayerView setURL:URL prepareForPlay:YES];
    
    //
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.videoPlayerView);
    }];
    [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"IIII");
        [self.videoPlayerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).with.offset(15.0);
            make.right.mas_equalTo(self.view).with.offset(-15.0);
            make.top.mas_equalTo(self.view).with.offset(JX_NAVBAR_H + 20.0);
            make.height.mas_equalTo(300.0);
        }];
    });

    
}

- (void)play {
    if (self.videoPlayerView.canPlay) {
        [self.videoPlayerView play];
    }
    else if (self.videoPlayerView.canPause) {
        [self.videoPlayerView pause];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
