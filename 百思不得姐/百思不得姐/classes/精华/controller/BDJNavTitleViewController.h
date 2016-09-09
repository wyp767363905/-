//
//  BDJNavTitleViewController.h
//  百思不得姐
//
//  Created by qianfeng on 16/9/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

@class SubMenuModel;
@interface BDJNavTitleViewController : BaseViewController

//导航上面的标题数据
@property (nonatomic, strong)SubMenuModel *subModel;

//导航右边按钮的图片
@property (nonatomic, copy)NSString *rightImageName;
@property (nonatomic, copy)NSString *rightSelectImageName;

//判断视图是否显示
@property (nonatomic, assign)BOOL viewShowed;

//显示标题的数据
- (void)showData;

@end
