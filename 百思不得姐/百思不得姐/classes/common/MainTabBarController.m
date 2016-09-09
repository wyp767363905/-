//
//  MainTabBarController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MainTabBarController.h"
#import "BDJTabBar.h"
#import "MenuModel.h"
#import "EssenceViewController.h"
#import "NewsViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置tabBar的文字颜色
    [UITabBar appearance].tintColor = [UIColor colorWithWhite:64.0/255.0 alpha:1.0];
    
    //创建视图控制器
    [self createViewControllers];
    
    //使用自定制的tabBar
    [self setValue:[[BDJTabBar alloc] init] forKey:@"tabBar"];
    
    //导航标题存到本地
    BOOL flag = [[NSFileManager defaultManager] fileExistsAtPath:[self navTitleFilePath]];
    if (flag) {
        NSData *data = [NSData dataWithContentsOfFile:[self navTitleFilePath]];
        [self parseData:data];
    }
    
    //请求导航标题列表
    [self downloadNavList];
    
}

- (void)parseData:(NSData *)data{
    
    //解析数据
    MenuModel *model = [[MenuModel alloc] initWithData:data error:nil];
    
    //将数据传给精华和最新的界面
    //精华
    UINavigationController *essenceNavCtrl = (UINavigationController *)[self.viewControllers firstObject];
    EssenceViewController *essenceCtrl = (EssenceViewController *)[essenceNavCtrl.viewControllers firstObject];
    essenceCtrl.subModel = model.menus[0];
    
    //最新
    UINavigationController *newsNavCtrl = (UINavigationController *)self.viewControllers[1];
    NewsViewController *newsCtrl = (NewsViewController *)newsNavCtrl.viewControllers[0];
    newsCtrl.subModel = model.menus[1];

    
}

- (void)downloadNavList{
    
    __weak typeof(self) weakSelf = self;
    [BDJDownloader downloadWithUrlString:kNavBarListUrl finish:^(NSData *data) {
        
        //如果是程序第一次下载导航标题数据
        //需要显示一下
        BOOL flag = [[NSFileManager defaultManager] fileExistsAtPath:[weakSelf navTitleFilePath]];
        if (!flag) {
            //文件不存在,下载回来的数据需要显示
            [weakSelf parseData:data];
        }
        
        //存文件
        [data writeToFile:[self navTitleFilePath] atomically:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

//添加子视图控制器
- (void)addViewController:(NSString *)clsName title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    
    //创建视图控制器
    Class cls = NSClassFromString(clsName);
    
    UIViewController *ctrl = [[cls alloc] init];
    
    //设置图片和文字
    ctrl.tabBarItem.title = title;
    
    ctrl.tabBarItem.image = [UIImage imageNamed:imageName];
    
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //导航
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:ctrl];
    
    //添加子视图控制器
    [self addChildViewController:navCtrl];
    
}

//导航标题存到本地的文件名
- (NSString *)navTitleFilePath{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"navTitle"];
    
    return filePath;
    
}

/** 创建视图控制器*/
- (void)createViewControllers{
    
    //精华
    [self addViewController:@"EssenceViewController" title:@"精华" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon"];
    
    //最新
    [self addViewController:@"NewsViewController" title:@"最新" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon"];
    
    //关注
    [self addViewController:@"FollowViewController" title:@"关注" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon"];
    
    //我
    [self addViewController:@"ProfileViewController" title:@"我" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon"];
    
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
