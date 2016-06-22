//
//  SecondModel.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/19.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "SecondModel.h"
#import "SecondTableViewCell.h"
@implementation SecondModel



-(void)setCellHeight{
    SecondTableViewCell *cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
    
    self.cellHight = [cell cellHeightWithModel:self];
}

-(SecondModel*)initWithDictionary:(NSDictionary*)dic;
{
    
    self.avatarUrl =[dic[@"user"]objectForKey:@"avatarUrl"];
    self.userNick =[dic[@"user"]objectForKey:@"userNick"];
    self.userId =[dic[@"user"]objectForKey:@"avatarUrl"];
    self.followerCount = [NSString stringWithFormat:@"%@",[dic[@"user"]objectForKey:@"followerCount"]];
    self.jobs =[dic[@"user"]objectForKey:@"jobs"];
    
    
    
    self.price_S = dic[@"price"];
    self.tag_S =dic[@"tag"];
    self.content_S = dic[@"content"];
    self.sales_S = [NSString stringWithFormat:@"%@",dic[@"sales"]];
    
    
    self.serviceScore =[NSString stringWithFormat:@"%@",dic[@"serviceScore"]];
    
    self.likeCount = [NSString stringWithFormat:@"%@",dic[@"likeCount"]];
    self.viewCount = [NSString stringWithFormat:@"%@",dic[@"viewCount"]];
    self.messageCount = [NSString stringWithFormat:@"%@",dic[@"messageCount"]];

    self.images = dic[@"images"];
    
    
    self.color_S =dic[@"pic"];
    
    return self;
}


@end
