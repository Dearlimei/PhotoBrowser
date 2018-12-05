//
//  PictureViewController.m
//  PictureBrowse
//
//  Created by zlm on 2018/11/28.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "PictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define HEIGHT [[UIScreen mainScreen]bounds].size.height
#define WIDTH [[UIScreen mainScreen]bounds].size.width

@interface PictureViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    CGAffineTransform _smallTransForm;
    CGAffineTransform _bigTansForm;
    CGFloat        _y;
    CGFloat        _h;
    UIImageView  *_imgV;
    UIButton     *_Btn;
    BOOL         _end;
    
    
    
    
}
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    _scrollView.frame = self.view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [_scrollView addGestureRecognizer:tap];
    [self loadData];
    
}

- (void)loadData
{
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:_smallImgUrl] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (!error) {
            if (!_imgV) {
                _imgV = [[UIImageView alloc] init];
                [_scrollView addSubview:_imgV];
                _imgV.frame = CGRectMake(0, 0, WIDTH, WIDTH/image.size.width * image.size.height);
                _imgV.center = self.view.center;
                _y = _imgV.frame.origin.y;
                _h = _imgV.frame.size.height;
                _imgV.contentMode = UIViewContentModeScaleAspectFit;
                __unsafe_unretained typeof(self) selfVC = self;
                [_imgV sd_setImageWithURL:[NSURL URLWithString:_originalImgUrl] placeholderImage:image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    //selfVC.successBlock(selfVC.currentPage);
                    selfVC.img = image;
                }];
                
                _scrollView.contentSize = _imgV.frame.size;
                _scrollView.delegate = self;
                _scrollView.maximumZoomScale = 4.0;
                _scrollView.minimumZoomScale = 1.0;
                
            }else if (self.img){
                _successBlock(_currentPage);
            }
        }
        
    }];
    
}

- (void)touch
{
    if (_callBack) {
        _callBack();
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = _imgV.frame;
    if (_imgV.frame.size.height > HEIGHT) {
        frame.origin.y = 0;
    }else{
        frame.origin.y = _y * (HEIGHT/_h - _imgV.transform.a)/(HEIGHT/_h - 1);
    }
    _imgV.frame = frame;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (_img) {
        CGRect frame = _imgV.frame;
        if (_imgV.frame.size.height > HEIGHT) {
            frame.origin.y = 0;
        }else{
            frame.origin.y = _y * (HEIGHT/_h - _imgV.transform.a)/(HEIGHT/_h - 1);
        }
        _imgV.frame = frame;
        return _imgV;
    }
    
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
