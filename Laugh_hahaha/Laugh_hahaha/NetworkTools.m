//
//  NetworkTools.m
//  network
//
//  Created by ljm on 2016/12/6.
//  Copyright © 2016年 ljm. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+(instancetype)shareTools{
    static NetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例类
        instance = [[NetworkTools alloc]initWithBaseURL:nil];
        
        //增加数据的解析格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/javascript",@"text/json",@"text/html", @"text/plain",nil];
    });
    return instance;
}


//获取高度
/**
 *    通过此方法获取cell 的自定义高度
 */
+ (float)getHeightWithText:(NSString *)text andFont:(CGFloat)font andWidth:(CGFloat)width{
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil].size;
    
    
    return size.height + 1;
}

//封装自己的网络请求
-(void)requestWithMethod:(RequestM)method andURL:(NSString *)url andParameters:(NSDictionary *)param andCallBack:(networkBlock)finished{
    if (method == POST) {
        
        [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject , nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }else{
        [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil,error);
        }];
    }
}

@end
