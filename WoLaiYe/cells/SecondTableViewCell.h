//
//  SecondTableViewCell.h
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/19.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecondModel.h"
static NSString *secondCellID = @"secondCellID";

@interface SecondTableViewCell : UITableViewCell



@property(nonatomic,strong) SecondModel *model;

@property(nonatomic,weak)UIImageView *avatarUrl; //头像
@property(nonatomic,weak)UILabel *userNick; //昵称
@property(nonatomic,copy)NSString *userGender; //性别
@property(nonatomic,copy)NSString *userId; //用户ID
@property(nonatomic,weak)UILabel *followerCount; //粉丝数
//@property(nonatomic,assign)BOOL focused; //关注
@property(nonatomic,weak)NSArray *jobs; //工作


//工作相关的信息
@property(nonatomic,weak)UIImageView *starImg;
@property(nonatomic,weak)UILabel *person_state;


@property(nonatomic,weak)NSArray *images; //图片

//@property(nonatomic,copy)NSString *color_S; //颜色


@property(nonatomic,weak) UILabel *price_S; //价格
@property(nonatomic,weak) UILabel *tag_S; //标签
@property(nonatomic,weak) UILabel *content_S; //内容
@property(nonatomic,weak) UILabel *sales_S; //已售
@property(nonatomic,weak) UILabel *serviceScore; //消息


@property(nonatomic,weak) UILabel *likeCount; //喜欢
@property(nonatomic,weak) UILabel *viewCount; //
@property(nonatomic,weak) UILabel *messageCount; //消息




-(CGFloat)cellHeightWithModel:(SecondModel*)model;

@end
