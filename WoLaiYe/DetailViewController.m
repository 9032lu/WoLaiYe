//
//  DetailViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/22.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "DetailViewController.h"
#import "Request.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"


static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *table_View;
    UIView *_loadingView;
    NSDictionary *Data_dic;
    
    
    //循环滚动的三个视图
//    UIImageView * _leftImageView;
//    UIImageView * _centerImageView;
//    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    
    NSArray *_imageNameArray;


}

@property(nonatomic,strong)UIView *headerView;//头view
@property(nonatomic,strong)UIView *secondHeadView;

@property(nonatomic,strong)UIView *footerView;

@property (strong,nonatomic) UIImageView * leftImageView;
@property (strong,nonatomic) UIImageView * centerImageView;
@property (strong,nonatomic) UIImageView * rightImageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation DetailViewController


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
    TOP_VIEW(@"做H5")
    
    
    table_View = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-40) style:UITableViewStyleGrouped];
    table_View.dataSource = self;
    table_View.delegate = self;
    table_View.estimatedRowHeight = 200;
    [self.view addSubview: table_View];

    
    [self creatfooterView];
    
    [self getData];

}
-(void)creatfooterView{
    
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, _height-40, _width, 40)];
    _footerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_footerView];
    NSArray *A = @[@"和TA聊",@"收藏",@"留言"];
    for (int i = 0; i <3; i++) {
        UIButton *btn =[UIButton buttonWithType:0];
        btn.frame = CGRectMake(i*_width/6, 0, _width/6, 40);
        [self.footerView addSubview:btn];
        UIImageView *img = [[UIImageView alloc]init];
        img.center = CGPointMake(_width/12, btn.center.y-8);
        img.bounds = CGRectMake(0, 0, 15, 15);
        if (i==0) {
            img.layer.cornerRadius = 7.5;
            img.clipsToBounds = YES;
            
            UIView *lin = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn.frame)-1, 5, 1, 30)];
            lin.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            [btn addSubview:lin];
        }
        img.backgroundColor = LZDRandomColor;
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), CGRectGetWidth(btn.frame), 40-CGRectGetMaxY(img.frame))];
        lab.text =A[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:9];
        [btn addSubview:lab];
        
        [btn addSubview:img];
        
    }
    
    UIButton *yuyueBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    yuyueBtn.frame = CGRectMake(_width/2, 0, _width/2, 40);
    [yuyueBtn setTitle:@"立即预约" forState:0];
    yuyueBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [yuyueBtn setTitleColor:[UIColor blackColor] forState:0];
    yuyueBtn.backgroundColor=[UIColor yellowColor];
    [self.footerView addSubview:yuyueBtn];
    
}
-(void)removeLoadView{
    LOADING_REMOVE
}


-(void)getData{
    LOADING_VIEW
    
    NSString *url = @"http://114.215.192.80:10123/KongGe/index.aspx?t=item";
    
    NSLog(@"url==%@",url);
    [Request getData:url Completion:^(NSError *error, NSDictionary *resultDict) {
        LOADING_REMOVE
        if ([resultDict[@"Flag"]integerValue]==1) {
            Data_dic = resultDict[@"Data"];
            
            self.headerView = [self creatHeaderView];
            self.secondHeadView = [self creatSecondView];
            
        }else{
            
            
            
        }
        
        
        [table_View reloadData];
        
    }];
    
    
}

-(UIView*)creatHeaderView{
    
    
    CGFloat  W = _width *0.8;
   UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, W)];
    
     _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, W)];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
//    _scrollView.contentOffset = CGPointMake(_width, 0);
    _scrollView.contentSize = CGSizeMake(_width * 3, 0);
    _scrollView.delegate = self;
    [backView addSubview:_scrollView];

    
     _imageNameArray = Data_dic[@"likeUsers"];
    
//    NSLog(@"------%@",_imageNameArray[0] );
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, W)];
    [_scrollView addSubview:_leftImageView];
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_width, 0, _width, W)];
    [_scrollView addSubview:_centerImageView];
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_width*2, 0, _width, W)];
    [_scrollView addSubview:_rightImageView];
    
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_imageNameArray[0] objectForKey:@"userAvatar"]] placeholderImage:nil];
    _leftImageView.backgroundColor = LZDRandomColor;
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_imageNameArray[1] objectForKey:@"userAvatar"]]  placeholderImage:nil];
    _centerImageView.backgroundColor = LZDRandomColor;

    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:[_imageNameArray[2] objectForKey:@"userAvatar"]] placeholderImage:nil];
    _rightImageView.backgroundColor = LZDRandomColor;

    
    _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
    _isTimeUp = NO;


    
    return backView;
}


#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [_scrollView setContentOffset:CGPointMake(_width * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}


#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
//        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
    }
    else if(_scrollView.contentOffset.x == _width * 2)
    {
        
        currentImage = (currentImage+1)%_imageNameArray.count;
//        _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage-1)%_imageNameArray.count]] placeholderImage:nil];
    
    
//    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
    
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage)%_imageNameArray.count]] placeholderImage:nil];

    _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
    
//    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
    
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage+1)%_imageNameArray.count]] placeholderImage:nil];

    _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
    
//    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    
    _scrollView.contentOffset = CGPointMake(_width, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if (section ==1){
        return 3;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat Hight = 0.1;
    if (section ==0) {
        Hight =_width*0.8;
    }else if (section ==1){
        Hight = self.secondHeadView.frame.size.height;
    }else if (section ==2){
        Hight= 30;
    }
    return Hight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat Hight = 0.1;
    if (section ==0) {
        Hight =75;
    }else if (section ==2){
        
        if ([Data_dic[@"viewUsers"] count]==0) {
            Hight= 120;
        }
    }
    return Hight;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat Hight = 0.1;
    if (indexPath.section ==0) {

    }else if (indexPath.section ==1){
        Hight = 30;
    }
    return Hight;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    for (UIView *view  in backView.subviews) {
        [view removeFromSuperview];
    }
    if (section ==0) {
        
       CGFloat  personH = 50;

        NSDictionary *user_dic = Data_dic[@"user"];
        
        UIImageView *personImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, personH, personH)];
        personImg.layer.cornerRadius = CGRectGetWidth(personImg.frame)/2;
        personImg.clipsToBounds = YES;
        [personImg sd_setImageWithURL:[NSURL URLWithString: user_dic[@"userAvatar"]] placeholderImage:nil];
        [backView addSubview:personImg];
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(personImg.frame)+10, _width, 5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [backView addSubview:line];
        
        
        
        UILabel *person_name = [UILabel new];
        person_name.font = [UIFont systemFontOfSize:13];
        person_name.text =  user_dic[@"userName"];
        person_name.textColor = [UIColor blackColor];
        [backView addSubview:person_name];
        
        UIImageView *starImg = [[UIImageView alloc]init];
        [starImg
         sd_setImageWithURL:[NSURL URLWithString:[[user_dic[@"jobs"] firstObject] objectForKey:@"iconURL"]] placeholderImage:nil];
        [backView addSubview:starImg];
        
        UILabel *person_state = [UILabel new];
        person_state.font = [UIFont systemFontOfSize:12];
        person_state.text =  [[user_dic[@"jobs"] firstObject] objectForKey:@"title"];
        person_state.textColor = [UIColor blackColor];
        [backView addSubview:person_state];

      
        
        UIImageView *renzhengImg = [[UIImageView alloc]init];
        [backView addSubview:renzhengImg];
        renzhengImg.backgroundColor = APP_ClOUR;
        
        
        UILabel *renzhenglab = [UILabel new];
        renzhenglab.font = [UIFont systemFontOfSize:10];
        if ([user_dic[@"realNameCert"] integerValue]==1) {
            renzhenglab.text =  @"已实名认证";

        }else{
            renzhenglab.text =  @"未实名认证";
        }
        renzhenglab.textColor = [UIColor blackColor];
        [backView addSubview:renzhenglab];
        
        
        UIImageView *zhimaImg = [[UIImageView alloc]init];
        zhimaImg.backgroundColor = APP_ClOUR;
        [backView addSubview:zhimaImg];
        
        UILabel *zhimaLab = [UILabel new];
        zhimaLab.font = [UIFont systemFontOfSize:10];
        zhimaLab.text =  [NSString stringWithFormat:@"芝麻信用(%@)",user_dic[@"zmLevel"]];
        zhimaLab.textColor = [UIColor blackColor];
        [backView addSubview:zhimaLab];
        
        
        
        CGFloat peronW = [self getSizeWithLab:person_name andMaxSize:CGSizeMake(1000, 100)].width;

        [person_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(personImg.mas_right).offset(10);
            make.centerY.mas_equalTo(personImg.mas_centerY).offset(-7);
            make.height.mas_equalTo(personH/2);
            make.width.mas_equalTo(peronW+5);
            
        }];
        
        
        [starImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(person_name.mas_centerY).offset(0);
            make.left.mas_equalTo(person_name.mas_right).offset(5);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(13);
            
        }];
        [person_state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(person_name.mas_centerY).offset(0);
            make.left.mas_equalTo(starImg.mas_right).offset(5);
            make.height.mas_equalTo(personH/2);
            make.width.mas_equalTo(_width);
            
        }];

        
        [renzhengImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(personImg.mas_right).offset(10);
            make.centerY.mas_equalTo(personImg.mas_centerY).offset(7);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(10);

        }];
        
        CGFloat renzhengW = [self getSizeWithLab:renzhenglab andMaxSize:CGSizeMake(1000, 1000)].width;
        
        [renzhenglab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(renzhengImg.mas_right).offset(5);
            make.centerY.mas_equalTo(renzhengImg.mas_centerY).offset(0);
            make.height.mas_equalTo(personH/2);
            make.width.mas_equalTo(renzhengW+5);

        }];
        
        [zhimaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renzhenglab.mas_right).offset(5);
            make.centerY.mas_equalTo(personImg.mas_centerY).offset(7);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(10);
            
        }];

        [zhimaLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(zhimaImg.mas_right).offset(5);
            make.centerY.mas_equalTo(renzhengImg.mas_centerY).offset(0);
            make.height.mas_equalTo(personH/2);
            make.width.mas_equalTo(_width);
            
        }];
        

    }
    
    if (section ==2) {
        
        UIView *ve= [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 120)];
        
        UIImageView *imageview= [[UIImageView alloc]initWithFrame:CGRectMake((_width-55)/2, 10, 55, 50)];
        
        imageview.image=[UIImage imageNamed:@"10"];
        [ve addSubview:imageview];
        ve.backgroundColor=[UIColor whiteColor];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, _width, 30)];
        lable.text = @"就等你来说点什么";
        lable.textColor = [UIColor darkGrayColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:13];
        [ve addSubview:lable];
//        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
//        line.backgroundColor=RGB(234, 234, 234);
//        [ve addSubview:line];
        
        backView= ve;
        if ([Data_dic[@"viewUsers"] count]!=0) {
            ve=nil;
            backView=nil;
        }

    }
    
    
    return backView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = nil;
//    backView.backgroundColor = [UIColor whiteColor];
//    for (UIView *view  in backView.subviews) {
//        [view removeFromSuperview];
//    }

    if (section ==0) {
        backView = self.headerView;
        
    }else if (section ==1){
        backView = self.secondHeadView;
        
    }else if (section==2){
        UIView *V = [UIView new];
        
        UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
        img.image =[UIImage imageNamed:@"mainCellComment"];
        [V addSubview:img];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, _width, 30)];
        lab.text = @"讨论区";
        lab.textColor =[UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:10];
        [V addSubview:lab];
        V.backgroundColor =[UIColor whiteColor];
        backView = V;
    }
    
    return backView;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *detailCellId = @"detailCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailCellId];
        cell.selectionStyle= 0;
        cell.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    if (indexPath.section==1) {
        if (indexPath.row ==0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"服务方式：%@",@"在线"];
        }
        
        if (indexPath.row ==1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"相距很远"];

        }if (indexPath.row ==2) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"该服务来自 %@",Data_dic[@"serviceGezi"]];

        }
    }
    
    return cell;
}


-(UIView*)creatSecondView{
    UIView *backView = [UIView new];
    UILabel *lab_ican = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _width-60, 30)];
    lab_ican.text = [NSString stringWithFormat:@"我能·%@",Data_dic[@"tag"]];
    lab_ican.font = [UIFont systemFontOfSize:15];
    lab_ican.textColor = [UIColor blackColor];
    [backView addSubview:lab_ican];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width-10, 30)];
    price.text =[NSString stringWithFormat:@"%@元",Data_dic[@"price"]];
    price.textColor = APP_ClOUR;
    price.textAlignment = NSTextAlignmentRight;
    [backView addSubview:price];
    price.attributedText = [self changFont:price.text];
    
    for (int i = 0; i <5; i ++) {
        UIImageView *xing = [[UIImageView alloc]init];
        xing.image = [UIImage imageNamed:@"tmall_icon_shopmain_popular"];
        [backView addSubview:xing];
        xing.frame = CGRectMake(10+i*13, CGRectGetMaxY(lab_ican.frame), 10, 10);
    }
    
    UILabel*qianyue = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab_ican.frame)+10, _width, 30)];
    qianyue.textColor= [UIColor lightGrayColor];
    qianyue.font = [UIFont systemFontOfSize:10];
    [backView addSubview:qianyue];
    NSString *q_S =[NSString stringWithFormat:@"%@人已签约    库存%@",Data_dic[@"newsCount"],Data_dic[@"quantitySum"]];
    qianyue.text = q_S;
   
    
    UILabel *conten = [[UILabel alloc]init];
    
    conten.textColor= [UIColor blackColor];
    conten.font = [UIFont systemFontOfSize:13];
    conten.numberOfLines = 0;
    conten.text = Data_dic[@"content"];
    [backView addSubview:conten];
    CGFloat h = [self getSizeWithLab:conten andMaxSize:CGSizeMake(_width-20, MAXFLOAT)].height;
    conten.frame = CGRectMake(10, CGRectGetMaxY(qianyue.frame), _width-20, h);
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(conten.frame)+10, _width, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [backView addSubview:line];
    
    for (int i = 0; i <2; i ++) {
        UILabel *danwei = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), _width-20, 40)];
       
        danwei.font = [UIFont systemFontOfSize:13];
        danwei.textColor =[UIColor blackColor];
        [backView addSubview:danwei];
        
        if ( i == 0) {
            danwei.text = @"单位";
            
        }else{
            danwei.text = [[Data_dic[@"sku"]firstObject]objectForKey:@"name"];
            danwei.textAlignment = NSTextAlignmentRight;

        }

    }
    
    backView.backgroundColor=[UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, _width, CGRectGetMaxY(line.frame)+40);
    return backView;
}



-(NSMutableAttributedString*)changFont:(NSString*)string{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    //设置：在0-2个单位长度内的内容显示成红色
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(string.length-1, 1)];
    return str;
}

-(CGSize)getSizeWithLab:(UILabel*)lable andMaxSize:(CGSize)size{
    
    CGSize SZ = [lable.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lable.font} context:nil].size ;
    
    return SZ
    ;
}

@end
