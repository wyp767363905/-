//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceViewController.h"


@interface EssenceViewController ()

@end


@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航右边的图片
    self.rightImageName = @"navigationButtonRandomN_26x26_";
    self.rightSelectImageName = @"navigationButtonRandomClickN_26x26_";
    
    //显示导航标题数据
    if (self.subModel) {
        [self showData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


















