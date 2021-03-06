//
//  ViewController.m
//  OTLogDemo
//
//  Created by cuirhong on 2020/6/16.
//  Copyright © 2020 cuirhong. All rights reserved.
//

#import "ViewController.h"

#import "OTLog_Demo-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configAliyunLog];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    [button setTitle:@"上传日志" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saveLogButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 200, 100)];
    [saveLogButton setTitle:@"保存日志" forState:UIControlStateNormal];
    [saveLogButton setBackgroundColor:UIColor.redColor];
    [self.view addSubview:saveLogButton];
    [saveLogButton addTarget:self action:@selector(saveLog) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *uploadLocalLogButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 200, 100)];
    [uploadLocalLogButton setTitle:@"上传本地日志" forState:UIControlStateNormal];
    [uploadLocalLogButton setBackgroundColor:UIColor.redColor];
    [self.view addSubview:uploadLocalLogButton];
    [uploadLocalLogButton addTarget:self action:@selector(uploadLocalLog) forControlEvents:UIControlEventTouchUpInside];
}

-(void) configAliyunLog{
    NSString *regionEndpoint = @"cn-shenzhen.log.aliyuncs.com";
    NSString * logStoreName = @"jhb-logstore-test";
    NSString * projectName = @"jhb-log-test";
    NSString * accessKeySecret = @"CYFJz************62i0P";
    NSString * accessKeyId = @"LTAI4F************YoipRi";
    OTLogConfig *config = [[OTLogConfig alloc]initWithEndPoint:regionEndpoint accessKeyID:accessKeyId accessKeySecret:accessKeySecret projectName:projectName logStoreName:logStoreName token:NULL];
    [OTLogManager.sharedInstance setupConfigWithLogConfig:config];
}

-(void)clickTest{
    
    
    OTLogModel *logModel = [[OTLogModel alloc]init];
    [logModel putLogContent:@"url" value:@"/test/url"];
    [logModel putLogContent:@"userId" value:@"23232"];
    OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel]];
    [[OTLogManager sharedInstance] postLog:logGroupModel logLevel:OTLogLevelWarn call:^(OTPostLogResult * _Nonnull logResult) {
        NSLog(@"%@", [logResult.response description]);
    }];
}

-(void) saveLog{
    OTLogModel *logModel = [[OTLogModel alloc]init];
    [logModel putLogContent:@"url" value:@"/test/url"];
    [logModel putLogContent:@"userId" value:@"23232"];
    
    OTLogGroupModel *logGroupModel = [[OTLogGroupModel alloc] initWithLogTopic:@"topic-20200616" logSource:@"source-20200616" logContents:@[logModel]];
    [[OTLogManager sharedInstance] saveLogWithLogGroupModel:logGroupModel call:^(BOOL isSuccful, NSError * _Nullable error) {
         
    }];
    
    
}

-(void) uploadLocalLog{
//    [[OTLogManager sharedInstance] deleteLogWithLogGroupModel:nil];
    [[OTLogManager sharedInstance] startUploadLogWithTimeInterval:60];
}

@end


