##视频播放器调研

###调研意义：
1.变美志是一款以播放内容为核心的APP，播放器的性能对于用户体验的提升至关重要。

2.项目内部播放器目前仍有可以改进的空间，可调研市面上优秀的播放器进一步提升播放器性能。

###调研目标：
1.调研市面上的播放器，和公司内部提供的播放器对比，寻求差异化。

2.结合差异化，选择合适的方案并适配到变美志里，提高播放器性能，提供更好的用户体验。
###具体内容及排期：

####目前市面上有三种播放方案，分为：
* ``` FFmpeg```

	功能强大，能满足复杂需求，也意味着复杂，需要掌握视频编解码知识	以及和 C 语言打交道。
	
* ```HttpServer```(即目前变美志所使用的方案)

	在应用内搭建一个```HttpServer```，```Server ```再请求视频资源。说白了	是一个 ```agent```，虽说比 ```FFmpeg ```简单些，可是工作量也是不小。

* ```ResourceLoader```
	
	```AVURLAsset``` 有个 ```AVAssetResourceLoaderDelegate```，是资源	加载的```delgate```，轻量级，适用。关于该方案，可以参考这篇博文（http://www.codeproject.com/Articles/875105/Audio-streaming-and-caching-in-iOS-using）, 但是该方案有一个局限性，只能适用于```AVFoundation```框架的```AVplayer```播放器，需要```ios7```及以上系统。
	
######调研目标：```MTCache```边下边播（即```ResourceLoader```）

* 这个```SDK```目前提供的一种缓存策略，核心是ios7推出的```resourceLoader```代理方法接口。可以拦截视频资源的请求，在这个地方检察下本地是否有缓存内容，如有则播放本地缓存，否则播放下载资源。因为APP目前最低适配```ios7```故这个方案目前是可行的。
  
  
* 这周任务核心就是调研```resourceLoader```的相关资料，具体排期：
 - ```resourceLoader```  及其代理的作用(已完成)
 - ```resourceLoaderDelegate```的基本实现(7-06)
 - 配合```resourceLoaderDelegate```使用的网络缓存加载器(7-07)
 - ```Tast```与```RequestModel```(7-08)
    
