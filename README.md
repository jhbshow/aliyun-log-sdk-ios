# OTLog
阿里云日志上传

---

## 接入(cocopods集成)
1. 在Podfie文件中添加：
```ruby   
pod 'OTAliyunLog'
```       
2. 引入头文件：
* OC
```objective-c  
@import OTAliyunLog;
```   
* swift：
```swift  
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
1. 打tag（SDK对应的版本），push到git仓库
```ruby
git tag 1.0.0
git push --tags
```
2. 更新OTAliyunLog.podspec文件中的version(与上面的tag对应)
```ruby
spec.version      = "1.0.0"
```
3. git仓库Release刚刚的tag版本

4. 发布到cocopods：
```ruby
pod trunk push OTAliyunLog.podspec --allow-warnings --verbose
```
5. 更新SDK之后，pod install找不到:
```ruby
pod install --repo-update
```
