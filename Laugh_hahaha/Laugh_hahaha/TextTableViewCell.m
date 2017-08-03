//
//  TextTableViewCell.m
//  Laugh_hahaha
//
//  Created by ljm on 2017/8/3.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell


#pragma mark -- 重写cell的自定义方法
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
        _dataLab                =   [[UILabel alloc] init];
//        _dataLab.backgroundColor  = [UIColor greenColor];
        _dataLab.textColor      =   [UIColor lightGrayColor];
        _dataLab.font           =   [UIFont systemFontOfSize:12];
        _dataLab.textAlignment  =   NSTextAlignmentLeft;
        _dataLab.numberOfLines  =   1;
        [self addSubview:_dataLab];
        
        [_dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLab.mas_bottom).offset(5);
            make.left.equalTo(_titleLab.mas_left);
            make.right.equalTo(_titleLab.mas_right);
            make.height.equalTo(@15);
        }];
        [_dataLab layoutIfNeeded];
        
        
        /**
         *    文本内容
         */
        _textLab                =   [[UILabel alloc] init];
        _textLab.textColor      =   [UIColor grayColor];
        _textLab.font           =   [UIFont systemFontOfSize:15];
        _textLab.textAlignment  =   NSTextAlignmentLeft;
        _textLab.numberOfLines  =   0;
//        _textLab.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_textLab];
     
//        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(55);
//            make.bottom.equalTo(self.mas_bottom).offset(-5);
//            make.left.equalTo(self.mas_left).offset(5);
//            make.right.equalTo(self.mas_right).offset(-5);
//        }];
        
    }
    
    return self;
}


- (void)setCellTextHeight:(CGFloat)cellTextHeight
{
    _cellTextHeight = cellTextHeight;
    
    [self.textLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_cellTextHeight));
        make.top.equalTo(self.mas_top).offset(70);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        //        make.size.mas_equalTo(CGSizeMake(kselfWidth - 10, _cellTextHeight));
    }];
}


#pragma mark -- 给模型赋值
- (void)setTextModel:(TextModel *)textModel
{
    _textModel = textModel;
    _titleLab.text  =   textModel.title;
    _dataLab.text   =   textModel.ct;
    
    _textLab.text   =   textModel.text;
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
