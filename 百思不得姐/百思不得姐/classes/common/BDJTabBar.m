//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "BDJTabBar.h"
#import "UIButton+Util.h"

@implementation BDJTabBar

- (instancetype)init{
    
    if (self = [super init]) {
        
        //self.barTintColor = [UIColor redColor];
        //创建添加的按钮
        UIButton *btn = [UIButton createBtnTitle:nil imageName:@"tabBar_publish_icon" selectImageName:@"tabBar_publish_click_icon" highlightImageName:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

- (void)publishAction{
    
}

//这个方法是用来给视图重新布局的
- (void)layoutSubviews{
    [super layoutSubviews];
    //NSLog(@"layoutSubviews");(这个方法在这里会调用两次)
    
    //修改约束(不让修改约束)
    CGFloat btnW = kScreenWidth/5;
    
    //循环修改约束
    int index = 0;//(为了变量在闭包里面使用加上(__block))
    for (UIView *subView in self.subviews) {
        
        //判断是否是按钮
        //UIButton
        //UITabBarButton
        if ([subView isKindOfClass:[UIControl class]]) {
            
            if ([subView isKindOfClass:[UIButton class]]) {
                
                //添加按钮
                CGFloat offsetX = kScreenWidth/2-40/2;
                subView.frame = CGRectMake(offsetX, 4, 40, 40);
                
            }else{
                //默认的tabBarItem的按钮
                if (index > 1) {
                    subView.x = btnW*(index+1);
                }else{
                    subView.x = btnW*index;
                }
                
                //修改宽度
                subView.width = btnW;
                
                index ++;

            }
            
        }
        
    }
    
}

@end
















