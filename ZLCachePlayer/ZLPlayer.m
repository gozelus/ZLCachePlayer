//
//  ZLPlayer.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/1.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLPlayer.h"
#import "ZLMediaPlayer.h"
#import <AVFoundation/AVFoundation.h>

//播放器的几种状态
typedef NS_ENUM(NSInteger, TBPlayerState) {
    TBPlayerStateBuffering = 1,
    TBPlayerStatePlaying   = 2,
    TBPlayerStateStopped   = 3,
    TBPlayerStatePause     = 4
};
@interface ZLPlayer()

@property (nonatomic, strong)ZLMediaPlayer *playerView;

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *playerItem;

@property (nonatomic, strong) NSURL *url;

@end

@implementation ZLPlayer

/**
 *  获取单粒的
 */
+ (instancetype)sharePlayer{
    static dispatch_once_t onceToke;
    static id _instance;
    dispatch_once(&onceToke, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [self syncUI];
    }
    return self;
}
- (void)setUrl:(NSURL *)url{
    if (url) {
        _url = url;
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        self.playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerView = [[ZLMediaPlayer alloc] init];
        [self.playerView setPlayer:self.player];
        [self setupObserve];
    }
}
- (void)setupObserve{
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)syncUI{
    if (self.player.currentItem != nil && [self.player.currentItem status] == AVPlayerStatusReadyToPlay) {
        //做一些通知
    }
}
- (void)releasePlayer{
    
}
- (void)setUrl:(NSURL *)url superView:(UIView *)view frame:(CGRect)frame{
    [self releasePlayer];
    self.url = url;
    self.playerView.frame = frame;
    self.playerView.backgroundColor = [UIColor redColor];
    [view addSubview:self.playerView];
}






- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%ld",(long)self.playerItem.status);
    
    if ([keyPath isEqualToString:@"status"]) {
        if (self.playerItem.status == AVPlayerStatusReadyToPlay) {
            [self.player play];
        }
    }
}






@end
