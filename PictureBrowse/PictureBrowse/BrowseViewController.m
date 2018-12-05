//
//  BrowseViewController.m
//  PictureBrowse
//
//  Created by zlm on 2018/11/28.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "BrowseViewController.h"
#import "PictureViewController.h"
#import "ViewController.h"
#import <AFNetworking.h>
#import "ViewController.h"
#import "NSString+MyString.h"


#define HEIGHT [[UIScreen mainScreen]bounds].size.height
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_MAX_LENGTH (MAX(WIDTH, HEIGHT))
#define IS_IPHONEX      (SCREEN_MAX_LENGTH == 812.0)
#define SafeAreaTopHeight (IS_IPHONEX ? 88 : 64)
#define MOVIEDETAIL @"http://api.maoyan.com/dianying/movie/%ld/photos.json"

@interface BrowseViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    
    UIPageViewController *_pageViewController;
    UIImageView *_navigationBar;
    UILabel   *_pageLabel;
    UIView   *_tabBarView;
    PictureViewController *_pictureVC;
    NSInteger _nowPage;
    BOOL _isShow;
    
}
@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfig];
    [self confiUI];
   
}

- (void)confiUI{
    
    _isShow = YES;
    self.view.userInteractionEnabled = YES;
    _pictureVC = [[PictureViewController alloc] init];
    _pictureVC.smallImgUrl = [NSString getBigImageUrlStr:[(PictureModel *)(_photoArray[_currentPage - 1]) olink]];
    _pictureVC.originalImgUrl = [NSString getSmallImageUrlStr:[(PictureModel *)(_photoArray[_currentPage - 1]) tlink]];
    _pictureVC.currentPage = _currentPage;
    _nowPage = _currentPage;
    __unsafe_unretained typeof(self) selfVc = self;
    [_pictureVC setCallBack:^{
        [selfVc tapClick];
    }];
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    [_pageViewController setViewControllers:@[_pictureVC] direction:0 animated:YES completion:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self.view addSubview:_pageViewController.view];
    [self.view bringSubviewToFront:_navigationBar];
    
    
}


- (void)navigationConfig
{
    
    _navigationBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, SafeAreaTopHeight)];
    _navigationBar.backgroundColor = [UIColor blueColor];
    _navigationBar.userInteractionEnabled = YES;
    [self.view addSubview:_navigationBar];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [_navigationBar addSubview:_pageLabel];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPage,self.photoArray.count];
    _pageLabel.textColor = [UIColor whiteColor];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 40, 18)];
    [backBtn setImage:[UIImage imageNamed:@"shoppingcart_pop_close_button.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addSubview:backBtn];
    
    
    
}

#pragma mark - tapClick
- (void)tapClick
{
    _navigationBar.hidden = _isShow;
    [UIApplication sharedApplication].statusBarHidden = _isShow;
    _isShow = !_isShow;
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - pageVC代理
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PictureViewController *pvc = (PictureViewController *)viewController;
    NSInteger index = pvc.currentPage - 1;
    index ++;
    if (index >= self.photoArray.count) {
        index = self.photoArray.count - 1;
        return nil;
    }
    pvc = [[PictureViewController alloc] init];
    pvc.smallImgUrl = [NSString getBigImageUrlStr:[(PictureModel *)(_photoArray[index]) olink]];
    pvc.originalImgUrl = [NSString getSmallImageUrlStr:[(PictureModel *)(_photoArray[index]) tlink]];
    pvc.currentPage = index + 1;
  
    return pvc;
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    PictureViewController *pvc = (PictureViewController *)viewController;
    NSInteger index = pvc.currentPage - 1;
    index --;
    if (index < 0) {
        index = 0;
        return nil;
    }
    
    pvc = [[PictureViewController alloc] init];
    pvc.smallImgUrl = [NSString getBigImageUrlStr:[(PictureModel *)(_photoArray[index]) olink]];
    pvc.originalImgUrl = [NSString getSmallImageUrlStr:[(PictureModel *)(_photoArray[index]) tlink]];
    pvc.currentPage = index + 1;
    
    return pvc;
    
}

-  (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    PictureViewController *pvc = (PictureViewController*)pageViewController.viewControllers[0];
    NSInteger index = pvc.currentPage;
    _nowPage = index;
    _pictureVC = pvc;
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,self.photoArray.count];
    [pvc loadData];
    
    
}


//- (void)getDate
//{
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *urlStr = [NSString stringWithFormat:MOVIEDETAIL,341213];
//    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"下载进度%@",downloadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        _photoArray = [PictureModel parsingDataWithJson:responseObject];
//        [self confiUI];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"下载失败");
//    }];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
