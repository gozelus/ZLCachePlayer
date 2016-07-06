
//
//  ZLLoaderURLConnection.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/6.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLLoaderURLConnection.h"

@implementation ZLLoaderURLConnection

- (NSURL *)getSchemeVideoUrl:(NSURL *)url{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme =(NSString *) kMyScheme;
    return [components URL];
}










#pragma mark - AVAssetResourceLoaderDelegate


- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    
    
    
    return YES;
}

@end
