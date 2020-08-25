# OTLog
阿里云日志上传

---

## 接入
* Object-C(cocopods集成)：
1. 在Podfie文件中添加
```ruby   
pod 'OTAliyunLog'
```       
2. 引入头文件：
``` objective-c  
@import OTAliyunLog;
```   
* Swift(cocopods集成)
1. 在Podfie文件中添加
```ruby   
pod 'OTAliyunLog'
```    
2. 引入头文件：
```objective-c   
import OTAliyunLog
```  

---

## Usage:
#### Object-C
* 初始化参数
```objective-c
NSString *regionEndpoint = @"cn-shenzhen.log.aliyuncs.com";
NSString * logStoreName = @"jhb-logstore-test";
NSString * projectName = @"jhb-log-test";
NSString * accessKeySecret = @"CYFJz************62i0P";
NSString * accessKeyId = @"LTAI4F************YoipRi";
OTLogConfig *config = [[OTLogConfig alloc]initWithEndPoint:regionEndpoint accessKeyID:accessKeyId accessKeySecret:accessKeySecret projectName:projectName logStoreName:logStoreName token:NULL];
[OTLogManager.sharedInstance setupConfigWithLogConfig:config];
```
* 上传日志:
```objective-c
OTLogModel *logModel = [[OTLogModel alloc]init];
[logModel PutContent:@"url" value:@"/test/url"];
[logModel PutContent:@"userId" value:@"23232"];
OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel] logTagContentMap:NULL];
[[OTLogManager sharedInstance] postLog:logGroupModel call:^(OTPostLogResult * result) {
    NSLog(@"%@",[result.response description]);
}];
```
* 保存日志:
```objective-c
OTLogModel *logModel = [[OTLogModel alloc]init];
  [logModel PutContent:@"url" value:@"/test/url"];
  [logModel PutContent:@"userId" value:@"23232"];
OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel] logTagContentMap:NULL];
[[OTLogManager sharedInstance] saveLogWithLogGroupModel:logGroupModel];
```
* 上传本地日志(60秒上传一次):
```objective-c
[[OTLogManager sharedInstance] startUploadLogWithTimeInterval:60];
```   

---

## SDK更新
1. 打tag（发布对应的版本），到git仓库
``` ruby
git tag 1.0.0
```
2. 更新OTAliyunLog.podspec文件中的version，和上面的tag对应
3. 到 git仓库release 刚刚的tag版本
4. 发布到cocopods
```ruby
pod trunk push OTAliyunLog.podspec --allow-warnings --verbose
```
5. pod search找不到：
```ruby
pod repo add OTAliyunLog https://github.com/jhbshow/aliyun-log-sdk-ios.git
```
6. 刚更新SDK，执行pod install找不到:
```ruby
pod install --repo-update
```
