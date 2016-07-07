
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
@property (nonatomic, strong) NSFileHandle    *fileHandle;
@property (nonatomic, strong) NSString        *tempPath;

@end

@implementation ZLLoaderURLConnection


- (instancetype)init{
    if (self = [super init]) {
        self.pendingRequest = [NSMutableArray array];
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        _tempPath =  [document stringByAppendingPathComponent:@"zlTemp.mp4"];
        [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];

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
    
    long long startOffet = dataRequest.requestedOffset;
    NSData *filedata = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_videoPath] options:NSDataReadingMappedIfSafe error:nil];
    
    

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
//    
//    [request addValue:[NSString stringWithFormat:@"bytes=%ld-%ld",(unsigned long)range.location, (unsigned long)range.length] forHTTPHeaderField:@"Range"];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
    [self.connection start];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:_tempPath];

    NSLog(@"%@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    //收到了数据 这个地方应该缓存下
    [self.fileHandle seekToEndOfFile];
    [self.fileHandle writeData:data];

    
    [self processPendingRequests];
    
    //缓存完毕通知 让外部重新获取数据
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //这里自己写需要保存数据的路径
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *movePath =  [document stringByAppendingPathComponent:@"保存数据.mp4"];
    
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:_tempPath toPath:movePath error:nil];
    if (isSuccess) {
        NSLog(@"rename success");
    }else{
        NSLog(@"rename fail");
    }
    NSLog(@"----%@", movePath);

}
@end
