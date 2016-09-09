//
//  NavTitleView.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NavTitleView.h"
#import "UIButton+Util.h"
#import "MenuModel.h"

@interface NavTitleView()

/** 所有滚动视图上面按钮对应的对象*/
@property (nonatomic, strong)NSArray *titleModels;

/** 选中按钮下面的红线*/
@property (nonatomic, strong)UIView *lineView;

/** 滚动视图里面的容器视图*/
@property (nonatomic, strong)UIView *containerView;

@end

@implementation NavTitleView

- (instancetype)initWithTitles:(NSArray *)titleModels rightImageName:(NSString *)imageName rightHilightImageName:(NSString *)hightlightImageName{
    
    if (self == [super init]) {//判断有没有返回这个对象,是否为空
        
        self.titleModels = titleModels;
        
        //右边的按钮
        UIButton *rightBtn = [UIButton createBtnTitle:nil imageName:imageName selectImageName:nil highlightImageName:hightlightImageName target:self action:@selector(clickRight)];
        [self addSubview:rightBtn];
        
        //约束
        __weak typeof(self) weakSelf = self;
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(8);
            make.right.equalTo(weakSelf).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        //左边的滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        //约束
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf).offset(20);
            make.right.equalTo(rightBtn.mas_left);
        }];
        
        //容器视图
        UIView *containerView = [[UIView alloc] init];
        [scrollView addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        
        //循环添加按钮
        //按钮的宽度
        CGFloat width = self.btnWidth;
        //两个按钮横向的简介
        CGFloat spaceX = self.btnSpacex;
        
        //上一个添加了约束的视图
        UIView *lastView = nil;
        for (int i=0; i<titleModels.count; i++) {
            
            NavTitleModel *model = titleModels[i];
            NSString *title = model.name;
            UIButton *btn = [UIButton createBtnTitle:title imageName:nil selectImageName:nil highlightImageName:nil target:self action:@selector(clickTitle:)];
            //设置文字颜色
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
            btn.tag = 300+i;
            [containerView addSubview:btn];
            
            //约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.width.mas_equalTo(width);
                //常量的时候用mas_equalTo
                
                if (i == 0) {
                    //第一个按钮
                    make.left.equalTo(containerView);
                }else{
                    //后面按钮的左边等于前面按钮的右边
                    make.left.equalTo(lastView.mas_right).offset(spaceX);
                }
                
            }];
            
            lastView = btn;
            
        }
        
        //修改滚动范围
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView.mas_right);
        }];
        
        //添加下面的红线
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor redColor];
        [containerView addSubview:self.lineView];
        
        //约束
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(containerView);
        }];
        
        self.containerView = containerView;
        
    }
    
    return self;
    
}

/** 获取按钮的宽度*/
- (CGFloat)btnWidth{
    return 60;
}

/** 获取按钮之间的横向间距*/
- (CGFloat)btnSpacex{
    return 20;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex) {
        //1.取消选中之前的按钮
        UIButton *lastBtn = [self.containerView viewWithTag:300+_selectedIndex];
        lastBtn.selected = NO;
        
        //2.选中当前的按钮
        UIButton *curBtn = [self.containerView viewWithTag:300+selectedIndex];
        curBtn.selected = YES;
        
        //3.修改下划线的位置
        CGFloat btnW = self.btnWidth;
        CGFloat btnSpaceX = self.btnSpacex;
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat x = (btnW+btnSpaceX)*selectedIndex;
            make.left.mas_equalTo(x);
        }];
        
        //4.修改滚动视图的contentOffset值
        UIScrollView *scrollView = (UIScrollView *)self.containerView.superview;
        //默认将当前选中的按钮居中
        CGFloat offsetX = curBtn.centerX-scrollView.centerX;
        //如果contentOffset超出了滚动视图的左边,就显示到滚动视图的最左边
        if (offsetX < 0) {
            offsetX = 0;
        }
        
        //如果contentOffset超出了滚动视图的右边,就显示到滚动视图的最右边
        if (offsetX > scrollView.contentSize.width-scrollView.bounds.size.width) {
            offsetX = scrollView.contentSize.width-scrollView.bounds.size.width;
        }
        scrollView.contentOffset = CGPointMake(offsetX, 0);
    }
    
    _selectedIndex = selectedIndex;
    //下面有self.selectedIndex = index的set方法不能再用
    
}

//点击滚动视图上面的按钮
- (void)clickTitle:(UIButton *)currentBtn{
    
    NSInteger index = currentBtn.tag-300;
    
    if (self.selectedIndex != index) {
        
        //修改选中按钮
        self.selectedIndex = index;
        
        //其他事件
        NavTitleModel *model = self.titleModels[index];
        [self.delegate navTitleView:self didClickBtnAtIndex:index withURLString:model.url];
        
    }
        
}

//点击右边的按钮
- (void)clickRight{
    
    [self.delegate didClickRightButton:self];
    
}

@end
