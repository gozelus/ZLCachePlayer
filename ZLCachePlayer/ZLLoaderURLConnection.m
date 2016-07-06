
//
//  ZLLoaderURLConnection.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/6.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLLoaderURLConnection.h"

@implementation ZLLoaderURLConnection





#pragma mark - AVAssetResourceLoaderDelegate


- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    
    
    NSLog(@"%s",__func__);
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge{
    
}

@end
