//
//  SecondTableViewCell.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/19.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"

@interface SecondTableViewCell ()
{
        CGFloat personH;
    CGFloat _width;
    
    UIImageView *imgView0;
    UIImageView *imgView1;
    UIImageView *imgView2;

}



//@property (nonatomic,weak) UILabel *content; //显示文本的label

//定义一个contentLabel文本高度的属性
@property (nonatomic,assign) CGFloat contentLabelH;

@end
@implementation SecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    
    return self;
}

-(void)creatSubViews{
      _width = [UIScreen mainScreen].bounds.size.width;

    personH = 40;
    //添加店家
    
    UIImageView *person_img = [[UIImageView alloc]init];
    person_img.layer.cornerRadius = personH/2;
    person_img.clipsToBounds = YES;
    [self.contentView addSubview:person_img];
    self.avatarUrl = person_img;
    
    UILabel *person_name = [UILabel new];
    person_name.font = [UIFont systemFontOfSize:11];
    person_name.text = @"慕辰";
    person_name.textColor = [UIColor blackColor];
    [self.contentView addSubview:person_name];
    self.userNick = person_name;
    
    UIImageView *starImg = [[UIImageView alloc]init];
    [self.contentView addSubview:starImg];
    self.starImg = starImg;
    
    UILabel *person_state = [UILabel new];
    person_state.font = [UIFont systemFontOfSize:11];
    person_state.text = @"初级主播";
    person_state.textColor = [UIColor blackColor];
    [self.contentView addSubview:person_state];
    self.person_state = person_state;
    
    
    UILabel *fensiLab = [[UILabel alloc]init];
    fensiLab.font = [UIFont systemFontOfSize:9.5];
    fensiLab.text = @"12粉丝|相距很远";
    fensiLab.textAlignment = NSTextAlignmentRight;
    fensiLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:fensiLab];
    self.followerCount = fensiLab;
    
    UIButton *foucesbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [foucesbtn setTitle:@"+关注" forState:UIControlStateNormal];
    foucesbtn.titleLabel.font = [UIFont systemFontOfSize:11];
    foucesbtn.layer.cornerRadius = 5;
    foucesbtn.layer.borderColor= [UIColor blackColor].CGColor;
    foucesbtn.layer.borderWidth = 0.6;
    foucesbtn.clipsToBounds= YES;
    [foucesbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:foucesbtn];

    
    
    //店家约束
    [person_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(personH);
        make.height.mas_equalTo(personH);
    }];
    
    [person_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(person_img.mas_right).offset(10);
        make.centerY.mas_equalTo(person_img.mas_centerY).offset(-7);
        make.height.mas_equalTo(personH/2);
        make.width.mas_equalTo(_width);
        
    }];
    
    [starImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(person_img.mas_centerY).offset(7);
        make.left.mas_equalTo(person_img.mas_right).offset(10);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(10);

    }];
    [person_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(person_img.mas_centerY).offset(7);
        make.left.mas_equalTo(starImg.mas_right).offset(3);
        make.height.mas_equalTo(personH/2);
        make.width.mas_equalTo(_width);
        
    }];
    
    [fensiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(-8);
        make.width.mas_equalTo(_width);
        make.height.mas_equalTo(15);
        
    }];
    
    [foucesbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fensiLab.mas_bottom).offset(2);
        make.right.mas_equalTo(fensiLab.mas_right);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo (25);
        
    }];

    //图片
    
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(8+i *(_width-16)/3, personH+12, (_width-20)/3, (_width-20)/3)];
//        imgV.backgroundColor = APP_ClOUR;
        if (i==0) {
            imgView0= imgV;
        }else if(i ==1){
            imgView1= imgV;
        }else{
            imgView2 = imgV;
        }
        [self.contentView addSubview:imgV];
    }
    
    
    UILabel *lab_Ican= [[UILabel alloc]initWithFrame:CGRectMake(8, personH+12+(_width-20)/3, _width-100, 20)];
    lab_Ican.text = @"我能 · 陪聊";
    lab_Ican.textColor =[UIColor lightGrayColor];
    lab_Ican.font = [UIFont systemFontOfSize:11.5];
    [self.contentView addSubview:lab_Ican];
    self.tag_S = lab_Ican;
    
    //喜欢
    UIImageView *xihuanImg = [[UIImageView alloc]init];
    xihuanImg.image = [UIImage imageNamed:@"zan"];
    [self.contentView addSubview:xihuanImg ];
    
    UILabel *likeLab = [[UILabel alloc]init];
    likeLab.font = [UIFont systemFontOfSize:9];
    likeLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:likeLab];
    
    self.likeCount = likeLab;
    // 聊天
    UIImageView *liaotianImg = [[UIImageView alloc]init];
    liaotianImg.image = [UIImage imageNamed:@"Message"];
    [self.contentView addSubview:liaotianImg];
    
    UILabel *liaotianLab = [[UILabel alloc]init];
    liaotianLab.font = [UIFont systemFontOfSize:9];
    liaotianLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:liaotianLab];
    self.viewCount = liaotianLab;
    
    //浏览数
    UIImageView *liulanImg = [[UIImageView alloc]init];
    liulanImg.image = [UIImage imageNamed:@"mainCellComment"];
    [self.contentView addSubview:liulanImg];
    
    UILabel *liulanshuLab = [[UILabel alloc]init];
    liulanshuLab.font = [UIFont systemFontOfSize:9];
    liulanshuLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:liulanshuLab];
    self.messageCount = liulanshuLab;
    
    [liulanshuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.tag_S.mas_top);
        make.height.mas_equalTo(self.tag_S.mas_height);
        
    }];
    
    [liulanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(10);
        make.centerY.mas_equalTo(liulanshuLab.mas_centerY);
        make.right.mas_equalTo(liulanshuLab.mas_left).offset(-2);
    }];
    
    
    [liaotianLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(liulanImg.mas_left).offset(-2);
        make.top.mas_equalTo(self.tag_S.mas_top);
        make.height.mas_equalTo(self.tag_S.mas_height);
        
    }];
    
    [liaotianImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(10);
        make.centerY.mas_equalTo(liaotianLab.mas_centerY);
        make.right.mas_equalTo(liaotianLab.mas_left).offset(-2);
    }];
    
    [likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(liaotianImg.mas_left).offset(-2);
        make.top.mas_equalTo(self.tag_S.mas_top);
        make.height.mas_equalTo(self.tag_S.mas_height);
        
    }];
    [xihuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(10);
        make.centerY.mas_equalTo(likeLab.mas_centerY);
        make.right.mas_equalTo(likeLab.mas_left).offset(-2);
    }];
    
    
    //添加内容
    UILabel *content_lab = [UILabel new];
    content_lab.font = [UIFont systemFontOfSize:12];
    content_lab.numberOfLines=2;
    content_lab.textColor = [UIColor darkGrayColor];
    content_lab.text = @"sd水电费拉卡开始看对方看看书的十大；离开是；大量发士大夫撒离开v";
    self.content_S = content_lab;
    [self.contentView addSubview:content_lab];
    
    
    
    
    
   //线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.contentView addSubview:line];
 //已售
    UILabel *labselled = [[UILabel alloc]init];
    labselled.text = @"[已售13]";
    labselled.textColor = RGB(254, 208, 55);
    labselled.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:labselled];
    self.sales_S = labselled;
    
    
//星星
    UIImageView *imag0 = [[UIImageView alloc]init];
//    imag0.backgroundColor = APP_ClOUR;
    [self.contentView addSubview:imag0];
    
    UIImageView *imag1 = [[UIImageView alloc]init];
//    imag1.backgroundColor = APP_ClOUR;
    
    [self.contentView addSubview:imag1];
    
    UIImageView *imag2 = [[UIImageView alloc]init];
//    imag2.backgroundColor = APP_ClOUR;
    [self.contentView addSubview:imag2];
    
    UIImageView *imag3 = [[UIImageView alloc]init];
//    imag3.backgroundColor = APP_ClOUR;
    [self.contentView addSubview:imag3];
    
    UIImageView *imag4 = [[UIImageView alloc]init];
//    imag4.backgroundColor = APP_ClOUR;
    [self.contentView addSubview:imag4];
    
    imag0.image = imag1.image = imag2.image= imag3.image= imag4.image = [UIImage imageNamed:@"tmall_icon_shopmain_popular"];
    
   //分值
    UILabel *countLab =[[UILabel alloc]init];
    countLab.text = @"5.0";
    countLab.textColor = RGB(254, 208, 55);
    countLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:countLab];
    self.serviceScore  = countLab;
    
    
    UIView *V_line = [UIView new];
    V_line.backgroundColor = line.backgroundColor;

    [self.contentView addSubview:V_line];
    
    //价格
    
    UILabel *priceLab = [[UILabel alloc]init];
    priceLab.text = @"52.1元/次";
    priceLab.textColor = [UIColor redColor];
    priceLab.font = [UIFont systemFontOfSize:12];
    priceLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:priceLab];
    self.price_S = priceLab;
    
    //分割条
    UIView *fengetiao = [[UIView alloc]init];
    fengetiao.backgroundColor = line.backgroundColor;
    [self.contentView addSubview:fengetiao];
    
    
    
    //内容
    [content_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab_Ican.mas_bottom).offset(0);
        make.left.equalTo(lab_Ican.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-8);
        
    }];
    

    
    
  //线
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_width);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(content_lab.mas_bottom).offset(5);
        
    }];

    
 //已售
    CGFloat width_sel = [labselled.text boundingRectWithSize:CGSizeMake(_width, 20) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.width;
    
    
    [labselled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(content_lab);
        make.top.mas_equalTo(line.mas_bottom).offset(0);
        make.width.mas_equalTo(width_sel+5);
        make.height.mas_equalTo(30);
    }];
//评分星星
    
    [imag0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labselled.mas_right).offset(5);
        make.centerY.mas_equalTo(labselled.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
        
    }];
    
    [imag1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imag0.mas_right).offset(3);
        make.centerY.mas_equalTo(labselled);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    [imag2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imag1.mas_right).offset(3);
        make.centerY.mas_equalTo(labselled);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    [imag3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imag2.mas_right).offset(3);
        make.centerY.mas_equalTo(labselled);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    [imag4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imag3.mas_right).offset(3);
        make.centerY.mas_equalTo(labselled);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    
    
    //分
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(imag4.mas_right).offset(5);
        make.top.mas_equalTo(labselled);
        make.width.mas_equalTo(labselled);
        make.height.mas_equalTo(labselled);
    }];
    
    //价格
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-8);
        make.top.mas_equalTo(labselled);
        make.width.mas_equalTo(_width);
        make.height.mas_equalTo(labselled);
    }];
    
    
    //分割条

    [fengetiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labselled.mas_bottom);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(_width);
        make.height.mas_equalTo(5);

    }];
    
}

-(CGFloat)contentLabelH{
    if (!_contentLabelH) {
        CGFloat h=[self.content_S.text boundingRectWithSize:CGSizeMake(_width-16, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.height;
        
        _contentLabelH=h;
    }
    
    [self.content_S mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_contentLabelH);
        
    }];
    
    //跟新约束
    [self layoutIfNeeded];

    return _contentLabelH;
}



-(void)setModel:(SecondModel *)model{
    
    _model = model;
    
    [self.avatarUrl sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:nil];
    self.userNick.text = model.userNick;
    NSDictionary *dic = model.jobs[0];
    [self.starImg sd_setImageWithURL:[NSURL URLWithString:dic[@"iconURL"]] placeholderImage:nil];
    
    self.images = model.images;
    imgView0.image = nil;
    
    imgView1.image = nil;
    imgView2.image = nil;

    if ((_images[0]!=nil)) {
        [imgView0 sd_setImageWithURL:[NSURL URLWithString:_images[0]] placeholderImage:nil];

    }
    if (_images.count>1) {
        if (_images[1]!=nil) {
            [imgView1 sd_setImageWithURL:[NSURL URLWithString:_images[1]] placeholderImage:nil];
            
        }
    }
    if (_images.count > 2) {
        if (_images[2]!=nil) {
            [imgView2 sd_setImageWithURL:[NSURL URLWithString:_images[2]] placeholderImage:nil];
            
            
        }
        
    }
 
    self.person_state.text = dic[@"title"];
    
    
//    NSLog(@"images===set==%ld",_images.count);

    self.followerCount.text = [NSString stringWithFormat:@"%@粉丝|相距很远",model.followerCount];
    self.price_S.text = model.price_S;
    self.tag_S.text = [NSString stringWithFormat:@"我能 · %@",model.tag_S];
    self.content_S.text = model.content_S;
    
    self.likeCount.text = model.likeCount;
    self.viewCount.text = model.viewCount;
    self.messageCount.text = model.messageCount;

    
    
    
}

-(CGFloat)cellHeightWithModel:(SecondModel *)model{
    
    _model = model;
    __weak __typeof(&*self) weakSelf= self;
    [self.content_S mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.contentLabelH);
        
    }];
    CGFloat W =[self getSizeWithLab:self.messageCount andMaxSize:CGSizeMake(200, 100)].width;
    
        [self.messageCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(W);

        }];
    
    [self.viewCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([weakSelf getSizeWithLab:weakSelf.viewCount andMaxSize:CGSizeMake(200, 100)].width);
        
    }];
    
    [self.likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([weakSelf getSizeWithLab:weakSelf.likeCount andMaxSize:CGSizeMake(200, 100)].width);
        
    }];
    
    //跟新约束
    [self layoutIfNeeded];
    CGFloat h = 250;
    
//    CGFloat h = CGRectGetMaxY(self.person_img.frame)+10;
    NSLog(@"-----%f",h);
    
    return h;
}


-(CGSize)getSizeWithLab:(UILabel*)lable andMaxSize:(CGSize)size{
    
    CGSize SZ = [lable.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lable.font} context:nil].size ;
    
    return SZ
    ;
}
@end
