//
//  TextTableViewCell.h
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell


@property (nonatomic,assign) CGFloat cellTextHeight;

/** 标题 **/
@property (nonatomic,strong) UILabel *titleLab;

/** 日期 **/
@property (nonatomic,strong) UILabel *dataLab;

/** 文本 **/
@property (nonatomic,strong) UILabel *textLab;

/** 文本模型 **/
@property (nonatomic,strong) TextModel *textModel;

@end
