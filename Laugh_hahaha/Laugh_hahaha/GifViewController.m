//
//  GifViewController.m
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/2.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "GifViewController.h"
#import "GifTableViewCell.h"

static NSString *cellID = @"cellId";

@interface GifViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView    *myTableview;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.myTableview];
//    self.view.backgroundColor = [UIColor greenColor];
    
    
    [self loadDataSource];

    
}

#pragma mark -- 网络请求
- (void) loadDataSource
{
    [[NetworkTools shareTools] requestWithMethod:GET andURL:GifURL andParameters:parmDic andCallBack:^(id data, NSError *error) {
        NSArray *arr = data[@"showapi_res_body"][@"contentlist"];
        if (!error) {
            self.dataArray = [GifModel mj_objectArrayWithKeyValuesArray:arr];
            [self.myTableview reloadData];
        }else
        {
            SLLog(@"gif网络请求失败，失败原因：%@",error);
        }
    }];
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GifTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GifTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.gifModel = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark -- getter
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView *)myTableview
{
    if (!_myTableview) {
        _myTableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _myTableview.delegate = self;
        _myTableview.dataSource = self;
        _myTableview.rowHeight = kselfWidth;
    }
    return _myTableview;
}

@end
