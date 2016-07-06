//
//  ZLLoaderURLConnection.h
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/6.
//  Copyright © 2016年 征里. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

static const NSString *kMyScheme = @"MyScheme";


@interface ZLLoaderURLConnection : NSObject<AVAssetResourceLoaderDelegate>


- (NSURL *)getSchemeVideoUrl:(NSURL *)url;


@end
