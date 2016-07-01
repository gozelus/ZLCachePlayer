//
//  ZLMediaPlayer.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/1.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLMediaPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface ZLMediaPlayer()

@property (nonatomic, strong)AVPlayer *player;

@end

@implementation ZLMediaPlayer

+(Class)layerClass{
    return [AVPlayerLayer class];
}

- (AVPlayer *)player{
    return [(AVPlayerLayer *)self.layer player];
}

- (void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
