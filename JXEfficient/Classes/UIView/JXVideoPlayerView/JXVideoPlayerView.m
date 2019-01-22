//
//  JXVideoPlayerView.m
//  mixc
//
//  Created by augsun on 1/22/19.
//  Copyright © 2019 crland. All rights reserved.
//

#import "JXVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <JXEfficient.h>

static const CGFloat kProgressViewHeight = 3.0;

// ====================================================================================================
@interface JXAVPlayerLayerView : UIView

@property (nonatomic, readonly) AVPlayerLayer *playerLayer;

@end

@implementation JXAVPlayerLayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

@end

// ====================================================================================================
@interface JXVideoPlayerView ()

@property (nonatomic, strong) AVPlayerItem *avPlayerItem;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, strong) JXAVPlayerLayerView *playerLayerView;

@end

@implementation JXVideoPlayerView

+ (instancetype)videoPlayerView {
    JXVideoPlayerView *view = [[JXVideoPlayerView alloc] init];
    return view;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _status = JXVideoPlayerViewStatusUnavailable;
        
        // 播放完成
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(avPlayerItemDidPlayToEndTimeNotification:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        // 播放失败
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(avPlayerItemFailedToPlayToEndTimeNotification:)
                                                     name:AVPlayerItemFailedToPlayToEndTimeNotification
                                                   object:nil];
        // 异常中断
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(avPlayerItemPlaybackStalledNotification:)
                                                     name:AVPlayerItemPlaybackStalledNotification
                                                   object:nil];
        
        //
        self.playerLayerView = [[JXAVPlayerLayerView alloc] init];
        [self addSubview:self.playerLayerView];
        self.playerLayerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:self.playerLayerView attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.playerLayerView attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeRight
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.playerLayerView attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeTop
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.playerLayerView attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0 constant:0.0],
                               ]
         ];
        
        self.playerLayerView.playerLayer.videoGravity = AVLayerVideoGravityResize;
        
        //
        _progressView = [[UIProgressView alloc] init];
        [self addSubview:self.progressView];
        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeRight
                                                           multiplier:1.0 constant:0.f],
                               [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0 constant:kProgressViewHeight],
                               [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0 constant:0.0],
                               ]
         ];
        self.progressView.hidden = YES;
        self.progressView.backgroundColor = [UIColor clearColor];
        self.progressView.trackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.6f];

        
    }
    return self;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.avPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

// 播放完成
- (void)avPlayerItemDidPlayToEndTimeNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        self.progressView.hidden = YES;
        _status = JXVideoPlayerViewStatusEndPlaying;
        JX_BLOCK_EXEC(self.didFinishedPlay);
    }
}

// 播放失败
- (void)avPlayerItemFailedToPlayToEndTimeNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        _status = JXVideoPlayerViewStatusFailure;
        JX_BLOCK_EXEC(self.failedToPlay);
    }
}

// 异常中断
- (void)avPlayerItemPlaybackStalledNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        _status = JXVideoPlayerViewStatusFailure;
        JX_BLOCK_EXEC(self.failedToPlay);
    }
}

+ (void)firstVideoFrameForURL:(NSURL *)URL completion:(void (^)(UIImage * _Nullable))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:URL options:nil];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 60);
        CGImageRef imgRef = [assetGen copyCGImageAtTime:time actualTime:NULL error:NULL];
        UIImage *image = [[UIImage alloc] initWithCGImage:imgRef];
        CGImageRelease(imgRef);
        dispatch_async(dispatch_get_main_queue(), ^{
            JX_BLOCK_EXEC(completion, image);
        });
    });
}

- (void)setURL:(NSURL *)URL {

    if (!URL) {
        return;
    }
    
    //
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    self.avPlayerItem = item;

    //
    AVPlayer *player = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
    JX_WEAK_SELF;
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:nil usingBlock:^(CMTime time) {
        JX_STRONG_SELF;
        CGFloat currentTime = CMTimeGetSeconds(time);
        self.progressView.progress = currentTime / self.duration;
        self.progressView.hidden = NO;
        JX_BLOCK_EXEC(self.playingProgress, currentTime, self.duration);
    }];
    self.player = player;

    //
    self.playerLayerView.playerLayer.player = self.player;
}

- (BOOL)play {
    if (_status == JXVideoPlayerViewStatusReadyToPlay ||
        _status == JXVideoPlayerViewStatusPause ||
        _status == JXVideoPlayerViewStatusFailure) {
        
        _status = JXVideoPlayerViewStatusPlaying;
        [self.player play];
        return YES;
    }
    else if (_status == JXVideoPlayerViewStatusEndPlaying) {
        BOOL ret = [self rePlay];
        return ret;
    }
    else {
        return NO;
    }
}

- (BOOL)rePlay {
    if (_status == JXVideoPlayerViewStatusReadyToPlay ||
        _status == JXVideoPlayerViewStatusPlaying ||
        _status == JXVideoPlayerViewStatusPause ||
        _status == JXVideoPlayerViewStatusEndPlaying ||
        _status == JXVideoPlayerViewStatusFailure ) {
        
        _status = JXVideoPlayerViewStatusPlaying;
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
        return YES;
    }
    else {
        return NO;
    }
}

- (void)pause {
    _status = JXVideoPlayerViewStatusPause;
    [self.player pause];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (object != self.avPlayerItem) {
        return;
    }
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"status");
        AVPlayerItemStatus status = jx_intValue(change[NSKeyValueChangeNewKey]);
        switch (status) {
            case AVPlayerItemStatusUnknown:
            {
                JX_BLOCK_EXEC(self.cannotBePlayedOrUnknown);
            } break;
                
            case AVPlayerItemStatusReadyToPlay:
            {
                self.duration = CMTimeGetSeconds(self.avPlayerItem.duration);
                _status = JXVideoPlayerViewStatusReadyToPlay;
                JX_BLOCK_EXEC(self.readyToPlay, self.duration);
            } break;
                
            case AVPlayerItemStatusFailed:
            {
                JX_BLOCK_EXEC(self.cannotBePlayedOrUnknown);
            } break;
                
            default: break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"loadedTimeRanges");
        self.duration = CMTimeGetSeconds(self.avPlayerItem.duration);
        NSArray *array= self.avPlayerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        CGFloat start = CMTimeGetSeconds(timeRange.start);
        CGFloat duration = CMTimeGetSeconds(timeRange.duration);
        CGFloat loadedTime = start + duration;
        JX_BLOCK_EXEC(self.loadingProgress, loadedTime, self.duration);
    }
}

@end









