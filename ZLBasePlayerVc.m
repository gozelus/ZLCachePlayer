
//
//  ZLBasePlayerVc.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/1.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLBasePlayerVc.h"
#import "ZLCachePlayer/ZLPlayer.h"
@interface ZLBasePlayerVc()
@property (nonatomic, strong) ZLPlayer *player;

@end
@implementation ZLBasePlayerVc

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    NSURL *url = [NSURL URLWithString:@"http://beauty1.meitudata.com/94010c7dccb18f48f64990cbb77edc89.mp4"];
    
    self.player = [ZLPlayer sharePlayer];
  [ self.player setUrl:url superView:self.view frame:CGRectMake(0, 0, 100, 100)];
    
}

@end
