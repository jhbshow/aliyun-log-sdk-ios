# OTLog
阿里云日志上传

# Object-C接入
##方式一(cocopods集成)：
Step 1.在Podfie文件中添加
```   
pod 'OTAliyunLog'
```       
Step 2.支持引用swift文件即可，到：
```   
Xcode(Build Settings中查找Objective-C Generated Interface Header Name)->文件中引入这个.h文件即可使用
```   
# Usage:
### 初始化参数
``` 
NSString *regionEndpoint = @"cn-shenzhen.log.aliyuncs.com";
NSString * logStoreName = @"jhb-logstore-test";
NSString * projectName = @"jhb-log-test";
NSString * accessKeySecret = @"CYFJz************62i0P";
NSString * accessKeyId = @"LTAI4F************YoipRi";
OTLogConfig *config = [[OTLogConfig alloc]initWithEndPoint:regionEndpoint accessKeyID:accessKeyId accessKeySecret:accessKeySecret projectName:projectName logStoreName:logStoreName token:NULL];
[OTLogManager.sharedInstance setupConfigWithLogConfig:config];
```   
### 上传日志:
```   
OTLogModel *logModel = [[OTLogModel alloc]init];
[logModel PutContent:@"url" value:@"/test/url"];
[logModel PutContent:@"userId" value:@"23232"];
OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel] logTagContentMap:NULL];
[[OTLogManager sharedInstance] postLog:logGroupModel call:^(OTPostLogResult * result) {
    NSLog(@"%@",[result.response description]);
}];
```   
### 保存日志:
```   
OTLogModel *logModel = [[OTLogModel alloc]init];
  [logModel PutContent:@"url" value:@"/test/url"];
  [logModel PutContent:@"userId" value:@"23232"];
OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel] logTagContentMap:NULL];
[[OTLogManager sharedInstance] saveLogWithLogGroupModel:logGroupModel];
```   
### 上传本地日志:
```   
[[OTLogManager sharedInstance] startUploadLogWithTimeInterval:60];
```   
