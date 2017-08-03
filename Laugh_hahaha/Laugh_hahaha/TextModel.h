//
//  TextModel.h
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/1.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject

/* < title > */
@property (strong , nonatomic) NSString  * title;

/* < text > */
@property (strong , nonatomic) NSString  * text;

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
 "allPages": 467,
 "ret_code": 0,
 "contentlist": [
 {
 "text": "一对情侣嘿咻完以后，男的问：你觉得如何？女孩羞答答的说：我只能用一个英国人和一个美国人来形容。男的不解。女孩红着脸说：理查德.泰森。",
 "title": "嘿咻",
 "type": 1,
 "ct": "2017-08-01 16:03:57.684"
 },
 *
 */
