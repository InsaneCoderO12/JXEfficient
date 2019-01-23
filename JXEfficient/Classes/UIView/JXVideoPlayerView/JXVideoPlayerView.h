//
//  JXVideoPlayerView.m
//  mixc
//
//  Created by augsun on 1/22/19.
//  Copyright © 2019 crland. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JXVideoPlayerViewStatus) {
    JXVideoPlayerViewStatusUnavailable = 0,         // 不可用
    JXVideoPlayerViewStatusCannotBePlayedOrUnknown, // 不能播放
    
    JXVideoPlayerViewStatusDidSetURL,               // 已设置 URL
    
    JXVideoPlayerViewStatusPlaying,                 // 播放中
    JXVideoPlayerViewStatusPause,                   // 暂停中
    JXVideoPlayerViewStatusEndPlaying,              // 结束播放
    
    JXVideoPlayerViewStatusFailure,                 // 播放失败
};

@interface JXVideoPlayerView : UIView

+ (instancetype)videoPlayerView; // 指定初始化器

+ (void)firstVideoFrameForURL:(NSURL *)URL completion:(void (^)(UIImage * _Nullable img))completion; // 获取第一帧图片

@property (nonatomic, readonly) UIProgressView *progressView; // 播放进度 不显示可以 hidden 掉, 默认显示.

/*
 cell 复用的情况 showFirstVideoFrame 传入 NO 以节约性能
 同时 调用 firstVideoFrameForURL: completion: 方法异步加载第一帧图片 自行在 JXVideoPlayerView 创建一个 UIImageView 控制预览及视频播放层的隐藏状态.
 firstVideoFrameForURL: completion: 方法没有缓存 注意 cell 复用情况的性能花销
 */
- (void)setURL:(NSURL *)URL showFirstVideoFrame:(BOOL)showFirstVideoFrame;

@property (nonatomic, readonly) JXVideoPlayerViewStatus status;
@property (nonatomic, copy, nullable) void (^statusDidChanged)(JXVideoPlayerViewStatus status); // 状态改变回调

@property (nonatomic, readonly) CGFloat duration; // canPlay == YES 时才有值

@property (nonatomic, copy, nullable) void (^loadingProgress)(CGFloat loadedTime, CGFloat duration); // 调用 play 方法之后的 缓冲进度
@property (nonatomic, copy, nullable) void (^playingProgress)(CGFloat currentTime, CGFloat duration); // 调用 play 方法之后的 播放进度

@property (nonatomic, readonly) BOOL canPlay;
- (void)play;

@property (nonatomic, readonly) BOOL canReplay;
- (void)replay;

@property (nonatomic, readonly) BOOL canPause;
- (void)pause;

@end

NS_ASSUME_NONNULL_END



// 使用例子
#if 0
- (void)awakeFromNib {
    [super awakeFromNib];
    JX_WEAK_SELF;
    
    // 实例化 videoPlayerView
    self.videoPlayerView = [JXVideoPlayerView videoPlayerView];
    [self.videoBgView addSubview:self.videoPlayerView];
    [_videoPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(kToL);
        make.right.mas_equalTo(self).with.offset(-kToR);
        make.top.bottom.mas_equalTo(self);
    }];
    
    // 状态改变回调
    self.videoPlayerView.statusDidChanged = ^(JXVideoPlayerViewStatus status) {
        JX_STRONG_SELF;
        switch (status) {
            case JXVideoPlayerViewStatusPlaying:
            {
                self.playImgView.hidden = YES;
            } break;
                
            case JXVideoPlayerViewStatusPause:
            case JXVideoPlayerViewStatusEndPlaying:
            {
                self.playImgView.hidden = NO;
            } break;
                
            default: break;
        }
    };
    
}

// 外部模型数据传入
- (void)refreshUI:(YJRMaterialDetailViewMap *)map {
    [super refreshUI:map];
    
    [self.videoPlayerView setURL:jx_URLValue(map.model.video) showFirstVideoFrame:YES];
    
}

// 播放 或 暂停 点击
- (IBAction)btnPlayClick:(id)sender {
    JX_BLOCK_EXEC(self.playClick);
    if (self.videoPlayerView.canPlay) {
        [self.videoPlayerView play];
    }
    else if (self.videoPlayerView.canPause) {
        [self.videoPlayerView pause];
    }
}
#endif
