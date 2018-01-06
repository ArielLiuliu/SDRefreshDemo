//
//  ViewController.h
//  SDRefreshDemo
//
//  Created by lx on 2018/1/6.
//  Copyright © 2018年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;//表格视图
@property (nonatomic, strong) NSMutableArray *arrayData;//数据源

@end

