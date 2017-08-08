//
//  ViewController.m
//  NetManager
//
//  Created by 郭榜 on 2017/5/15.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "ViewController.h"
#import "GetHistoryReq.h"
#import "IndexViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GetHistoryReq *req = [[GetHistoryReq alloc] init];
    [req addParametersFuncMonth:@"4" andDay:@"13"];
    
    [req setSuccessBlock:^(id data) {
        HttpModel *httpModel = data;
        NSString *dataStr = httpModel.formatPayload;
        NSLog(@"datadatadatadatadata = %@", dataStr);
        
    } failureBlock:^(NSError *error) {
        
        
        NSLog(@"error = %@", error);
        
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    
    
//    http://api.juheapi.com/japi/toh?key=您申请的KEY&v=1.0&month=11&day=1
//    http://api.juheapi.com/japi/toh/?day=13&key=7528a751b7a7e3772a9845114b0d9e51&month=4&v=1.0
//    http://api.juheapi.com/japi/toh/?&day=13&key=7528a751b7a7e3772a9845114b0d9e51&month=4&v=1.0

}

-(void)btnAction {
    IndexViewController *index = [[IndexViewController alloc] init];
    index.name = @"helloworld";
    index.password = @"123";
    
    [self.navigationController pushViewController:index animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
