//
//  ViewController.m
//  PictureBrowse
//
//  Created by zlm on 2018/11/28.
//  Copyright © 2018年 zlm. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "BrowseViewController.h"
#import "AppDelegate.h"

#define ScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define ScreenHight        [[UIScreen mainScreen] bounds].size.height
#define MOVIEDETAIL @"http://api.maoyan.com/dianying/movie/%ld/photos.json"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"照片浏览";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 60)/2, 100, 60, 44)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"浏览" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(photoBrowes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self getDate];
    
}

#pragma mark - 获取数据
- (void)getDate
{
    
  
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:MOVIEDETAIL,341213];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _photoArr = [PictureModel parsingDataWithJson:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
//    //AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    manager.serializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:[NSString stringWithFormat:MOVIEDETAIL,42964] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        _photoArr = [PictureModel parsingDataWithJson:responseObject];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败");
//    }];
//
}

- (void)photoBrowes
{
    BrowseViewController *vc = [[BrowseViewController alloc] init];
    vc.photoArray = _photoArr;
    vc.currentPage = 1;
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window.rootViewController presentViewController:vc animated:YES completion:nil];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



@implementation PictureModel

+ (NSMutableArray *)parsingDataWithJson:(NSData *)data
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([res isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resDic = (NSDictionary *)res;
        NSArray *resArr = resDic[@"data"];
        for (int i = 0; i < resArr.count; i++) {
            NSDictionary *photoDic = resArr[i];
            PictureModel *model = [[PictureModel alloc] init];
            model.olink = photoDic[@"olink"];
            model.tlink = photoDic[@"tlink"];
            //[model setValuesForKeysWithDictionary:photoDic];
            model.ID = i + 1;
            [dataArray addObject:model];
        }
        
        
    }
    
    return dataArray;
}


@end



