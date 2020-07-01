//
//  ViewController.m
//  OTLogDemo
//
//  Created by cuirhong on 2020/6/16.
//  Copyright © 2020 cuirhong. All rights reserved.
//

#import "ViewController.h"
//#import <OTLog/OTLog-Swift.h>
#import <OTLog/OTLog-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    [button setTitle:@"上传日志" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)clickTest{
    NSString *regionEndpoint = @"cn-shenzhen.log.aliyuncs.com";
    NSString * logStoreName = @"jhb-logstore-test";
    NSString * projectName = @"jhb-log-test";
    NSString * accessKeySecret = @"CYFJzYxv39DItAbpcuzYVQaxb62i0P";
    NSString * accessKeyId = @"LTAI4FzJS8b8cQVwiQYoipRi";
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
}


@end
