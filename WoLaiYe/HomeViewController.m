//
//  HomeViewController.m
//  WoLaiYe
//
//  Created by 鲁征东 on 16/6/17.
//  Copyright © 2016年 鲁征东. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Hex.h"
#import "JingCaiCell.h"
#import "JingcaiModel.h"
#import "Request.h"
#import "SecondTableViewCell.h"

#import "CategoryViewController.h"
#import "ScanViewController.h"


#import "WebViewController.h"
#import "DetailViewController.h"
@interface HomeViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    UIView *_loadingView;
    SCREEN_WIDTH_AND_HEIGHT
    UIView *topView;
    UITableView *table_View;
    //广告位
    UIScrollView    *_smallSV;
    UIPageControl   *_pc;
    //广告位下的分类
    UIScrollView    *_sortSV;
    
    NSArray *icon_A;//20个小分类
    NSDictionary *Data_dic;
    
    NSArray *homeFunctionAreaList;//4个分类

    UITextField*search_tf; // placeholder
    UILabel *oldLab;
    UIView *line;

}
@property(nonatomic,strong)NSMutableArray  *advListArray;
@property(nonatomic,strong)UIView *headerView;//头view
@property(nonatomic,strong)UIView *footView;//footview

@property(nonatomic,strong)UIView *secondheaderView;//头2view


@property (nonatomic,strong) NSMutableArray *arrModel; //存放的数据模型
@property (nonatomic,strong) NSMutableArray *secondArrModel; //2存放的数据模型


@end

@implementation HomeViewController


-(NSMutableArray *)arrModel
{
    if(_arrModel==nil){
        _arrModel=[NSMutableArray array];
    }
    return _arrModel;
}


-(NSMutableArray *)secondArrModel
{
    if(_secondArrModel==nil){
        _secondArrModel=[NSMutableArray array];
    }
    return _secondArrModel;
}


-(NSMutableArray *)advListArray{
    if (!_advListArray) {
        _advListArray = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
        
    }
    return _advListArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    
    [self initTopView];
    

    
    
    
    table_View = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64-self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    table_View.dataSource = self;
    table_View.delegate = self;
    table_View.estimatedRowHeight = 200;
    table_View.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview: table_View];
    
    
    [self getData];
    
    [self getDataWithtabId:-4];



}

-(void)removeLoadView{
    LOADING_REMOVE
}
-(void)getDataWithtabId:(NSInteger)tabId{
    
    
    NSString *baseUrl = @"http://114.215.192.80:10123/KongGe/index.aspx?";
    NSString *url = [NSString stringWithFormat:@"%@t=%@&tabId=%ld",baseUrl,@"homedata",(long)tabId];
//    LOADING_VIEW
    
    
    NSLog(@"url==%@",url);

    [Request getData:url Completion:^(NSError *error, NSDictionary *resultDict) {
        
//        LOADING_REMOVE
        if ([resultDict[@"Flag"]integerValue]==1) {
            
            NSArray  *data_A =[resultDict[@"Data"]objectForKey:@"result"];
            [self.secondArrModel removeAllObjects];
            for (NSDictionary *dic in data_A) {
                
                SecondModel *model = [[SecondModel alloc]initWithDictionary:dic];
                [self.secondArrModel addObject:model];
            }


            
        }
        
        [table_View reloadData];
//              NSIndexSet *index = [NSIndexSet indexSetWithIndex:2];
//    
//        [table_View reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
        
        
}

-(void)getData{
    LOADING_VIEW
 
    NSString *url = @"http://114.215.192.80:10123/KongGe/index.aspx?t=home";
    
    NSLog(@"url==%@",url);
    [Request getData:url Completion:^(NSError *error, NSDictionary *resultDict) {
        LOADING_REMOVE
        if ([resultDict[@"Flag"]integerValue]==1) {
            Data_dic = resultDict[@"Data"];
            icon_A = [Data_dic objectForKey:@"categories"];
            
            homeFunctionAreaList = [Data_dic objectForKey:@"homeFunctionAreaList"];
            NSArray *theme_A = [[Data_dic objectForKey:@"discoveries"]objectForKey:@"homeThemeBlockAds"];
//            NSLog(@"))))))))))");
            
            for (NSDictionary *dic in theme_A) {
                JingcaiModel *model = [[JingcaiModel alloc]initWithDictionary:dic];
                [self.arrModel addObject:model];
            }
            
            
            search_tf.placeholder=Data_dic[@"placeholder"];

              self.headerView = [self creatHeaderView];
            self.footView= [self creatFootView];
            self.secondheaderView = [self creatSecondheardView];


        }else{
            
            
            
        }
        
        [table_View reloadData];

    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section ==0) {
        return self.footView.frame.size.height;
    }else if (section ==1){
        return 5;
    }
    
    
    else{
        return 0.1;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
         return self.headerView.frame.size.height;
    }else if (section ==2)
    {
        return self.secondheaderView.frame.size.height;

    }
    
    
    else{
        return 0.1;
        
    }
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = nil;;
    if (section==0) {
        view = self.headerView;
    
    }
    
    if (section ==2) {
        view = self.secondheaderView;
    }
    
      return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    if (section == 0) {
        view = self.footView;
    }else if (section == 1){
        UIView *lineS = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 5)];
     lineS.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        view = lineS;
    }
    
    return view;
}
-(UIView*)creatFootView
{
    UIView *back_V = [[UIView alloc]init];
    
    NSDictionary *niuRenRank = Data_dic[@"niuRenRank"];
    
    NSDictionary *banner = [niuRenRank[@"niuRenBanners"] firstObject];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 40)];
    lable.backgroundColor = [UIColor whiteColor];
    lable.text = [NSString stringWithFormat:@"   %@",[banner objectForKey:@"title"]];
    
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:14];
    [back_V addSubview:lable];
    
    UIImageView *niurenImg = [[UIImageView alloc]initWithFrame:CGRectMake(_width/2-45, 10, 90, 20)];
    [niurenImg sd_setImageWithURL:[NSURL URLWithString:banner[@"pic"]] placeholderImage:nil];
    [back_V addSubview:niurenImg];
    
    UIImageView *rightImg=  [[UIImageView alloc]initWithFrame:CGRectMake(_width-10, 15, 6, 12)];
    rightImg.image =[UIImage imageNamed:@"right"];
    [back_V addSubview:rightImg];
    
    NSArray *niurenList =niuRenRank[@"niuRenList"];
    NSInteger num = niurenList.count >3 ? 2 : niurenList.count-1 ;
    
    for (NSInteger i = num; i >= 0; i --) {
        UIImageView *nrImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rightImg.frame)-(i+1)*25-10, 10, 20, 20)];
        nrImg.layer.cornerRadius = 10;
        nrImg.clipsToBounds=YES;
        [nrImg sd_setImageWithURL:[NSURL URLWithString:[niurenList[i] objectForKey:@"picUrl"]] placeholderImage:nil];
        [back_V addSubview:nrImg];
    }
    
    
    UIButton*niurenBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    niurenBnt.frame = CGRectMake(0, 0, _width, 40);
    [niurenBnt addTarget:self action:@selector(niurenClick:) forControlEvents:UIControlEventTouchUpInside];
    [back_V addSubview:niurenBnt];
    
    UIImageView *imageV= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lable.frame)+5, _width, _width*0.17)];
    NSArray *arr =Data_dic[@"homeBeltAdList"];
    [imageV sd_setImageWithURL:[NSURL URLWithString:[arr[0] objectForKey:@"pic"]] placeholderImage:nil];
    imageV.userInteractionEnabled = YES;
    [back_V addSubview:imageV];
    
    UIButton *jcBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    jcBtn.frame = imageV.bounds;
    [jcBtn addTarget:self action:@selector(jcClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:jcBtn];
    
    
    UIView *lines = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), _width, 5)];
    lines.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [back_V addSubview:lines];
    
    
   NSDictionary *jingcai_D = [[Data_dic[@"discoveries"]objectForKey:@"homeDiscoviesBlockAd"] firstObject];
    
    UILabel *jingcai = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lines.frame), _width, 40)];
    jingcai.backgroundColor = [UIColor whiteColor];
    jingcai.text = [NSString stringWithFormat:@"  %@",jingcai_D[@"title"]];
    jingcai.textColor = [UIColor blackColor];
    jingcai.font = [UIFont systemFontOfSize:15];
    [back_V addSubview:jingcai];
    
    UIImageView *jcImg = [[UIImageView alloc]initWithFrame:CGRectMake(_width-202/3-10, CGRectGetMinY(jingcai.frame)+(40-88/3)/2, 202/3, 88/3)];
    [jcImg sd_setImageWithURL:[NSURL URLWithString:jingcai_D[@"pic"]] placeholderImage:nil];
    [back_V addSubview:jcImg];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(jingcai.frame)-1, _width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [back_V addSubview:line1];
    
    back_V.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];

    back_V.frame = CGRectMake(0, 0, _width, CGRectGetMaxY(jingcai.frame));
    return back_V;
}

-(UIView*)creatHeaderView{
//    NSLog(@"====%@",icon_A);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _width/2+50)];
            _smallSV=[[UIScrollView alloc]init];
            _smallSV.pagingEnabled=YES;
            _smallSV.bounces=NO;
            _smallSV.delegate=self;
            _smallSV.showsVerticalScrollIndicator = NO;
            _smallSV.showsHorizontalScrollIndicator = NO;
            [view addSubview:_smallSV];
    
    
            for (int i = 0; i < icon_A.count; i ++) {
                int Y = i %2;
                int X = i /2;
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(X *_width/5,5+Y *(_width/5-5+3), _width/5, _width/5-5)];
                [btn addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
                

//                NSLog(@"=========%@",urlS);
                btn.tag = i;
                [_smallSV addSubview:btn];
                
                UIImageView *imag = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, btn.frame.size.width-20, btn.frame.size.width-20)];
                //                imag.backgroundColor = [UIColor redColor];
                //                imag.layer.cornerRadius = 15;
                //                imag.clipsToBounds = YES;
                [btn addSubview:imag];
                
                UILabel *lable_S =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imag.frame), btn.frame.size.width, 15)];
                lable_S.textColor = [UIColor blackColor];
                lable_S.font = [UIFont systemFontOfSize:11];
                lable_S.textAlignment = NSTextAlignmentCenter;
                [btn addSubview:lable_S];
                
                
                [imag sd_setImageWithURL:[NSURL URLWithString:[icon_A[i] objectForKey:@"icon"]] placeholderImage:nil];
                [lable_S setText:[icon_A[i] objectForKey:@"title"]] ;
                
                
            }
            
            _pc=[[UIPageControl alloc]initWithFrame:CGRectMake(_width*0.2, 5+ 2*(_width/5-5+3), _width*0.6, 10)];
            _pc.numberOfPages = 2;
            _pc.currentPageIndicatorTintColor=RGB(254, 208, 55);
            _pc.pageIndicatorTintColor = [UIColor lightGrayColor];
            [view addSubview:_pc];
            
            _smallSV.frame  = CGRectMake(0, 0, _width, CGRectGetMaxY(_pc.frame)-10);
            if (icon_A.count%10==0) {
                _smallSV.contentSize = CGSizeMake(_width*icon_A.count/10, 0);
            }else{
                _smallSV.contentSize = CGSizeMake(_width*(icon_A.count/10+1), 0);
                
            }
            
            for (int i = 0; i <homeFunctionAreaList.count; i ++) {
                UIImageView *imageV  =[[UIImageView alloc]initWithFrame:CGRectMake(10+i*((_width-50)/4+10), CGRectGetMaxY(_pc.frame)+10, (_width-50)/4, (_width-50)/4)];
                //            imageV.backgroundColor = APP_ClOUR;
                [imageV sd_setImageWithURL:[NSURL URLWithString:[homeFunctionAreaList[i] objectForKey:@"pic"]] placeholderImage:nil];
                
                [view addSubview:imageV];
                imageV.userInteractionEnabled = YES;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, CGRectGetWidth(imageV.frame), CGRectGetHeight(imageV.frame));
                [imageV addSubview:button];
                button.tag = i;
                [button addTarget:self action:@selector(fourButClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIView *lineS = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_pc.frame)+10+(_width-50)/4, _width, 5)];
    lineS.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];

            [view addSubview:lineS];
    
        
    view.frame = CGRectMake(0, 0, _width, CGRectGetMaxY(lineS.frame));
        return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if(section == 1){
        return _arrModel.count;

    }else{
        
        return _secondArrModel.count;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    JingcaiModel *m = self.arrModel[indexPath.row];
    
//    NSLog(@"====================%f",m.cellHight);
//    return m.cellHight;
    CGFloat cellH = 0.1;
    if (indexPath.section ==1) {
        cellH =_width*0.35+20;
    }else{
        cellH = 250;
    }
    return  cellH;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= nil;
    
    if (indexPath.section == 1) {
        JingCaiCell *JCcell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (JCcell==nil) {
            JCcell = [[JingCaiCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            JCcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        JCcell.model = self.arrModel[indexPath.row];
    
        cell = JCcell;

    }else{
        
        SecondTableViewCell *STcell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
        if (STcell==nil) {
            STcell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:secondCellID];
            STcell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        STcell.model = self.secondArrModel[indexPath.row];
        cell = STcell;

        
    }
    
    
    return cell;
}

-(void)initTopView{
    topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView*searchView=[[UIView alloc]init];
    searchView.frame=CGRectMake(10, 22, _width-55, 30);
    searchView.backgroundColor=RGB(254, 208, 55);
    searchView.layer.cornerRadius=14;
    [topView addSubview:searchView];
    
    UIView *V1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    V1.backgroundColor =[UIColor darkGrayColor];
    V1.layer.cornerRadius =searchView.layer.cornerRadius;
    V1.clipsToBounds = YES;
    [searchView addSubview:V1];
    
    UIView *V2 =[[UIView alloc]initWithFrame:CGRectMake(15, 0, 35, 30)];
    V2.backgroundColor = V1.backgroundColor;
    [searchView addSubview:V2];
    
    UIButton *dingweiBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [dingweiBtn addTarget:self action:@selector(dingweiClick) forControlEvents:UIControlEventTouchUpInside];
    [dingweiBtn setTitle:@"西安" forState:UIControlStateNormal];
    [dingweiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchView addSubview:dingweiBtn];
    dingweiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIImageView *ver_img= [[UIImageView alloc]initWithFrame:CGRectMake(50-18, 3, 18, 24)];
    ver_img.image = [UIImage imageNamed:@"abc_spinner_mtrl_am_alpha.9"];
    [searchView addSubview:ver_img];
    
    UIImageView *search1= [[UIImageView alloc]initWithFrame:CGRectMake(53, 6, 18, 18)];
    search1.image = [UIImage imageNamed:@"abc_ic_search_api_mtrl_alpha"];
    [searchView addSubview:search1];
    
    search_tf=[[UITextField alloc]initWithFrame:CGRectMake(72, 7, _width-100, 20)];
    search_tf.placeholder=@"斗图";
    search_tf.delegate=self;
    [search_tf setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [search_tf setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.color"];
    search_tf.userInteractionEnabled=NO;
    search_tf.alpha=0.8;
    search_tf.layer.cornerRadius=3;
    [searchView addSubview:search_tf];
    
    UIButton *search_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    search_btn.frame = CGRectMake(50, 0, _width-150, 27);
    [search_btn addTarget:self action:@selector(searchViewClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:search_btn];
    
    
    UIButton *scan_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    scan_btn.frame = CGRectMake(CGRectGetWidth(searchView.frame)-30,7, 16, 16);
    scan_btn.backgroundColor = APP_ClOUR;
    [scan_btn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:scan_btn];
    
    UIButton *minePageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minePageBtn.backgroundColor = [UIColor redColor];
    minePageBtn.frame = CGRectMake(CGRectGetMaxX(searchView.frame)+5, CGRectGetMinY(searchView.frame), 30, 30);
    [minePageBtn setImage:[UIImage imageNamed:@"default_pic_m"] forState:0];

    minePageBtn.layer.cornerRadius = 15;
    minePageBtn.clipsToBounds = YES;
    minePageBtn.layer.borderColor = RGB(254, 208, 55).CGColor;
    minePageBtn.layer.borderWidth = 2;
    [topView addSubview:minePageBtn];
    
}



-(void)dingweiClick{
    NSLog(@"dingwei");
}

-(void)searchViewClick{
    NSLog(@"search");
    SearchViewController *search_VC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search_VC animated:YES];
}


#pragma mark  广告位
-(void)advistBtnClick:(UIButton*)button
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _pc.currentPage=_smallSV.contentOffset.x/_width;
        
    }];
    //NSLog(@"%ld",(long)_pc.currentPage);
}

-(UIView*)creatSecondheardView{
    UIView *back_view = [UIView new];
    back_view.backgroundColor = [UIColor whiteColor];
    

    
    NSArray *tabs = Data_dic[@"tabs"];
    for (int i = 0; i < 4; i ++) {
        UILabel *title_lab = [[UILabel alloc]initWithFrame:CGRectMake(i*(_width)/4, 0, (_width)/4, 40)];
        
        title_lab.text = [tabs[i]objectForKey:@"title"];
        title_lab.textColor = [UIColor lightGrayColor];
        title_lab.font = [UIFont systemFontOfSize:13];
        title_lab.textAlignment = NSTextAlignmentCenter;
        title_lab.userInteractionEnabled = YES;
        title_lab.tag = [[tabs[i]objectForKey:@"tabId"]integerValue];
        [back_view addSubview:title_lab];
        if (i==0) {
            title_lab.textColor = [UIColor blackColor];
            oldLab = title_lab;
            
             line = [[UIView alloc]init];
            line.bounds = CGRectMake(0, 0, 30, 2);
            line.center = CGPointMake(CGRectGetMidX(title_lab.frame), CGRectGetMidY(title_lab.frame)+12);
            line.backgroundColor = [UIColor redColor];
            [back_view addSubview:line];
            
          
        }
        //添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [title_lab addGestureRecognizer:tapGesture];
        
        
    }

    
    UIView *lineSS = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+2, _width, 1)];
    lineSS.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    [back_view addSubview:lineSS];
    
   
    
    back_view.frame = CGRectMake(0, 0, _width, CGRectGetMaxY(lineSS.frame)+4);
    return back_view;
}


-(void)singleTap:(UITapGestureRecognizer*)tapGesture{
    UILabel *lab = (UILabel*)tapGesture.view;
    NSLog(@"******%ld",(long)lab.tag);
    if (lab!=oldLab) {
        lab.textColor =[UIColor blackColor];
        oldLab.textColor = [UIColor lightGrayColor];
        oldLab = lab;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            line.center = CGPointMake(CGRectGetMidX(lab.frame), CGRectGetMidY(lab.frame)+12);

        }];
        
        [self getDataWithtabId:lab.tag];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


-(void)topClick:(UIButton*)sender{
    PUSH(CategoryViewController)
    
    NSString *urlS = [icon_A[sender.tag]objectForKey:@"url"];
   urlS= [urlS stringByReplacingOccurrencesOfString:@"imlifer://cate/" withString:@""];
    vc.itemId = [urlS integerValue];
    vc.titles = [icon_A[sender.tag]objectForKey:@"title"];
    
}


-(void)scanClick{
  PUSH(ScanViewController)
    
    
}

-(void)jcClick:(UIButton*)sender{
    PUSH(WebViewController)
    
    NSDictionary *dic =[Data_dic[@"homeBeltAdList"] firstObject];

   
    
    vc.url = [dic objectForKey:@"url"];
    vc.title_s = [dic objectForKey:@"title"];

}
-(void)niurenClick:(UIButton*)sender{
    PUSH(WebViewController)
    NSDictionary *niuRenRank = Data_dic[@"niuRenRank"];
    
    NSDictionary *banner = [niuRenRank[@"niuRenBanners"] firstObject];
    
    vc.url = [banner objectForKey:@"url"];
    vc.title_s = [banner objectForKey:@"title"];

}
-(void)fourButClick:(UIButton*)sender{
    PUSH(WebViewController)
    vc.url = [homeFunctionAreaList[sender.tag] objectForKey:@"url"];
    vc.title_s = [homeFunctionAreaList[sender.tag] objectForKey:@"title"];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        
    }else{
        PUSH(DetailViewController)

    }
    
}


@end
