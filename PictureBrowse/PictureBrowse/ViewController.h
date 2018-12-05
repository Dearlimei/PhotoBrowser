//
//  ViewController.h
//  PictureBrowse
//
//  Created by zlm on 2018/11/28.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *photoArr;

@end


@interface PictureModel : NSObject

@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *olink;
@property (nonatomic, copy) NSString *tlink;

+ (NSMutableArray *)parsingDataWithJson:(NSData *)data;

@end

