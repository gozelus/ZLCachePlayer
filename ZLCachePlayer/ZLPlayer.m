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
#import "ZLLoaderURLConnection.h"
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
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) AVPlayerItem *currentPlayItem;

@property (nonatomic, strong) ZLLoaderURLConnection *resourceLoader;


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

- (void)setupObserve{
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)syncUI{
    self.playerView = [[ZLMediaPlayer alloc] init];
    self.playerView.backgroundColor = [UIColor redColor];

}
- (void)releasePlayer{
    
}
- (void)setUrl:(NSURL *)url superView:(UIView *)view frame:(CGRect)frame{

    [self removeItemObbserve];
    
    self.resourceLoader = [[ZLLoaderURLConnection alloc] init];
    NSURL *schemeUrl = [self.resourceLoader getSchemeVideoUrl:url];
    self.currentPlayItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];

    self.urlAsset =[AVURLAsset URLAssetWithURL:schemeUrl options:nil];
    [self.urlAsset.resourceLoader setDelegate:self.resourceLoader queue:dispatch_get_main_queue()];
    
    if (!self.player) {
        self.player =  [AVPlayer playerWithPlayerItem:self.currentPlayItem] ;
    }else{
        [self.player replaceCurrentItemWithPlayerItem:self.currentPlayItem];
    }
    self.playerView.frame = frame;
    [self.playerView setPlayer:self.player];
    [view addSubview:self.playerView];

    [self.currentPlayItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)removeItemObbserve{
    [self.currentPlayItem removeObserver:self forKeyPath:@"status"];
    
}






- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%ld",(long)self.currentPlayItem.status);
    
    if ([keyPath isEqualToString:@"status"]) {
        if (self.playerItem.status == AVPlayerStatusReadyToPlay) {
            [self.player play];
        }
    }
}






@end
