//
//  GifTableViewCell.m
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "GifTableViewCell.h"



@implementation GifTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /**
         *    标题
         */
        _titleLab               =   [[UILabel alloc] init];
        _titleLab.textColor     =   [UIColor blackColor];
//        _titleLab.backgroundColor = [UIColor redColor];
        _titleLab.font          =   [UIFont systemFontOfSize:18];
        _titleLab.textAlignment =   NSTextAlignmentLeft;
        _titleLab.numberOfLines =   1;
        [self addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            //            make.bottom.equalTo(_dataLab.mas_top).offset(-5);
            make.height.equalTo(@20);
        }];
        [_titleLab layoutIfNeeded];
        
        
        /**
         *    时间
         */
        _dateLab                =   [[UILabel alloc] init];
//        _dateLab.backgroundColor  = [UIColor greenColor];
        _dateLab.textColor      =   [UIColor lightGrayColor];
        _dateLab.font           =   [UIFont systemFontOfSize:12];
        _dateLab.textAlignment  =   NSTextAlignmentLeft;
        _dateLab.numberOfLines  =   1;
        [self addSubview:_dateLab];
        
        [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLab.mas_bottom).offset(5);
            make.left.equalTo(_titleLab.mas_left);
            make.right.equalTo(_titleLab.mas_right);
            make.height.equalTo(@15);
        }];
        [_dateLab layoutIfNeeded];
        
        
        /**
         *    图片
         */
        _gifImageView = [[YLImageView alloc] init];
        [self addSubview:_gifImageView];
        
        [_gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dateLab.mas_bottom).offset(5);
            make.left.equalTo(self.mas_left).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        [_gifImageView layoutIfNeeded];
    }
    
    return self;
}

- (void)setGifModel:(GifModel *)gifModel
{
    _gifModel = gifModel;
    _titleLab.text  =   gifModel.title;
    _dateLab.text   =   gifModel.ct;
    
    
//    [_gifImageView sd_setImageWithURL:[NSURL URLWithString:gifModel.img] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    /**
     *    异步操作，保证界面不会被卡死
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSData *dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:gifModel.img]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
        
            _gifImageView.image = [YLGIFImage imageWithData:dataImage scale:0.8f];
        });
    });

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
