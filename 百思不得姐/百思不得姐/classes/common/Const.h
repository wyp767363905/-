//
//  Const.h
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#ifndef Const_h
#define Const_h

//屏幕的宽度和高度
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

//网络请求数据的接口

//一 精华

//1.首页的列表

//1.1 推荐
#define kEssenceRecommendUrl (@"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.3/%ld-20.json")

//1.2 视频
#define kEssenceVideoUrl (@"http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.3/%ld-20.json")

//1.3 图片

//1.4 段子

//1.5 网红

//1.6 排行

//1.7 社会

//1.8 美女

//1.9 冷知识

//1.10 游戏

//1.11 自拍

//二 最新

//三 发布

//四 关注

//五 我

#endif /* Const_h */
