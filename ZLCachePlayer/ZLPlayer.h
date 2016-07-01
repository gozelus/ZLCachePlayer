//
//  ZLPlayer.h
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/1.
//  Copyright © 2016年 征里. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  播放器集合 单粒
 */


@interface ZLPlayer : NSObject

/**
 *  获得单粒
 */
+ (instancetype)sharePlayer;


- (void)setUrl:(NSURL *)url superView:(UIView *)view frame:(CGRect)frame;


@end
