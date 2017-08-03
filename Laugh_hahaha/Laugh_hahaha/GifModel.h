//
//  GifModel.h
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/1.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GifModel : NSObject

/* < title > */
@property (strong , nonatomic) NSString  * title;

/* < img > */
@property (strong , nonatomic) NSString  * img;

/* < type > */
@property (strong , nonatomic) NSString  * type;

/* < ct > */
@property (strong , nonatomic) NSString  * ct;

@end




/*
 *
 *  {
 "showapi_res_code": 0,
 "showapi_res_error": "",
 "showapi_res_body": {
 "allPages": 7,
 "ret_code": 0,
 "contentlist": [
 {
 "title": "全塑料瓶子做的小船",
 "img": "http://www.zbjuran.com/uploads/allimg/170727/2-1FHGQ145H5.gif",
 "type": 3,
 "ct": "2017-07-27 18:31:15.375"
 },
 *
 */
