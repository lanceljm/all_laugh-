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
{
    NSInteger   _index;
    NSInteger   _allpage;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView    *myTableview;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _index = 1;

    
    [self.view addSubview:self.myTableview];
//    self.view.backgroundColor = [UIColor greenColor];
//    [self loadDataSource];
    [self refreshDataSource];
    
}

#pragma mark -- 刷新
- (void) refreshDataSource
{
    if (_index > _allpage || _index < 1) {
        _index = 1;
    }
    
    /* < 下拉刷新 > */
    __weak typeof(self) weakself = self;
    self.myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataSource];
    }];
    [self.myTableview.mj_header beginRefreshing];
    
    
    /* < 上拉刷新 > */
    self.myTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself uploadDataSource];
    }];
}

#pragma mark -- 下拉刷新的网络请求
- (void) loadDataSource
{
    [[NetworkTools shareTools] requestWithMethod:GET andURL:GifURL andParameters:@{parmDic,@"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
        NSArray *arr = data[@"showapi_res_body"][@"contentlist"];
        _allpage = [data[@"showapi_res_body"][@"allPages"] integerValue];
        if (!error) {
            self.dataArray = [GifModel mj_objectArrayWithKeyValuesArray:arr];
            [self.myTableview reloadData];
            [self.myTableview.mj_header endRefreshing];
            if (_index) {
                _index --;
            }
        }else
        {
            SLLog(@"gif网络请求失败，失败原因：%@",error);
            [self.myTableview.mj_header endRefreshing];
        }
    }];
}

#pragma mark -- 上拉刷新
- (void) uploadDataSource
{

    [[NetworkTools shareTools] requestWithMethod:GET andURL:GifURL andParameters:@{parmDic,@"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
        NSArray *arr = data[@"showapi_res_body"][@"contentlist"];
        /** 最大页数 **/
        _allpage = [data[@"showapi_res_body"][@"allPages"] integerValue];
        if (!error) {
            self.dataArray = [GifModel mj_objectArrayWithKeyValuesArray:arr];
            [self.myTableview reloadData];
            [self.myTableview.mj_footer endRefreshing];
            _index ++;

        }else
        {
            SLLog(@"上拉刷新网络请求失败");
            [self.myTableview.mj_footer endRefreshing];
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
        _myTableview.rowHeight = kselfWidth ;
    }
    return _myTableview;
}


@end
