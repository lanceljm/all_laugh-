//
//  ImageViewController.m
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/2.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageTableViewCell.h"

static NSString *cellid = @"cellID";

@interface ImageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_myTableView;
    NSMutableArray  *_dataArray;
    NSInteger       _index;
    NSInteger       _allPage;
}

@end

@implementation ImageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myTableView = [[UITableView alloc] init];
        
        _dataArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    self.view.backgroundColor = [UIColor yellowColor];
//    [self setupDataSource];
    [self setupUI];
    [self mjRefreshLoadDataSource];
    
    _index = 1;

}

- (void) mjRefreshLoadDataSource
{
    if (_index < 1 || _index > _allPage) {
        _index = 1;
    }
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupDataSource];
    }];
    [_myTableView.mj_header beginRefreshing];
    
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadUPDataSource];
    }];
}

- (void) setupDataSource
{

    [[NetworkTools shareTools] requestWithMethod:GET andURL:ImageURL andParameters:@{parmDic,@"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
        NSArray *dataArr = data[@"showapi_res_body"][@"contentlist"];
        /** 最大页数 **/
        _allPage = [data[@"showapi_res_body"][@"allPages"] integerValue];
        [_dataArray removeAllObjects];
        if (!error) {
            _dataArray = [ImageModel mj_objectArrayWithKeyValuesArray:dataArr];
            [_myTableView reloadData];
            [_myTableView.mj_header endRefreshing];
            if (_index > 2) {
                _index --;
            }
        }else
        {
            SLLog(@"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\图片网络请求失败,失败原因：%@",error);
            [_myTableView.mj_header endRefreshing];
        }
    }];
}

-(void) loadUPDataSource
{
    [[NetworkTools shareTools] requestWithMethod:GET andURL:ImageURL andParameters:@{parmDic,@"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
        NSArray *dataArr = data[@"showapi_res_body"][@"contentlist"];
        /** 最大页数 **/
        _allPage = [data[@"showapi_res_body"][@"allPages"] integerValue];
        if (!error) {
            _dataArray = [ImageModel mj_objectArrayWithKeyValuesArray:dataArr];
            [_myTableView reloadData];
            [_myTableView.mj_footer endRefreshing];
            _index ++;
        }else
        {
            SLLog(@"图片网络请求失败");
            [_myTableView.mj_footer endRefreshing];
        }
        
    }];
}


- (void) setupUI
{
    _myTableView.frame = [UIScreen mainScreen].bounds;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = kselfWidth * 1.2;
    [self.view addSubview:_myTableView];
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.imageModel = _dataArray[indexPath.row];
    /** 取消cell的点击效果 **/
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
