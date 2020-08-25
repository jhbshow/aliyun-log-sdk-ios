# OTLog
阿里云日志上传

# Object-C接入
##方式一(cocopods集成)：
Step 1.在Podfie文件中添加
```   
pod 'OTAliyunLog'
```       
Step 2.引入头文件：
```   
@import OTAliyunLog;
```   
# Swift接入
Step 1.在Podfie文件中添加
```   
pod 'OTAliyunLog'
```    
Step 2.引入头文件：
```   
import OTAliyunLog
```   
# Usage(Object-C):
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


# 更新SDK
1. 打tag，到git仓库
```
git tag 1.0.0
```
2. 更新OTAliyunLog.podspec的version，和上面的tag对应
3. git仓库release 刚刚的tag
4. 发布到cocopods
```
pod trunk push OTAliyunLog.podspec --allow-warnings --verbose
```
5. 如果search不到执行：
```
pod repo add OTAliyunLog https://github.com/jhbshow/aliyun-log-sdk-ios.git
```
6. 如果刚更新SDK，执行pod install找不到(替代pod install执行):
```
pod install --repo-update
```
