//
//  ImageModel.h
//  Laugh_hahaha
//
//  Created by EPIC_IOS on 2017/8/1.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

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
 "allPages": 25,
 "ret_code": 0,
 "contentlist": [
 {
 "title": "怎么就那么可爱呢、",
 "img": "http://sc0.hao123img.com/data/5a95a75fac32b6f52e3844e5b855238f_430",
 "type": 2,
 "ct": "2017-07-31 17:30:03.178"
 },
 *
 */
