
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSURL *url2 = [NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"];

//    NSURL *url = [NSURL URLWithString:@"http://beauty1.meitudata.com/94010c7dccb18f48f64990cbb77edc89.mp4"];
    
    self.player = [ZLPlayer sharePlayer];
  [ self.player setUrl:url2 superView:self.view frame:CGRectMake(100, 100, 100, 100)];
    
}

@end
