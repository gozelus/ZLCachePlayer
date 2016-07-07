
//
//  ZLLoaderURLConnection.m
//  ZLCachePlayer
//
//  Created by 征里 on 16/7/6.
//  Copyright © 2016年 征里. All rights reserved.
//

#import "ZLLoaderURLConnection.h"

@interface ZLLoaderURLConnection()<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray *pendingRequest;
@property (nonatomic, strong) NSString *videoPath;
@property (nonatomic, strong) NSURLConnection *connection;


@end

@implementation ZLLoaderURLConnection


- (instancetype)init{
    if (self = [super init]) {
        self.pendingRequest = [NSMutableArray array];
    }
    return self;
}




#pragma mark - AVAssetResourceLoaderDelegate

/**
 *  必须返回Yes，如果返回NO，则resourceLoader将会加载出现故障的数据
 *  这里会出现很多个loadingRequest请求， 需要为每一次请求作出处理
 *  @param resourceLoader 资源管理器
 *  @param loadingRequest 每一小块数据的请求
 *
 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    [self.pendingRequest addObject:loadingRequest];
    [self dealWithLoadingRequest:loadingRequest];
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge{
    
}



#pragma mark - 处理数据相关

- (void)dealWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    NSLog(@"%s",__func__);
    [self processPendingRequests];
    
}

- (void)processPendingRequests{
    NSMutableArray *requestCompleted = [NSMutableArray array];
    
    for (AVAssetResourceLoadingRequest *loadingRequest in self.pendingRequest) {
        //处理数据
//        NSLog(@"需要处理数据======%@",loadingRequest);
        [self respondWithDataForRequest:loadingRequest.dataRequest];
    }
}

- (BOOL)respondWithDataForRequest:(AVAssetResourceLoadingDataRequest *)dataRequest{
    
//    long long startOffet = dataRequest.requestedOffset;
//    NSData *filedata = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_videoPath] options:NSDataReadingMappedIfSafe error:nil];
//
    BOOL isHave = NO;
    if (!isHave) {
        //开启网络请求
        [self startNetworkRequestWithRange:NSMakeRange(dataRequest.requestedOffset, dataRequest.requestedLength) url:_url];
    }
    
    return YES;
}

#define kCustomVideoScheme @"yourScheme"

- (void)startNetworkRequestWithRange:(NSRange)range url:(NSURL *)url{

    NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    actualURLComponents.scheme = @"http";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[actualURLComponents URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    

    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
    [self.connection start];
    
}



@end
