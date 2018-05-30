//
//  MOViewController.m
//  AAChartKitDemo
//
//  Created by mo on 2018/5/30.
//  Copyright © 2018年 Danny boy. All rights reserved.
//

#import "MOViewController.h"
#import "AAChartKit.h"

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

@interface MOViewController ()<UITableViewDelegate,UITableViewDataSource,AAChartViewDidFinishLoadDelegate>

@property (nonatomic,strong) UITableView *tableview_main;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;


@property (nonatomic,assign) int index;

@end

@implementation MOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview_main = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableview_main.delegate = self;
    self.tableview_main.dataSource = self;
    [self.view addSubview:self.tableview_main];
    
    
    UIButton *button_1 = [[UIButton alloc]init];
    button_1.frame = CGRectMake(50, 50, 100, 50);
    button_1.backgroundColor = [UIColor greenColor];
    [button_1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [button_1 setTitle:@"button1" forState:UIControlStateNormal];
    [self.view addSubview:button_1];
    
    UIButton *button_2 = [[UIButton alloc]init];
    button_2.frame = CGRectMake(250, 50, 100, 50);
    button_2.backgroundColor = [UIColor greenColor];
    [button_2 setTitle:@"button2" forState:UIControlStateNormal];
    [button_2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_2];
    
    
    //添加曲线图
    [self setUpTheAAChartViewWithChartType:AAChartTypeSpline];
}
/**
 添加曲线图
 */
- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType {
    
    CGFloat chartViewWidth  = Screen_width;
    CGFloat chartViewHeight = Screen_width*0.8;
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(0, 0, chartViewWidth, chartViewHeight);
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    
    self.aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(chartType)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"订单笔数")//图表副标题
    .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@45,@88,@49,@43,@65,@56,@47,@28,@49,@44,@89,@55]),
                 ]);
    self.aaChartModel.dataLabelEnabled = NO;
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    self.aaChartModel.zoomType = AAChartZoomTypeX;
    _aaChartModel.symbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
    _aaChartModel.markerRadius = @3;
    
    [self.aaChartView aa_drawChartWithChartModel:self.aaChartModel];
}
/**
 曲线图代理方法,不可删掉
 */
- (void)AAChartViewDidFinishLoad
{
    
}
- (void)click1
{
    self.index = 0;
    
    [self.tableview_main reloadData];
}
- (void)click2
{
    self.index = 1;
    [self.tableview_main reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *ID = @"HomeTableViewCell";
    //HomeTableViewCell *cell = [tableView XIBDequeueReusableCellWithIdentifier:ID];
    
    return [UITableViewCell new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.index == 0){
        return self.aaChartView;
    }
    else{
        UILabel *label_text = [[UILabel alloc]init];
        label_text.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        label_text.backgroundColor = [UIColor orangeColor];
        label_text.text = @"我是第 1 组数据";
        return label_text;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.index == 0){
        return 300;
    }
    else{
        return 80;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end

