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

- (void)syncUI{
    if (self.player.currentItem != nil && [self.player.currentItem status] == AVPlayerStatusReadyToPlay) {
        //做一些通知
    }
}


@end
