//
//  GifTableViewCell.h
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 加载GIF图使用 **/
#import <YLGIFImage/YLGIFImage.h>
#import <YLGIFImage/YLImageView.h>

@interface GifTableViewCell : UITableViewCell

/** 标题 **/
@property (nonatomic,strong) UILabel *titleLab;

/** 图片 **/
@property (nonatomic,strong) YLImageView *gifImageView;

/** 日期 **/
@property (nonatomic,strong) UILabel *dateLab;

/** 模型 **/
@property (nonatomic,strong) GifModel *gifModel;

@end
