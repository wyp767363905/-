//
//  NewsViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

/** 这个方法是用来初始化self.view*/
//- (void)loadView{
//    [super loadView];
//}(让showData在父类被调用就不用这个,因为需要用户体验比较好)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航右边的图片
    self.rightImageName = @"review_post_nav_iconN_20x17_";
    self.rightSelectImageName = @"review_post_nav_icon_clickN_20x17_";
    
    //显示导航标题数据
    if (self.subModel) {
        [self showData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
