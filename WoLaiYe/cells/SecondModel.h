//
//  SecondModel.h
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/19.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SecondModel : NSObject

@property(nonatomic,assign) CGFloat cellHight;



// 人物。

@property(nonatomic,copy)NSString *avatarUrl; //头像
@property(nonatomic,copy)NSString *userNick; //昵称
@property(nonatomic,copy)NSString *userGender; //性别
@property(nonatomic,copy)NSString *userId; //用户ID
@property(nonatomic,copy)NSString *followerCount; //粉丝数
@property(nonatomic,assign)BOOL focused; //关注
@property(nonatomic,strong)NSArray *jobs; //工作



@property(nonatomic,strong)NSArray *images; //图片

@property(nonatomic,copy)NSString *color_S; //颜色


@property(nonatomic,copy) NSString *price_S; //价格
@property(nonatomic,copy) NSString *tag_S; //标签
@property(nonatomic,copy) NSString *content_S; //内容
@property(nonatomic,copy) NSString *sales_S; //已售
@property(nonatomic,copy) NSString *serviceScore; //已售


@property(nonatomic,copy) NSString *likeCount; //喜欢
@property(nonatomic,copy) NSString *viewCount; //
@property(nonatomic,copy) NSString *messageCount; //消息






-(SecondModel*)initWithDictionary:(NSDictionary*)dic;


@end
