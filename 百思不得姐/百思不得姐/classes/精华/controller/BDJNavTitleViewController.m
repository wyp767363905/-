//
//  BDJNavTitleViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "BDJNavTitleViewController.h"
#import "EssenceTableViewController.h"
#import "MenuModel.h"
#import "NavTitleView.h"

@interface BDJNavTitleViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,NavTitleViewDelegate>

@property (nonatomic, strong)UIPageViewController *pageVC;

//pageCtrl管理的所有视图控制器
@property (nonatomic, strong)NSArray *vcArray;

//导航的标题视图
@property (nonatomic, strong)NavTitleView *titleView;

@end

@implementation BDJNavTitleViewController

- (void)loadView{
    
    [super loadView];
    
    //view已经显示了
    self.viewShowed = YES;
    
}

- (NSArray *)vcArray{
    
    if (nil == _vcArray) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; i<self.subModel.submenus.count; i++) {
            EssenceTableViewController *essenceSubCtrl = [[EssenceTableViewController alloc] init];
            NavTitleModel *model = self.subModel.submenus[i];
            if ([model.url hasSuffix:@"/"]) {
                essenceSubCtrl.urlPrefix = model.url;
            }else{
                essenceSubCtrl.urlPrefix = [NSString stringWithFormat:@"%@/",model.url];
            }
            [array addObject:essenceSubCtrl];
        }
        
        _vcArray = [NSArray arrayWithArray:array];
        
    }
    
    return _vcArray;
    
}

- (void)showData{
    
    //显示导航上面的标题列表
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NavTitleView *titleView = [[NavTitleView alloc] initWithTitles:weakSelf.subModel.submenus rightImageName:self.rightImageName rightHilightImageName:self.rightSelectImageName];
        
        weakSelf.titleView = titleView;
        
        titleView.delegate = weakSelf;
        
        [weakSelf.view addSubview:titleView];
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(20);
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(44);
        }];
    });
    
    //创建pageController
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf createPageCtrl];
    });
    
}

//设置导航标题
- (void)setSubModel:(SubMenuModel *)subModel{
    
    _subModel = subModel;
    
    //显示(让其作为父被调用)(首页数据没有下载好的时候调用)
    if (self.viewShowed) {
        [self showData];
    }
    
}

/** 创建pageController*/
- (void)createPageCtrl{
    
    //自定制一个导航视图
    //隐藏系统的导航条
    self.navigationController.navigationBarHidden = YES;
    
    //显示横向滚动的界面
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //设置代理
    pageVC.dataSource = self;
    pageVC.delegate = self;
    
    //设置视图控制器
    EssenceTableViewController *recommendCtrl = [self.vcArray firstObject];
    [pageVC setViewControllers:@[recommendCtrl] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:pageVC.view];
    
    __weak typeof(self) weakSelf = self;
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    self.pageVC = pageVC;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:240.0/255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIPageViewController代理
//返回某个视图控制器后面的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger curIndex = [self.vcArray indexOfObject:viewController];
    if (curIndex < self.vcArray.count-1) {
        EssenceTableViewController *nextCtrl = self.vcArray[curIndex+1];
        return nextCtrl;
    }
    
    return nil;
}

//返回某个视图控制器前面的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger curIndex = [self.vcArray indexOfObject:viewController];
    if (curIndex > 0) {
        EssenceTableViewController *preCtrl = self.vcArray[curIndex-1];
        return preCtrl;
    }
    
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    //获取当前显示的界面
    UIViewController *vCtrl = [pageViewController.viewControllers lastObject];
    NSInteger index = [self.vcArray indexOfObject:vCtrl];
    
    self.titleView.selectedIndex = index;
    
}

#pragma mark - NavTitleView代理
- (void)didClickRightButton:(NavTitleView *)navTitleView{
    NSLog(@"%s", __FUNCTION__);
}

- (void)navTitleView:(NavTitleView *)navTitleView didClickBtnAtIndex:(NSInteger)index withURLString:(NSString *)urlString{
    
    //将要显示的视图控制器
    UIViewController *toVCtrl = self.vcArray[index];
    //将要消失的视图控制器
    UIViewController *curCtrl = [self.pageVC.viewControllers lastObject];
    NSInteger lastIndex = [self.vcArray indexOfObject:curCtrl];
    
    UIPageViewControllerNavigationDirection dir = UIPageViewControllerNavigationDirectionForward;
    //可以写0和1
    
    if (index < lastIndex) {
        dir = UIPageViewControllerNavigationDirectionReverse;
    }
    
    //UIPageViewControllerNavigationDirectionForward:动画从左向右
    //UIPageViewControllerNavigationDirectionReverse:动画从右向左
    
    [self.pageVC setViewControllers:@[toVCtrl] direction:dir animated:YES completion:nil];
}

@end
