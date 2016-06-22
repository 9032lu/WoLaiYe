//
//  JingcaiModel.h
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JingcaiModel : NSObject


@property(nonatomic,assign) CGFloat cellHight;

@property(nonatomic,copy)NSString *img_url; //图片
@property(nonatomic,copy)NSString *title_S;//主题
@property(nonatomic,copy) NSString *subTitl; //描述
@property(nonatomic,strong)NSArray *btn_A; //按钮

@property(nonatomic,copy)NSString *color_S; //颜色


-(JingcaiModel*)initWithDictionary:(NSDictionary*)dic;

@end
