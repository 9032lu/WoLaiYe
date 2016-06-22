//
//  JingCaiCell.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "JingCaiCell.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
@implementation JingCaiCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews{
    CGFloat _with = [UIScreen mainScreen].bounds.size.width;
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, _with*0.4, _with*0.35)];
    imagv.backgroundColor = [UIColor redColor];
    [self addSubview:imagv];
    self.img_v = imagv;
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(imagv.frame)-30, CGRectGetWidth(imagv.frame), 30)];
    lable.backgroundColor = [UIColor colorWithHexString:@"#A975D9"];
    [imagv addSubview:lable];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor =[UIColor whiteColor];
    self.subTitle = lable;
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imagv.frame)+10, 10, _with*0.6, (_with*0.35-10)/3)];
    titles.textColor = [UIColor colorWithHexString:@"#A975D9"];
    titles.font = [UIFont systemFontOfSize:14];
    [self addSubview:titles];
    self.title_lab = titles;
    
    for (int i = 0; i < 4; i ++) {
        int X = i %2;
        int Y = i /2;
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        button.frame = CGRectMake(CGRectGetMinX(titles.frame) + X *(_with*0.24+10), CGRectGetMaxY(titles.frame)+Y*(CGRectGetHeight(titles.frame)+10), _with*0.24, CGRectGetHeight(titles.frame));
        
        button.tag =i +10000;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, CGRectGetMaxY(imagv.frame)+10, _with, 1);
    line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.contentView addSubview:line];

      
}

-(void)setModel:(JingcaiModel *)model{
    
    
    _model = model;
    
    [self.img_v sd_setImageWithURL:[NSURL URLWithString:self.model.img_url] placeholderImage:nil];

    self.subTitle.text = self.model.subTitl;
    self.subTitle.backgroundColor = [UIColor colorWithHexString:_model.color_S];
    self.title_lab.text = self.model.title_S;
    self.title_lab.textColor = [UIColor colorWithHexString:_model.color_S];

    for (int i = 0; i <4; i ++) {
        
        UIButton *but1 = (UIButton*)[self viewWithTag:10000+i];
        [but1 setTitle:[self.model.btn_A[i] objectForKey:@"tagName"] forState:UIControlStateNormal];
    }
   
    

}

-(CGFloat)cellHeightWithModel:(JingcaiModel *)model{
    
    _model = model;
    
    CGFloat h = CGRectGetMaxY(self.img_v.frame)+20;
    NSLog(@"====%f",h);

    return h;
    
}

@end
