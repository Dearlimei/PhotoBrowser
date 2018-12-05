//
//  NSString+MyString.h
//  PictureBrowse
//
//  Created by zlm on 2018/11/30.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

+ (NSString *)getBigImageUrlStr:(NSString *)imgUrl;
+ (NSString *)getSmallImageUrlStr:(NSString *)imgUrl;


@end
