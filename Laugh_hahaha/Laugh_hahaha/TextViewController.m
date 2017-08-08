//
//  TextViewController.m
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/2.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "TextViewController.h"
#import "TextTableViewCell.h"

static NSString *cellID = @"cellId";

@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *   _myTableview;
    NSMutableArray  *   _cellTextHeightArr;
    NSInteger       _index;
    NSInteger       _allPage;
    
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self loadDataSource];
    [self initWithInterface];
    [self refreshDataSource];
    
    _index = 1;

}

#pragma mark -- 初始化界面
- (void) initWithInterface
{
//    self.view.backgroundColor       =   [UIColor redColor];
    
    _myTableview                    =   [[UITableView alloc] initWithFrame:[UIScreen mainScreen] .bounds];
    _myTableview .frame = [UIScreen mainScreen].bounds;
    _myTableview .backgroundColor   =   [UIColor whiteColor];
    _myTableview.delegate           =   self;
    _myTableview.dataSource         =   self;
    _myTableview.separatorStyle     =   UITableViewCellSelectionStyleNone;

    /** 预估高度,一定要有这个 **/
    _myTableview.estimatedRowHeight =   80.f;
    [self.view addSubview:_myTableview];
    
    _cellTextHeightArr = [NSMutableArray new];
}

#pragma mark -- 刷新
- (void) refreshDataSource
{
    /** 最大页数是467 **/
    if (_index < 1 || _index > _allPage) {
        _index = 1;
    }

    /** 下拉刷新 **/
    _myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadUPDataSource];
    }];
    [_myTableview.mj_header beginRefreshing];
    
    /** 上拉刷新**/
    _myTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDownDataSource];
    }];
}

#pragma mark -- 加载数据
- (void) loadUPDataSource
{
    __weak typeof(self)weakself = self;
    
    [[NetworkTools shareTools] requestWithMethod:GET andURL:TextURL andParameters: @{parmDic,@"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
//        SLLog(@"data:%@",data);
        SLLog(@"currentpage:%ld",(long)_index);
        NSDictionary *dic   =   data[@"showapi_res_body"];
        NSArray *array      =   dic[@"contentlist"];
        /** 网络请求得到最大页数 **/
        _allPage = [dic[@"allPages"] integerValue];
        [weakself.dataArr removeAllObjects];
        
        /** 网络请求成功 **/
        if (!error) {
            /** 获取文本内容 **/
            for (NSDictionary *textDic in array) {
                [_cellTextHeightArr addObject:@([NetworkTools getHeightWithText:textDic[@"text"] andFont:15 andWidth:kselfWidth - 10])];
            }
            
            weakself.dataArr = [TextModel mj_objectArrayWithKeyValuesArray:array];
            [_myTableview reloadData];
            [_myTableview.mj_header endRefreshing];
            if (_index > 2) {
                _index -- ;
            }

            
            SLLog(@"-------------array:%@--------------",weakself.dataArr);
        }else
        {
            /** 网络请求失败 **/
            SLLog(@"------网络请求错误-------");
            [_myTableview.mj_header endRefreshing];
        }
    }];
}

- (void) loadDownDataSource
{
    __weak typeof(self) weakself = self;
    
    [[NetworkTools shareTools] requestWithMethod:GET andURL:TextURL andParameters:@{parmDic , @"page":[NSString stringWithFormat:@"%ld",(long)_index]} andCallBack:^(id data, NSError *error) {
        NSArray *array      =   data[@"showapi_res_body"][@"contentlist"];
        if (!error) {
            /** 获取文本内容 **/
            for (NSDictionary *textDic in array) {
                [_cellTextHeightArr addObject:@([NetworkTools getHeightWithText:textDic[@"text"] andFont:15 andWidth:kselfWidth - 10])];
            }
            weakself.dataArr = [TextModel mj_objectArrayWithKeyValuesArray:array];
            [_myTableview reloadData];
            [_myTableview.mj_footer endRefreshing];
            _index ++;
            
        }else
        {
            SLLog(@"上拉网络请求错误");
            [_myTableview.mj_footer endRefreshing];
        }
    }];
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    SLLog(@"%lu",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}

#pragma mark -- uitableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    /** 取消cell的点击效果 **/
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textModel = self.dataArr[indexPath.row];
    /** 把通过文本获取的高度传到cell **/
    cell.cellTextHeight = [_cellTextHeightArr[indexPath.row] integerValue];
//    SLLog(@"%ld",(long)cell.cellTextHeight);
//    SLLog(@"cell的高度数组：%ld",(long)[_cellTextHeightArr[indexPath.row] integerValue]);
    
//    SLLog(@"%@",self.dataArr);
    
    return cell;
}

#pragma mark -- getter
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

@end
