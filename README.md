# OTLog
阿里云日志上传

# Object-C接入
##方式一(cocopods集成)：
Step 1.在Podfie文件中添加

    pod 'OTLogTest'
    
Step 2.需要使用的OC文件中引入头文件：

     #import <OTLog/OTLog-Swift.h>
 
 # Example:
 
    NSString *regionEndpoint = @"cn-shenzhen.log.aliyuncs.com";
    NSString * logStoreName = @"jhb-logstore-test";
    NSString * projectName = @"jhb-log-test";
    NSString * accessKeySecret = @"CYFJzYx***********2i0P";
    NSString * accessKeyId = @"LTAI4FzJ**********YoipRi";
    
    OTLogConfig *config = [[OTLogConfig alloc]initWithEndPoint:regionEndpoint accessKeyID:accessKeyId accessKeySecret:accessKeySecret projectName:projectName logStoreName:logStoreName token:NULL];
    [OTLogManager.sharedInstance setupConfigWithLogConfig:config];
    
    OTLogModel *logModel = [[OTLogModel alloc]init];
    [logModel PutContent:@"url" value:@"/test/url"];
    [logModel PutContent:@"userId" value:@"23232"];
    
    OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel] logTagContentMap:NULL];
    
    [OTLogManager.sharedInstance postLog:logGroupModel call:^(NSURLResponse * response, NSError * error) {
        if(error){
            NSLog(@"%@", [error description]);
        }else{
            NSLog(@"%@", [response description]);
        }
    }];
 
