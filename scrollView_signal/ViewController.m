//
//  ViewController.m
//  scrollView_signal
//
//  Created by zry on 2017/9/4.
//  Copyright © 2017年 zry. All rights reserved.
//

#import "ViewController.h"
#define DEVICE_W self.view.frame.size.width
#define DEVICE_H self.view.frame.size.height


@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
    float _height;
    UIButton *_previousBtn;
    UIView *_redView;
    NSMutableArray *_datasource;
    NSArray *_btnArr;
}

@property(nonatomic,strong)UIScrollView *tScrollView;
@property(nonatomic,strong)UITableView *tableViewTask;
@property(nonatomic,strong)UITableView *tableViewConvert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *mainView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, DEVICE_W, 44)];
    [self.view addSubview:mainView];
    
    _btnArr =[NSArray array];

    
    UIButton *btn1 =[UIButton new];
    btn1.frame =CGRectMake(0, 0, DEVICE_W/2, 40);
    [btn1 setTitle:@"历史任务" forState: UIControlStateNormal];
    [btn1 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag =1;
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _previousBtn=btn1;
    [mainView addSubview:btn1];
    
    UIButton *btn2 =[UIButton new];
    btn2.frame =CGRectMake(DEVICE_W/2, 0, DEVICE_W/2, 40);
    [btn2 setTitle:@"消费记录" forState: UIControlStateNormal];
    [btn2 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn2.tag =2;
    [mainView addSubview:btn2];
    _btnArr =@[btn1,btn2];
    
    
    _redView =[[UIView alloc]init];
    _redView.backgroundColor =[UIColor redColor];
    _redView.center=CGPointMake(btn1.center.x, btn1.center.y+18);
    _redView.bounds =CGRectMake(0, 0, 60, 3);
    [mainView addSubview:_redView];
    
    
    
    UIScrollView *scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_W, DEVICE_H)];
    scroll.contentSize =CGSizeMake(DEVICE_W*2, DEVICE_H);
    scroll.bounces =NO;
    scroll.showsHorizontalScrollIndicator =NO;
    scroll.pagingEnabled=YES;
    scroll.delegate =self;
    scroll.directionalLockEnabled =YES;
    [self.view addSubview:scroll];
    self.tScrollView =scroll;
    
    _tableViewTask = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_W, DEVICE_H) style:UITableViewStylePlain];
    _tableViewTask.delegate = self;
    _tableViewTask.dataSource = self;
    [self.tScrollView addSubview:_tableViewTask];
    _tableViewConvert = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_W, 0, DEVICE_W, DEVICE_H) style:UITableViewStylePlain];
    _tableViewConvert.delegate = self;
    _tableViewConvert.dataSource = self;
    [self.tScrollView addSubview:_tableViewConvert];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tableViewTask){
        return 5;
    }else{
        return 10;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"taskCell";
    UITableViewCell *cell = [_tableViewTask dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.textLabel.text = @"2017-08-23";
    cell.detailTextLabel.text = @"+500";
    cell.detailTextLabel.textColor = [UIColor blueColor];
    return cell;
}

/**
 *  滑动 scrollview
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int btnIndex;
    if (scrollView.contentOffset.x<DEVICE_W) {
        btnIndex=0;
    }else{
        btnIndex=1;
    }
    
    NSLog(@"btnindex---%d",btnIndex);
    UIButton *btn =_btnArr[btnIndex];
    [_previousBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame =CGRectMake((DEVICE_W/2)*btnIndex, 0, DEVICE_W/2, 40);
    _previousBtn =btn;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _redView.center =CGPointMake(btn.center.x, btn.center.y+18);
    [UIView commitAnimations];
}

/**
 *  点击标题栏按钮
 *
 *  @param btn 标题栏按钮
 */
-(void)headBtnClick:(UIButton *)btn{
    
    if (btn==_previousBtn) {
        return;
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_previousBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _previousBtn =btn;
    [self.tScrollView setContentOffset:CGPointMake(DEVICE_W*(btn.tag-1), 0) animated:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _redView.center =CGPointMake(btn.center.x, btn.center.y+18);
    [UIView commitAnimations];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
