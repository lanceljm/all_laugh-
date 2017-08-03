//
//  ImageTableViewCell.h
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell

/** 标题 **/
@property (nonatomic,strong) UILabel *titleLab;

/** 图片 **/
@property (nonatomic,strong) UIImageView *staticImageView;

/** 日期 **/
@property (nonatomic,strong) UILabel *dateLab;

/** 模型 **/
@property (nonatomic,strong) ImageModel *imageModel;

@end
