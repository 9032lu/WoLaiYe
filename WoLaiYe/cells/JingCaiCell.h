//
//  JingCaiCell.h
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingcaiModel.h"
static NSString *identifier = @"cellID";

@interface JingCaiCell : UITableViewCell

@property(nonatomic,strong) JingcaiModel *model;
@property (nonatomic,weak) UIImageView *img_v;  //图片
@property (nonatomic,weak) UILabel *subTitle;
@property(nonatomic,weak)UILabel * title_lab;//标题



-(CGFloat)cellHeightWithModel:(JingcaiModel*)model;

@end
