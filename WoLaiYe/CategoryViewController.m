//
//  CategoryViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/20.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#define TAG  (1000)
#import "CategoryViewController.h"
#import "UIColor+Hex.h"
#import "Request.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "SecondModel.h"
#import "SecondTableViewCell.h"
#import "Mybutton.h"

#import "MXPullDownMenu.h"

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    NSDictionary *Data_dic;
    UIView          *_loadingView;
    UIScrollView            *_downwardView;
    
    Mybutton *old_btn;
    
    UIButton *old_first;
    UIButton *old_second;
    UIButton *old_third;
    UIButton *old_sex;
    UIButton *old_youhui;

    


    
    
}

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *headerView;//头view
@property(nonatomic,strong)UIView *footView;//footview

@property (nonatomic,strong) NSMutableArray *secondArrModel; //2存放的数据模型

@property(nonatomic,strong)UIView *secondheaderView;//头2view
@property(nonatomic,strong)NSDictionary *data_D;


@property(nonatomic,strong)UITextField *lowTF;//低价
@property(nonatomic,strong)UITextField *hightTF;//高价

@property(nonatomic,strong) UIButton *sure_bnt;// 确认

@end

@implementation CategoryViewController

-(NSMutableArray *)secondArrModel{
    if (!_secondArrModel) {
        _secondArrModel = [NSMutableArray array];
    }
   return  _secondArrModel;


}


-(void)backClick{
    POP
}


- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    
    TOP_VIEW(self.titles)
    
    
    label.textColor = [UIColor blackColor];
    self.topView = topView;
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64-20, _width, _height-64+20) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.estimatedRowHeight = 200;
    _tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview: _tableview];
    
    
//    [self.view bringSubviewToFront:topView];
    
    
    _downwardView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+30, _width, _height)];
    _downwardView.hidden= YES;
    _downwardView.scrollEnabled=YES;
    _downwardView.backgroundColor=[UIColor whiteColor];
    _downwardView.bounces=YES;
    _downwardView.delegate= self;
    
    [self.view addSubview:_downwardView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downScrollCancle:)];
 
    [_downwardView addGestureRecognizer:tap];
    
    
    [self.view bringSubviewToFront:topView];
    
}





-(void)getDataWithcatId:(NSInteger)catId{
    
    
    NSString *url = [NSString stringWithFormat:@"%@t=cathome&catId=%ld",BaseUrl,(long)catId];

    NSLog(@"==url==%@",url);
    [Request getData:url Completion:^(NSError *error, NSDictionary *resultDict) {
        if ([resultDict[@"Flag"]integerValue]==1) {
            
            Data_dic = resultDict[@"Data"];
            
            self.headerView = [self creatHeaderView];
            self.footView= [self creatFootView];
            
            
        }else{
            
            
        }
        
        [_tableview reloadData];
        
    }];

    
    
    
}
-(void)removeLoadView{
    LOADING_REMOVE
}
-(void)getDataWithID:(NSInteger)catId{
    
    
    LOADING_VIEW
    NSString *urlS = [NSString stringWithFormat:@"%@t=catdata&catId=%ld",BaseUrl,(long)catId];
    NSLog(@"==urlS==%@",urlS);

    
    [Request getData:urlS Completion:^(NSError *error, NSDictionary *resultDict) {
                if ([resultDict[@"Flag"]integerValue]==1) {
                    self.data_D =resultDict[@"Data"];
                    
                    LOADING_REMOVE
        NSArray  *data_A =[resultDict[@"Data"]objectForKey:@"result"];
                    
        [self.secondArrModel removeAllObjects];
        for (NSDictionary *dic in data_A) {
            
            SecondModel *model = [[SecondModel alloc]initWithDictionary:dic];
            [self.secondArrModel addObject:model];
        }
        
        
        
                }
        
//        NSIndexSet *index = [NSIndexSet indexSetWithIndex:1];
//        [_tableview reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
        
        [_tableview reloadData];
        
    }];

    
   
}




-(UIView*)creatHeaderView{
    
    UIView *view = [UIView new];


    
    
    NSArray *arr =@[@"全部分类",@"全国",@"推荐排序",@"筛选"];
    for (int i = 0; i < 4; i ++) {
        Mybutton *topBtn = [Mybutton buttonWithType:UIButtonTypeCustom];
        topBtn.tag = i;
        topBtn.frame = CGRectMake(i*_width/4, 0, _width/4, 29);
        [topBtn setTitle:arr[i] forState:UIControlStateNormal];
        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topBtn addTarget:self action:@selector(topSelect:) forControlEvents:UIControlEventTouchUpInside];
        topBtn.titleEdgeInsets= UIEdgeInsetsMake(0, 10, 0, 10);

        [topBtn setAdjustsImageWhenHighlighted:NO];
        topBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:topBtn];
        
        CGFloat W = [topBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;

        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.bounds = CGRectMake(0, 0, 8, 8);
        imageV.image = [UIImage imageNamed:@"xiaosanjiaodown"];
        imageV.center = CGPointMake(topBtn.center.x+ W/2+5, topBtn.center.y);
        [view addSubview:imageV];
        
        if (i!=0) {
            UIView *shuxin = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 1, 19)];
            shuxin.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            [topBtn addSubview:shuxin];
        }
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 29, _width, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [view addSubview:line];

    
    view.backgroundColor= [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, _width, 29+1);
    
    return view;
}
-(UIView*)creatFootView{
    
    
    UIView *view = [UIView new];
    
        UIImageView *imageV= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2.5)];

    [imageV  sd_setImageWithURL:[NSURL URLWithString:Data_dic[@"bannerUrl"]] placeholderImage:nil];
    [view addSubview:imageV];
        
        UILabel *jingcai = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), _width, 30)];
        jingcai.text = [NSString stringWithFormat:@"  %@",Data_dic[@"choiceTitle"]];
        jingcai.font = [UIFont systemFontOfSize:14];
        jingcai.textColor = [UIColor blackColor];
        [view addSubview:jingcai];
        
        UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(jingcai.frame), _width, 1)];
        xian.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [view addSubview:xian];
        
        UIScrollView *scroll_view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(xian.frame), _width, _width*0.37*344/240+20)];
        scroll_view.showsHorizontalScrollIndicator = NO;
        [view addSubview:scroll_view];
    
    
    NSArray *todayS = Data_dic[@"today"];
    
    for (int i = 0; i < todayS.count; i ++) {
        
        UIButton *todaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        todaybtn.frame = CGRectMake(10+i*(_width*0.37+5), 10, _width*0.37, _width*0.37*344/240);
        [scroll_view addSubview:todaybtn];
        [todaybtn setAdjustsImageWhenHighlighted:NO];

        [todaybtn sd_setImageWithURL:[NSURL URLWithString:[todayS[i] objectForKey:@"image"]] forState:UIControlStateNormal];
        scroll_view.contentSize = CGSizeMake(CGRectGetMaxX(todaybtn.frame)+10, 0);
    }
    
    
    
    NSArray *arr= Data_dic[@"category4BlockAdList"];
    CGFloat hight = _width/2*174/375;
    
        for (int i = 0; i < arr.count; i ++) {
            int X = i %2;
            int Y = i /2;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(_width/2*X, CGRectGetMaxY(scroll_view.frame)+hight*Y, _width/2, hight);
            [view addSubview:button];
            
            [button sd_setImageWithURL:[NSURL URLWithString:[arr[i] objectForKey:@"image"]] forState:UIControlStateNormal];
            
            [button setAdjustsImageWhenHighlighted:NO];
        }
    
    UIScrollView *scroll_S = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scroll_view.frame)+hight*(arr.count/2+1)+10, _width, 100)];

    if (arr.count%2==0) {
        scroll_S.frame = CGRectMake(0, CGRectGetMaxY(scroll_view.frame)+hight*(arr.count/2)+10, _width, 100);

    }
        scroll_S.showsHorizontalScrollIndicator = NO;
        [view addSubview:scroll_S];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(scroll_S.frame)-10, _width, 10)];
    line.backgroundColor = xian.backgroundColor;
    [view addSubview:line];
    
    NSArray *tagList = Data_dic[@"tagList"];
    
    for (int i = 0; i <tagList.count-1; i++) {
        int X = i %4;
        int Y = i /4;
        NSDictionary *dic =tagList[i+1];
        UIButton *buttn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttn.backgroundColor = xian.backgroundColor;
        buttn.frame = CGRectMake(10+X*((_width-50)/4+10), 10+Y*40, (_width-50)/4, 30);
        [buttn setTitle:dic[@"tag"] forState:UIControlStateNormal];
        [buttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttn.titleLabel.font = [UIFont systemFontOfSize:10];
        [scroll_S addSubview:buttn];
        buttn.tag = [dic[@"stdCatId"] integerValue];
        [buttn addTarget:self action:@selector(fenleiClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scroll_S.frame)-10, _width, 10)];
    line1.backgroundColor = xian.backgroundColor;
    [view addSubview:line1];
    
        
    view.frame = CGRectMake(0, 0, _width, CGRectGetMaxY(scroll_S.frame));

    return view;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return self.headerView.frame.size.height;

    }else{
        return 0.1;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return self.footView.frame.size.height;
    }else{
        return 0.1;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        return 250;

    }else{
        return 0.1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section ==0) {
        return 0;
    }else
        return self.secondArrModel.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = nil;
    
    
    if (section ==0) {
        view= self.footView;
    }
    
    return view;

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =nil;
    
    
     if (section ==1){
         view = self.headerView;
//         view.backgroundColor = APP_ClOUR;
    }
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  

    SecondTableViewCell *STcell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
    if (STcell==nil) {
        STcell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:secondCellID];
        STcell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    STcell.model = self.secondArrModel[indexPath.row];

    
    return STcell;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    UIColor *color=APP_ClOUR;
    CGFloat offset=_tableview.contentOffset.y;
    
//    if (offset>64) {
//        _tableview.frame = CGRectMake(0, 64, _width, _height-64);
//    }else{
//        _tableview.frame = CGRectMake(0, -20, _width, _height+20);
//
//    }

//
//        NSLog(@"66666====%f",offset);
    if (offset<0) {
//        _topView.backgroundColor = [color colorWithAlphaComponent:0];
//        [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        countBtn.backgroundColor=APP_ClOUR;
        if (offset<-20) {
//            _topView.hidden = YES;
        }else{
//            _topView.hidden = NO;
        }
        
    }else {
//        CGFloat alpha=1-((_width/2+45-64-offset)/(_width/2+45-64));
//        _topView.backgroundColor=[color colorWithAlphaComponent:alpha];
        
//        [countBtn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
//        countBtn.backgroundColor=[UIColor whiteColor];
        
    }
}

-(void)topSelect:(Mybutton*)sender{
    
    for (UIView *V  in _downwardView.subviews) {
        [V removeFromSuperview];
    }
    
    [self.sure_bnt removeFromSuperview];

    
    for (UIButton *btn in self.headerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag != sender.tag) {
                [btn setTitleColor:[UIColor blackColor] forState:0];

            }else{
                [sender setTitleColor:APP_ClOUR forState:0];

            }
        }
    }
   
    
    NSLog(@"=btn===send ==%f===%f",_tableview.contentOffset.y,self.footView.frame.size.height);

    
    if (_tableview.contentOffset.y<self.footView.frame.size.height) {
        

        [UIView animateWithDuration:0.5 animations:^{
            [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];

        } completion:^(BOOL finished) {
            
            
            if (sender==old_btn) {
                _downwardView.hidden = ! _downwardView.hidden;
                
            }else{
                _downwardView.hidden = NO;
                old_btn = sender;
            }

            
            if (sender.tag ==0) {
                [self creatfirstView];
                
                
            }else  if (sender.tag ==1) {
                
                [self creatsecondView];
                
            }else  if (sender.tag ==2) {
                
                [self creatthirdView];
                
            }else  if (sender.tag ==3) {
                
                [self creatfourView];
            }
            
        }];
        
        
        

    }else{
    
        if (sender==old_btn) {
            _downwardView.hidden = ! _downwardView.hidden;
            
        }else{
            _downwardView.hidden = NO;
            old_btn = sender;
        }

        
        
        if (sender.tag ==0) {
            [self creatfirstView];
          
            
        }else  if (sender.tag ==1) {
            
            [self creatsecondView];
            
        }else  if (sender.tag ==2) {
            
            [self creatthirdView];
            
        }else  if (sender.tag ==3) {
            
            [self creatfourView];
        }
       
    }
    
 
    
}

-(void)creatfirstView{
    NSDictionary *dict= [_data_D[@"cateList"] firstObject];
    
    NSMutableArray *muta_A = [NSMutableArray arrayWithArray:[dict objectForKey:@"subcateList"]];
    
    [muta_A insertObject:@{@"subCateName":@"全部分类",} atIndex:0];
    
    
    for (int i = 0; i < [muta_A count]; i ++) {
        NSDictionary *dic =muta_A[i];
        
        UIButton *sort_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        sort_btn.frame = CGRectMake(0, i*44, _width, 44);
        sort_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sort_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sort_btn setAdjustsImageWhenHighlighted:NO];
        sort_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        sort_btn.tag = i+TAG;
        [sort_btn addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
        [_downwardView addSubview:sort_btn];
        sort_btn.layer.cornerRadius = 3;
        sort_btn.clipsToBounds = YES;
//        NSLog(@"=old_first====%ld=====bt====%ld",(long)old_first.tag,sort_btn.tag);

        
        if (old_first.tag ==sort_btn.tag) {
            [sort_btn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            old_first= sort_btn;
        }
        
        if ( i ==0) {
            [sort_btn setTitle:[NSString stringWithFormat:@"   %@",dic[@"subCateName"]] forState:UIControlStateNormal];
            
        }else{
            
            NSString *itemNum = [NSString stringWithFormat:@"%ld",[dic[@"itemNum"] integerValue]];
            [sort_btn setTitle:[NSString stringWithFormat:@"   %@(%@)",dic[@"subCateName"],itemNum] forState:UIControlStateNormal];
            
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, _width, 1)];
        line.backgroundColor = RGB(234, 234, 234);
        [sort_btn addSubview:line];
    }
    
    _downwardView.contentSize = CGSizeMake(_width, [muta_A count]*44);
    
    if (_downwardView.contentSize.height< _downwardView.frame.size.height) {
        CGRect fram= _downwardView.frame;
        fram.size.height=_downwardView.contentSize.height;
        _downwardView.frame = fram;
    }else{
        
        CGRect fram= _downwardView.frame;
        fram.size.height=5*44;
        _downwardView.frame = fram;

    }


}

-(void)creatsecondView{
    NSDictionary *dict= [_data_D[@"tabs"] firstObject];
    
    NSMutableArray *muta_A = [NSMutableArray arrayWithArray:[dict objectForKey:@"childs"]];
    
    
    for (int i = 0; i < [muta_A count]; i ++) {
        NSDictionary *dic =muta_A[i];
        
        UIButton *sort_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        sort_btn.frame = CGRectMake(0, i*44, _width, 44);
        sort_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sort_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sort_btn setAdjustsImageWhenHighlighted:NO];
        sort_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [sort_btn addTarget:self action:@selector(secondClcik:) forControlEvents:UIControlEventTouchUpInside];
        sort_btn.tag = i+TAG;
        sort_btn.layer.cornerRadius = 3;
        sort_btn.clipsToBounds = YES;
        [_downwardView addSubview:sort_btn];
        
        if (old_second.tag ==sort_btn.tag) {
            [sort_btn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            old_second= sort_btn;
        }

            [sort_btn setTitle:[NSString stringWithFormat:@"   %@",dic[@"tabName"]] forState:UIControlStateNormal];
            

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, _width, 1)];
        line.backgroundColor = RGB(234, 234, 234);
        [sort_btn addSubview:line];
    }
    
    _downwardView.contentSize = CGSizeMake(_width, [muta_A count]*44);
    if (_downwardView.contentSize.height< _downwardView.frame.size.height) {
        CGRect fram= _downwardView.frame;
        fram.size.height=_downwardView.contentSize.height;
        _downwardView.frame = fram;
    }
    NSLog(@"contentSize====%f=height=%f",_downwardView.contentSize.height,_downwardView.frame.size.height);

}

-(void)creatthirdView{
    NSDictionary *dict= [_data_D[@"tabs"] lastObject];
    
    NSMutableArray *muta_A = [NSMutableArray arrayWithArray:[dict objectForKey:@"childs"]];
    
    
    for (int i = 0; i < [muta_A count]; i ++) {
        NSDictionary *dic =muta_A[i];
        
        UIButton *sort_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        sort_btn.frame = CGRectMake(0, i*44, _width, 44);
        sort_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sort_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sort_btn setAdjustsImageWhenHighlighted:NO];
        sort_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [sort_btn addTarget:self action:@selector(thirdClick:) forControlEvents:UIControlEventTouchUpInside];
        sort_btn.tag = i+TAG;
        sort_btn.layer.cornerRadius = 3;
        sort_btn.clipsToBounds = YES;

        [_downwardView addSubview:sort_btn];
        
        
        if (old_third.tag ==sort_btn.tag) {
            [sort_btn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            old_third = sort_btn;
        }

        [sort_btn setTitle:[NSString stringWithFormat:@"   %@",dic[@"tabName"]] forState:UIControlStateNormal];
            
               UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, _width, 1)];
        line.backgroundColor = RGB(234, 234, 234);
        [sort_btn addSubview:line];
    }
    
    _downwardView.contentSize = CGSizeMake(_width, [muta_A count]*44);
    if (_downwardView.contentSize.height< _downwardView.frame.size.height) {
        CGRect fram= _downwardView.frame;
        fram.size.height=_downwardView.contentSize.height;
        _downwardView.frame = fram;
    }
    
    NSLog(@"contentSize====%f=height=%f",_downwardView.contentSize.height,_downwardView.frame.size.height);


}
-(void)creatfourView{
    
    NSDictionary *dict= _data_D[@"filters"] ;
    
    NSMutableArray *muta_A = [NSMutableArray arrayWithArray:[dict objectForKey:@"childs"]];
    
    //第一部分
    UILabel *sexLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 30)];
    sexLab.text = [NSString stringWithFormat:@"   %@",[muta_A[0]objectForKey:@"tabName"]];
    sexLab.font = [UIFont systemFontOfSize:12.5];
    sexLab.textColor = [UIColor blackColor];
    [_downwardView addSubview:sexLab];
    NSArray *sex_A =[muta_A[0]objectForKey:@"childs"];
    
    for (int i = 0; i < sex_A.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+_width*0.3*i, 30, _width*0.3-10, 30);
        [button setTitle:[sex_A[i] objectForKey:@"tabName"]forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        button.tag = i;
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;

        [button addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
        [_downwardView addSubview:button];
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 70, _width, 1)];
    line.backgroundColor = RGB(234, 234, 234);
    [_downwardView addSubview:line];
    
    //第2部分
    UILabel *serviceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), _width, 30)];
    serviceLab.text = [NSString stringWithFormat:@"   %@",[muta_A[1]objectForKey:@"tabName"]];
    serviceLab.font = [UIFont systemFontOfSize:12.5];
    serviceLab.textColor = [UIColor blackColor];
    [_downwardView addSubview:serviceLab];
    
    
    NSArray *service_A =[muta_A[1]objectForKey:@"childs"];
    
    for (int i = 0; i < service_A.count; i ++) {
        int X = i %2;
        int Y = i/2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+((_width-30)/2+10)*X, CGRectGetMaxY(serviceLab.frame)+Y*55, (_width-30)/2, 45);
        [button addTarget:self action:@selector(serviceClcik:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [_downwardView addSubview:button];
        
        //大文字
        UILabel *bigLab = [[UILabel alloc]init];
        bigLab.text = [service_A[i] objectForKey:@"tabName"];
        bigLab.textColor = [UIColor blackColor];
        bigLab.font = [UIFont systemFontOfSize:13];
        bigLab.textAlignment = NSTextAlignmentCenter;
        
        CGFloat Big_hight = [bigLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:bigLab.font} context:nil].size.height;
        bigLab.frame = CGRectMake(0, CGRectGetHeight(button.frame)/2-Big_hight, CGRectGetWidth(button.frame), Big_hight);
        [button addSubview:bigLab];
        
        //小文字

        UILabel *smallLab = [[UILabel alloc]init];
        smallLab.text = [service_A[i] objectForKey:@"tabSubName"];
        smallLab.textColor = [UIColor blackColor];
        smallLab.font = [UIFont systemFontOfSize:11];
        smallLab.textAlignment = NSTextAlignmentCenter;
        
        CGFloat smallLab_hight = [smallLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:smallLab.font} context:nil].size.height;
        smallLab.frame = CGRectMake(0, CGRectGetHeight(button.frame)/2, CGRectGetWidth(button.frame), smallLab_hight);
        [button addSubview:smallLab];

        
    }

    NSInteger servicenum = 0;
    
    if(service_A.count%2==0){
        servicenum =service_A.count/2;
        
    }else{
        servicenum =service_A.count/2+1;
    }
    
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceLab.frame)+servicenum*55, _width, 1)];
    line0.backgroundColor = RGB(234, 234, 234);
    [_downwardView addSubview:line0];
    
    
    //第3部分
    UILabel *youhuiLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line0.frame), _width, 30)];
    youhuiLab.text = [NSString stringWithFormat:@"   %@",[muta_A[2]objectForKey:@"tabName"]];
    youhuiLab.font = [UIFont systemFontOfSize:12.5];
    youhuiLab.textColor = [UIColor blackColor];
    [_downwardView addSubview:youhuiLab];

    NSArray *youhui_A =[muta_A[2]objectForKey:@"childs"];
    
    for (int i = 0; i < youhui_A.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+_width*0.3*(i%3), CGRectGetMaxY(youhuiLab.frame)+40*(i/3), _width*0.3-10, 30);
        [button setTitle:[youhui_A[i] objectForKey:@"tabName"]forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [_downwardView addSubview:button];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        
        [button addTarget:self action:@selector(youhuiClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSInteger youhuinum = 0;
    
    if(service_A.count%3==0){
        youhuinum =youhui_A.count/3;
        
    }else{
        youhuinum =youhui_A.count/3+1;
    }
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(youhuiLab.frame)+youhuinum*40, _width, 1)];
    line1.backgroundColor = RGB(234, 234, 234);
    [_downwardView addSubview:line1];

    
    
    //第4部分
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), _width, 30)];
    priceLab.text = [NSString stringWithFormat:@"   %@",[muta_A[3]objectForKey:@"tabName"]];
    priceLab.font = [UIFont systemFontOfSize:12.5];
    priceLab.textColor = [UIColor blackColor];
    [_downwardView addSubview:priceLab];
    
    
    UITextField *lowTF  = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(priceLab.frame), 60, 25)];
    lowTF.placeholder = @"最低价";
    lowTF.backgroundColor = line.backgroundColor;
    lowTF.textColor = [UIColor darkGrayColor];
    lowTF.font = [UIFont systemFontOfSize:12.5];
    [lowTF setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    lowTF.textAlignment = NSTextAlignmentCenter;
    lowTF.delegate = self;
    lowTF.keyboardType= UIKeyboardTypeNumberPad;

    lowTF.layer.cornerRadius = 3;
    lowTF.clipsToBounds = YES;

    [_downwardView addSubview:lowTF];
    self.lowTF = lowTF;
    
    
    UITextField *hightTF  = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lowTF.frame)+10, CGRectGetMaxY(priceLab.frame), 60,  CGRectGetHeight(lowTF.frame))];
    hightTF.placeholder = @"最高价";
    hightTF.textColor = [UIColor darkGrayColor];
    hightTF.font = lowTF.font;
    hightTF.keyboardType= UIKeyboardTypeNumberPad;
    hightTF.backgroundColor = line.backgroundColor;
    [hightTF setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    hightTF.textAlignment = NSTextAlignmentCenter;
    hightTF.delegate = self;
    
    hightTF.layer.cornerRadius = 3;
    hightTF.clipsToBounds = YES;
    [_downwardView addSubview:hightTF];
        self.hightTF = hightTF;
    
    
    UILabel *xiegng= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lowTF.frame)-2, CGRectGetMaxY(priceLab.frame), 14, CGRectGetHeight(lowTF.frame))];
    xiegng.text= @"-";
    xiegng.textAlignment = NSTextAlignmentCenter;
    xiegng.textColor = [UIColor darkGrayColor];
    xiegng.backgroundColor = lowTF.backgroundColor;
    [_downwardView addSubview:xiegng];
    

    
    
    UILabel *yuan = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hightTF.frame)+8, CGRectGetMaxY(priceLab.frame), 78, CGRectGetHeight(hightTF.frame))];
    yuan.font = hightTF.font;
    yuan.textColor= hightTF.textColor;
    yuan.text  = @"元";
    [_downwardView addSubview:yuan];
    
    
    
    UIButton *reSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reSetBtn.frame= CGRectMake((_width-60)/2, CGRectGetMaxY(yuan.frame)+20, 60, 30);
    [reSetBtn setTitle:@"重置" forState:0];
    [reSetBtn setTitleColor:APP_ClOUR forState:0];
    reSetBtn.layer.cornerRadius= 5;
    reSetBtn.layer.borderColor = APP_ClOUR.CGColor;
    reSetBtn.layer.borderWidth = 1;
    reSetBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
    [_downwardView addSubview:reSetBtn];
    
    
    UIButton *sure_bnt =[UIButton buttonWithType:UIButtonTypeCustom];
    sure_bnt.frame = CGRectMake(0, _height-40, _width, 40);
    [sure_bnt setTitleColor:[UIColor whiteColor] forState:0];
    [sure_bnt setTitle:@"确认" forState:0];
    sure_bnt.titleLabel.font = [UIFont systemFontOfSize:15];
    sure_bnt.backgroundColor = APP_ClOUR;
    [self.view addSubview:sure_bnt];
    self.sure_bnt = sure_bnt;
    
    _downwardView.contentSize = CGSizeMake(_width, CGRectGetMaxY(reSetBtn.frame)+200);
    if (_downwardView.contentSize.height< _downwardView.frame.size.height) {
        CGRect fram= _downwardView.frame;
        fram.size.height=_downwardView.contentSize.height;
        _downwardView.frame = fram;
    }else{
        CGRect fram= _downwardView.frame;
        fram.size.height=_height;
        _downwardView.frame = fram;
    }

    
    
    NSLog(@"contentSize====%f=height=%f",_downwardView.contentSize.height,_downwardView.frame.size.height);

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)fenleiClick:(UIButton*)sender{
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden= YES;
    
    
    
    [self getDataWithcatId:self.itemId];
    
    [self getDataWithID:self.itemId];

    //注册通知监听键盘的出现与消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)keyboardWillShow:(NSNotification*)aNotification{
    CGRect keyboardRect = [[[aNotification userInfo]objectForKey:UIKeyboardBoundsUserInfoKey]CGRectValue];
    
    //    NSTimeInterval animationDuration = [[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    if ([self.lowTF isFirstResponder]||[self.hightTF isFirstResponder]) {
        CGFloat offset = keyboardRect.size.height- (_height-94 -CGRectGetMaxY(self.lowTF.frame))+30;
        
        NSLog(@"offset=keyboardWillShow==%f",offset);

//        CGRect frame = _downwardView.frame;
//        frame.origin.y -= offset;
        
        if (_downwardView.frame.origin.y<0) {
            
        }else{
            [UIView beginAnimations:@"ResizeForkeyboard" context:nil];
            [UIView setAnimationDuration:0.5];
//            _downwardView.frame= frame;
            
            [_downwardView setContentOffset:CGPointMake(0, offset) animated:YES];

            [UIView commitAnimations];
            
        }
        
        
    }
    
    
    
    
    
}


-(void)keyboardWillHide:(NSNotification*)aNotification{
    
    
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    
    //    NSTimeInterval animationDuartion = [[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    if ([self.lowTF isFirstResponder]|[self.hightTF isFirstResponder]) {
        CGFloat offset = keyboardRect.size.height- (_height-94 -CGRectGetMaxY(self.lowTF.frame))+30;
        
        
        
        
        NSLog(@"offset==keyboardWillHide=%f",offset);
        
        [UIView beginAnimations:@"ResizeForkeyboard" context:nil];
        
        [UIView setAnimationDuration:0.5];
        [_downwardView setContentOffset:CGPointMake(0, 0) animated:YES];

        
        [UIView commitAnimations];
        
        
        
    }
    
  }

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.lowTF resignFirstResponder];
    [self.hightTF resignFirstResponder];

    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView  == _tableview) {
        _downwardView.hidden = YES;
    }
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.lowTF resignFirstResponder];
    [self.hightTF resignFirstResponder];
}
-(void)downScrollCancle:(UITapGestureRecognizer*)tap{
    
    
}
//全部分类
-(void)firstClick:(UIButton*)button{
    
    NSLog(@"header===%@",self.headerView.subviews);
    
    NSDictionary *dict= [_data_D[@"cateList"] firstObject];
    
    NSArray *A = [NSMutableArray arrayWithArray:[dict objectForKey:@"subcateList"]];
    NSDictionary *dic = A[button.tag -TAG];
    
    for (UIButton *btn in self.headerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag==0) {
                [btn setTitle:dic[@"subCateName"] forState:0];
                [btn setTitleColor:APP_ClOUR forState:0];
            }
        }
        
    }
    
    if (button !=old_first) {
        [button setTitleColor:APP_ClOUR forState:0];
        [old_first setTitleColor:[UIColor blackColor] forState:0];
        old_first = button;

    }
    
}
//全国分类
-(void)secondClcik:(UIButton*)button{
    NSDictionary *dict= [_data_D[@"tabs"] firstObject];
    
    NSArray *A = [NSMutableArray arrayWithArray:[dict objectForKey:@"childs"]];
    NSDictionary *dic = A[button.tag -TAG];
    
    for (UIButton *btn in self.headerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag==1) {
                [btn setTitle:dic[@"tabName"] forState:0];
                [btn setTitleColor:APP_ClOUR forState:0];
            }
        }
        
    }

    if (button !=old_second) {
        [button setTitleColor:APP_ClOUR forState:0];
        [old_second setTitleColor:[UIColor blackColor] forState:0];
        old_second = button;
        
    }

    
}//推荐分类
-(void)thirdClick:(UIButton*)button{
    NSDictionary *dict= [_data_D[@"tabs"] lastObject];
    
    NSArray *A = [NSMutableArray arrayWithArray:[dict objectForKey:@"childs"]];
    NSDictionary *dic = A[button.tag -TAG];
    
    for (UIButton *btn in self.headerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag==2) {
                [btn setTitle:dic[@"tabName"] forState:0];
                [btn setTitleColor:APP_ClOUR forState:0];
            }
        }
        
    }

    if (button !=old_third) {
        [button setTitleColor:APP_ClOUR forState:0];
        [old_third setTitleColor:[UIColor blackColor] forState:0];
        old_third = button;
        
    }

}//筛选分类


-(void)sexClick:(UIButton *)sexBtn{
    if (old_sex != sexBtn) {
        [sexBtn setTitleColor:[UIColor whiteColor] forState:0];
        sexBtn.backgroundColor = APP_ClOUR;
        [old_sex setTitleColor:[UIColor blackColor] forState:0];
        old_sex.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        old_sex = sexBtn;
    }
    
}

-(void)serviceClcik:(UIButton*)serviceBtn{
    NSLog(@"---%d",serviceBtn.selected);
    serviceBtn.selected = !serviceBtn.selected;
    if (serviceBtn.selected) {
        serviceBtn.backgroundColor = APP_ClOUR;
        for (UILabel *lab in serviceBtn.subviews) {
            lab.textColor = [UIColor whiteColor];
        }
    }else{
        serviceBtn.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        for (UILabel *lab in serviceBtn.subviews) {
            lab.textColor = [UIColor blackColor];
        }

    }
    
}

-(void)youhuiClick:(UIButton*)youhuiBtn{
    if (old_youhui != youhuiBtn) {
        [youhuiBtn setTitleColor:[UIColor whiteColor] forState:0];
        youhuiBtn.backgroundColor = APP_ClOUR;
        [old_youhui setTitleColor:[UIColor blackColor] forState:0];
        old_youhui.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        old_youhui = youhuiBtn;
    }

}

@end
