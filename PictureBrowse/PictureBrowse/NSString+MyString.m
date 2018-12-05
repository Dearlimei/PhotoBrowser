//
//  NSString+MyString.m
//  PictureBrowse
//
//  Created by zlm on 2018/11/30.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)


+ (NSString *)getSmallImageUrlStr:(NSString *)imgUrl{
    
    NSMutableString *str = [imgUrl mutableCopy];
    if ([NSString dealingUrl:imgUrl]) {
        return nil;
    }
    NSRange range = [str rangeOfString:@"net/"];
    if (range.location != NSNotFound) {
        [str insertString:@"100.140/" atIndex:range.length + range.location];
    }
    
    return str;
}
+ (NSString *)getBigImageUrlStr:(NSString *)imgUrl{
    
    NSMutableString *str = [imgUrl mutableCopy];
    if ([NSString dealingUrl:imgUrl]) {
        return nil;
    }
    NSRange range = [str rangeOfString:@"w.h/"];
    if (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
    }
    return str;
    
}


+ (BOOL)dealingUrl:(NSString *)imgurl {
    NSArray *arr = @[@"http://p0.meituan.net/w.h/movie/dc5f2b812a3497ff86eaa5f2bb928c4817101.jpg",
                     @"http://p0.meituan.net/w.h/mmc/f5523879ec43bdcbda484c5f0e7cf3262776.png",
                     @"http://p0.meituan.net/w.h/movie/234d790d174b4301b79581b6a2cf494c68202.jpg",
                     @"http://p1.meituan.net/w.h/movie/__47466537__5977032.jpg"];
    for (NSString *str in arr) {
        if ([imgurl isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}

@end
