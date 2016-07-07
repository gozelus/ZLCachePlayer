//
//  ZLLoaderURLConnection.h
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/6.
//  Copyright © 2016年 征里. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ZLLoaderURLConnection : NSObject<AVAssetResourceLoaderDelegate>


@property (nonatomic, strong) NSURL *url;


@end
