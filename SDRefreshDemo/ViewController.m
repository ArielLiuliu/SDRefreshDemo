//
//  ViewController.m
//  SDRefreshDemo
//
//  Created by lx on 2018/1/6.
//  Copyright © 2018年 lx. All rights reserved.
//

#import "ViewController.h"
#import "SDRefresh.h"

@interface ViewController ()
@property (nonatomic, strong) SDRefreshHeaderView *refreshHeaderView;//下拉刷新控件
@property (nonatomic, strong) SDRefreshFooterView *refreshFooterView;//上拉刷新控件
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;//不向四周延展
    self.title = @"上下拉刷新控件";
    
    //设置数据源
    self.arrayData = [NSMutableArray arrayWithObjects:@"张三",@"张三2",@"张三3",@"张三4", @"张三5",@"张三6",@"张三7",@"张三8",@"张三9",@"张三10", nil];
    
    //创建表格视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:self.tableView];
    
    //添加下拉刷新控件
    self.refreshHeaderView = [SDRefreshHeaderView refreshView];
    [self.refreshHeaderView addToScrollView:self.tableView];
    __weak ViewController *weakSelf = self;
    self.refreshHeaderView.beginRefreshingOperation = ^{
        [weakSelf reloadNetworkData:YES];//自定义刷新数据
    };
    
    //添加上拉刷新控件
    self.refreshFooterView = [SDRefreshFooterView refreshView];
    [self.refreshFooterView addToScrollView:self.tableView];
    self.refreshFooterView.beginRefreshingOperation = ^{
        [weakSelf reloadNetworkData:NO];//自定义刷新数据
    };
}

/**
 功能：自定义刷新数据
 参数：flag=YES表示下拉刷新，flag=NO表示上拉刷新
**/
- (void)reloadNetworkData:(BOOL)flag {
    if (flag) {//下拉刷橷
        self.arrayData = [NSMutableArray arrayWithObjects:@"张三",@"张三2",@"张三3",@"张三4",@"张三5",@"张三6",@"张三7",@"张三8",@"张三9",@"张三10", nil];
    } else {//上拉刷新
        [self.arrayData addObject:@"张三 More"];
    }
    
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1];
}

//收回刷新动画
- (void)refreshData {
    [self.tableView reloadData];//刷新表视图
    
    //收回动画
    [self.refreshHeaderView endRefreshing];
    [self.refreshFooterView endRefreshing];
}

//表格视图的数据原委托
#pragma mark - UITableViewDataSource
//设置表格视图每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrayData && [self.arrayData count])
    {
        return [self.arrayData count];
    }
    
    return 0;
}

//设置表格视图每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if (self.arrayData && indexPath.row < [self.arrayData count])
    {
        cell.textLabel.text = self.arrayData[indexPath.row];
    }
    
    return cell;
}

//表格视图的代理委托
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
