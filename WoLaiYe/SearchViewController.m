//
//  SearchViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    SCREEN_WIDTH_AND_HEIGHT
}
@end

@implementation SearchViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
SCREEN
TOP_VIEW(@"search")
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
