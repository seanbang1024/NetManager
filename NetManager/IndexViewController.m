//
//  IndexViewController.m
//  NetManager
//
//  Created by 郭榜 on 2017/6/19.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "IndexViewController.h"

#define IMG1(name) ([UIImage imageNamed:name])

#define ADD(a,b) (a + b)

@interface IndexViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *passText;
- (IBAction)loginButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *logBtn;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blueColor];
    
//    NSLog(@"%@ ====== %@", self.name1, self.password1);
    self.nameText.text = @"1111";
    self.passText.text = @"22222";
    
    void (^blockT1)(NSString *, NSInteger) = ^(NSString *str, NSInteger a) {
        
        NSLog(@"%@", str);
        
    };
    blockT1(@"123", 1);
    
    IMG1(@"a");
    
    NSLog(@"%d", ADD(1, 2));
    
    
}
+ (void)PostUrlString:(NSString *)url
           parameters:(NSDictionary *)parameters
            imageData:(NSData *)imageData
             filePath:(NSString *)path
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failuer
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 15.f;
    //    acceptableContentTypes
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"text/plain",nil];
    
    NSMutableString *Newurl;
    
    NSString *str = @"";
    
    Newurl = [NSMutableString stringWithFormat:@"%@%@",str,url==nil?@"":url];
    
    
    [manager POST:Newurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *img = [UIImage imageWithData:imageData];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:path.lastPathComponent mimeType:@"image/jpg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success(response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failuer(error);
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(UIButton *)sender {
    
    [self.logBtn setTitle:@"login" forState:UIControlStateNormal];

    
}
@end
