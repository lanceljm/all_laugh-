//
//  NetworkTools.h
//  network
//
//  Created by ljm on 2016/12/6.
//  Copyright © 2016年 ljm. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//定义block属性
typedef void(^networkBlock)(id data,NSError *error);

//用于区别网络请求的枚举
typedef enum {
    GET,
    POST,
}RequestM;

@interface NetworkTools : AFHTTPSessionManager

//网络请求单例类
+(instancetype)shareTools;

/** 根据文字获取高度 **/
+ (float)getHeightWithText:(NSString *)text andFont:(CGFloat)font andWidth:(CGFloat)width;

//封装自己的网络请求
-(void)requestWithMethod:(RequestM)method andURL:(NSString *)url andParameters:(NSDictionary *)param andCallBack:(networkBlock)finished;

@end
