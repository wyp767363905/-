//
//  UIButton+Util.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

+ (UIButton *)createBtnTitle:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (title != nil) {
        [btn setTitle:title forState:normal];
        [btn setTitleColor:[UIColor blackColor] forState:normal];
    }
    
    if (imageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (selectImageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    }
    
    if (highlightImageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    }
    
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

@end













