//
//  JingcaiModel.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "JingcaiModel.h"
#import "JingCaiCell.h"
@implementation JingcaiModel



-(void)setCellHeight{
    JingCaiCell *cell = [[JingCaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    _cellHight = [cell cellHeightWithModel:self];
    
}

-(JingcaiModel*)initWithDictionary:(NSDictionary*)dic;
{
    
    self.img_url = [dic[@"custom"]objectForKey:@"pic"];
    self.title_S =[dic[@"custom"]objectForKey:@"title"];
    self.subTitl = [dic[@"custom"]objectForKey:@"subTitle"];
    self.btn_A = [dic[@"custom"]objectForKey:@"links"];
    self.color_S =[dic[@"custom"]objectForKey:@"color"];
    
    return self;
}


@end
