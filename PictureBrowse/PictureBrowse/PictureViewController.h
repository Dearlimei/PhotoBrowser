//
//  PictureViewController.h
//  PictureBrowse
//
//  Created by zlm on 2018/11/28.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController

@property (nonatomic, copy) NSString *smallImgUrl;
@property (nonatomic, copy) NSString *originalImgUrl;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIImage *img;

@property (nonatomic, copy) void(^callBack)(void);
@property (nonatomic, copy) void(^successBlock)(NSInteger currentPage);

- (void)loadData;

@end
