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

- (void)dealloc {
//    NSLog(@"dealloc -> JXAVPlayerLayerView");
}

@end

// ====================================================================================================
@interface JXVideoPlayerView ()

@property (nonatomic, strong) AVPlayerItem *avPlayerItem;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) JXAVPlayerLayerView *playerLayerView;
@property (nonatomic, strong) UIImageView *previewImgView;

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, copy) NSURL *URL_previous;

@property (nonatomic, assign) JXVideoPlayerViewStatus realStatus;

@property (nonatomic, assign) BOOL videoPlayerReadyToPlay;

@property (nonatomic, strong) NSMutableDictionary <NSString *, id> *observers;

@end

@implementation JXVideoPlayerView

+ (instancetype)videoPlayerView {
    JXVideoPlayerView *view = [[JXVideoPlayerView alloc] init];
    return view;
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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.realStatus = JXVideoPlayerViewStatusUnavailable;
        self.observers = [[NSMutableDictionary alloc] init];

        // playerLayerView
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
        
        // previewImgView
        self.previewImgView = [[UIImageView alloc] init];
        [self addSubview:self.previewImgView];
        self.previewImgView.translatesAutoresizingMaskIntoConstraints = NO;
        self.previewImgView.backgroundColor = [UIColor blackColor];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:self.previewImgView attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.previewImgView attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeRight
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.previewImgView attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeTop
                                                           multiplier:1.0 constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self.previewImgView attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0 constant:0.0],
                               ]
         ];

        // progressView
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
        
        // player
        AVPlayer *player = [AVPlayer playerWithPlayerItem:nil];
        JX_WEAK_SELF;
        [player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:nil usingBlock:^(CMTime time) {
            JX_STRONG_SELF;
            CGFloat currentTime = CMTimeGetSeconds(time);
            self.progressView.progress = currentTime / self.duration;
            self.progressView.hidden = NO;
            self.previewImgView.hidden = YES;
            JX_BLOCK_EXEC(self.playingProgress, currentTime, self.duration);
        }];
        self.player = player;
        self.playerLayerView.playerLayer.player = self.player;
        [self obj:self.player addObserverSelfForKey:@"rate"];


    }
    return self;
}

- (void)setRealStatus:(JXVideoPlayerViewStatus)realStatus {
    if (_realStatus == realStatus) {
        return;
    }
    _realStatus = realStatus;
    _status = realStatus;
    JX_BLOCK_EXEC(self.statusDidChanged, realStatus);
}

- (void)dealloc {
//    NSLog(@"dealloc -> JXVideoPlayerView");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (NSString *keyEnum in self.observers.allKeys) {
        [self removeObserverForKey:keyEnum];
    }
}

- (void)removeObserverForKey:(NSString *)key {
    id obj = [self.observers objectForKey:key];
    if (obj) {
        [obj removeObserver:self forKeyPath:key];
    }
}

- (void)obj:(id)obj addObserverSelfForKey:(NSString *)key {
    [self removeObserverForKey:key];
    [self.observers setObject:obj forKey:key];
    [obj addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
}

// 播放完成
- (void)avPlayerItemDidPlayToEndTimeNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        self.progressView.hidden = YES;
        self.realStatus = JXVideoPlayerViewStatusEndPlaying;
    }
}

// 播放失败
- (void)avPlayerItemFailedToPlayToEndTimeNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        self.realStatus = JXVideoPlayerViewStatusFailure;
    }
}

// 异常中断
- (void)avPlayerItemPlaybackStalledNotification:(NSNotification *)noti {
    id object = noti.object;
    if (object == self.avPlayerItem) {
        self.realStatus = JXVideoPlayerViewStatusFailure;
    }
}

- (void)setURL:(NSURL *)URL showFirstVideoFrame:(BOOL)showFirstVideoFrame {
    if (!URL) {
        return;
    }
    _URL = URL;
    
    self.realStatus = JXVideoPlayerViewStatusDidSetURL;
    
    if (!showFirstVideoFrame) {
        return;
    }
    
    NSURL *tempURL = [URL copy];
    [JXVideoPlayerView firstVideoFrameForURL:URL completion:^(UIImage * _Nullable img) {
        if ([self.URL.absoluteString isEqualToString:tempURL.absoluteString] && img != nil) {
            self.previewImgView.image = img;
        }
    }];
}

- (BOOL)canPlay {
    return
    self.realStatus == JXVideoPlayerViewStatusDidSetURL ||
    self.realStatus == JXVideoPlayerViewStatusPause ||
    self.realStatus == JXVideoPlayerViewStatusEndPlaying ||
    self.realStatus == JXVideoPlayerViewStatusFailure;
}

- (void)play {
    if (self.realStatus == JXVideoPlayerViewStatusDidSetURL) {
        [self checkIfNeedReInitial];
        
        [self.player play];
    }
    else if (self.realStatus == JXVideoPlayerViewStatusPause ||
             self.realStatus == JXVideoPlayerViewStatusFailure) {
        
        [self.player play];
    }
    else if (self.realStatus == JXVideoPlayerViewStatusEndPlaying) {
        [self replay];
    }
    else {
        
    }
}

- (void)checkIfNeedReInitial {
    if (![self.URL.absoluteString isEqualToString:self.URL_previous.absoluteString]) {
        self.URL_previous = self.URL;
        
        //
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.URL];
        [self obj:item addObserverSelfForKey:@"status"];
        [self obj:item addObserverSelfForKey:@"loadedTimeRanges"];
        self.avPlayerItem = item;
        
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
}

- (BOOL)canReplay {
    return
    self.realStatus == JXVideoPlayerViewStatusPlaying ||
    self.realStatus == JXVideoPlayerViewStatusPause ||
    self.realStatus == JXVideoPlayerViewStatusEndPlaying ||
    self.realStatus == JXVideoPlayerViewStatusFailure;
}

- (void)replay {
    if (self.realStatus == JXVideoPlayerViewStatusPlaying ||
        self.realStatus == JXVideoPlayerViewStatusPause ||
        self.realStatus == JXVideoPlayerViewStatusEndPlaying ||
        self.realStatus == JXVideoPlayerViewStatusFailure ) {
        
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
    }
    else {

    }
}

- (BOOL)canPause {
    return
    self.realStatus == JXVideoPlayerViewStatusPlaying;
}

- (void)pause {
    self.realStatus = JXVideoPlayerViewStatusPause;
    [self.player pause];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (object == self.avPlayerItem) {
        if ([keyPath isEqualToString:@"status"]) {
            AVPlayerItemStatus status = jx_intValue(change[NSKeyValueChangeNewKey]);
            switch (status) {
                case AVPlayerItemStatusUnknown:
                {
                    self.realStatus = JXVideoPlayerViewStatusCannotBePlayedOrUnknown;
                } break;
                    
                case AVPlayerItemStatusReadyToPlay:
                {
                    _duration = CMTimeGetSeconds(self.avPlayerItem.duration);
                    self.videoPlayerReadyToPlay = YES;
                } break;
                    
                case AVPlayerItemStatusFailed:
                {
                    self.realStatus = JXVideoPlayerViewStatusCannotBePlayedOrUnknown;
                } break;
                    
                default: break;
            }
        }
        else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            _duration = CMTimeGetSeconds(self.avPlayerItem.duration);
            NSArray *array= self.avPlayerItem.loadedTimeRanges;
            CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
            CGFloat start = CMTimeGetSeconds(timeRange.start);
            CGFloat duration = CMTimeGetSeconds(timeRange.duration);
            CGFloat loadedTime = start + duration;
            JX_BLOCK_EXEC(self.loadingProgress, loadedTime, self.duration);
        }
    }
    else if (object == self.player) {
        if ([keyPath isEqualToString:@"rate"]) {
            // 播放
            if (self.player.rate == 1.0) {
                self.realStatus = JXVideoPlayerViewStatusPlaying;
            }
            // 暂停 或 结束播放
            else if (self.player.rate == 0.0) {
                CGFloat currentTime = CMTimeGetSeconds(self.player.currentTime);
                CGFloat duration = self.duration;
                if (currentTime != duration) {
                    self.realStatus = JXVideoPlayerViewStatusPause;
                }
            }
        }
    }
}

@end









