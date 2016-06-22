//
//  ScanViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/21.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()
{
    SCREEN_WIDTH_AND_HEIGHT
}
@end

@implementation ScanViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)backClick{
    POP
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"扫一扫")
    topView.backgroundColor =[UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    
    
    
    
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
