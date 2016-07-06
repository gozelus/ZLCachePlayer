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
static NSString *fakeSchemePrefix = @"streaming";


#define kCustomVideoScheme @"yourScheme"

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
#define kCustomVideoScheme @"yourScheme"

- (void)setUrl:(NSURL *)url superView:(UIView *)view frame:(CGRect)frame{

    self.resourceLoader = [[ZLLoaderURLConnection alloc] init];

    NSURL *currentURL = [NSURL URLWithString:@"http://***.***.***"];
    NSURLComponents *components = [[NSURLComponents alloc]initWithURL:currentURL resolvingAgainstBaseURL:NO];
    ////注意，不加这一句不能执行到回调操作
    components.scheme = kCustomVideoScheme;
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:components.URL
                                               options:nil];
    //_resourceManager在接下来讲述
    [urlAsset.resourceLoader setDelegate:_resourceLoader queue:dispatch_get_main_queue()];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:urlAsset];
    _currentPlayItem = item;
    
    
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


- (NSURL *)fakeUrl:(NSURL *)realUrl {
    NSURLComponents *components = [[NSURLComponents alloc]initWithURL:realUrl resolvingAgainstBaseURL:NO];
    
    NSString *scheme = components.scheme;
    scheme = [fakeSchemePrefix stringByAppendingString:scheme];
    components.scheme = scheme;
    
    return components.URL;
}






@end
