//
//  WebViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/22.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "WebViewController.h"
#import "UIColor+Hex.h"
@interface WebViewController ()<UIWebViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UIView          *_loadingView;

}
@end

@implementation WebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(void)backClick{
    POP
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    
    TOP_VIEW(self.title_s)
    topView.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64-1, _width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [topView addSubview:line1];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];

    LOADING_VIEW

}

-(void)removeLoadView
{
    LOADING_REMOVE
    //ALERT(@"请求超时，请稍后重试")
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    LOADING_REMOVE
    
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

@end
