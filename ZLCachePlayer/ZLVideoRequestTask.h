//
//  ZLVideoRequestTask.h
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/7.
//  Copyright © 2016年 征里. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLVideoRequestTask : NSObject


@property (nonatomic, strong, readonly) NSURL *url;

@property (nonatomic, readonly        ) NSUInteger                 offset;
@property (nonatomic, readonly        ) NSUInteger                 videoLength;
@property (nonatomic, readonly        ) NSUInteger                 downLoadingOffset;
@property (nonatomic, strong, readonly) NSString                   * mimeType;
@property (nonatomic, assign)           BOOL                       isFinishLoad;



@end
