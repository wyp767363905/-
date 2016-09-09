//
//  NavTitleView.h
//  百思不得姐
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavTitleView;
@protocol NavTitleViewDelegate <NSObject>

/** 点击滚动视图上的按钮*/
- (void)navTitleView:(NavTitleView *)navTitleView didClickBtnAtIndex:(NSInteger)index withURLString:(NSString *)urlString;

/** 点击右边的按钮*/
- (void)didClickRightButton:(NavTitleView *)navTitleView;

@end

@interface NavTitleView : UIView

/**
 * 初始化方法
 * titleModels:左边滚动视图上面的标题对象
 * iamgeName:右边按钮上面的图片
 */

- (instancetype)initWithTitles:(NSArray *)titleModels rightImageName:(NSString *)imageName rightHilightImageName:(NSString *)hightlightImageName;

/** 代理属性*/
@property (nonatomic, weak)id<NavTitleViewDelegate> delegate;

/** 选中按钮的序号*/
@property (nonatomic, assign)NSInteger selectedIndex;//在OC默认是0

@end










