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
    JXVideoPlayerViewStatusUnavailable = 0,     // 不可用
    JXVideoPlayerViewStatusReadyToPlay,         // 将要播放
    JXVideoPlayerViewStatusPlaying,             // 播放中
    JXVideoPlayerViewStatusPause,               // 暂停中
    JXVideoPlayerViewStatusEndPlaying,          // 结束播放
    JXVideoPlayerViewStatusFailure,             // 播放失败
};

@interface JXVideoPlayerView : UIView

+ (instancetype)videoPlayerView; // 指定初始化器

@property (nonatomic, readonly) UIProgressView *progressView;

@property (nonatomic, strong) NSURL *URL;
+ (void)firstVideoFrameForURL:(NSURL *)URL completion:(void (^)(UIImage * _Nullable img))completion;

@property (nonatomic, readonly) JXVideoPlayerViewStatus status;

@property (nonatomic, copy) void (^cannotBePlayedOrUnknown)(void); // 不能播放 <还未播放>
@property (nonatomic, copy) void (^failedToPlay)(void); // 播放失败 <已经播放>
@property (nonatomic, copy) void (^loadingProgress)(CGFloat loadedTime, CGFloat duration); // 缓冲进度
@property (nonatomic, copy) void (^readyToPlay)(CGFloat duration); // 播放就绪
@property (nonatomic, copy) void (^playingProgress)(CGFloat currentTime, CGFloat duration); // 播放进度
@property (nonatomic, copy) void (^didFinishedPlay)(void); // 结束播放

- (BOOL)play;
- (BOOL)rePlay;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
