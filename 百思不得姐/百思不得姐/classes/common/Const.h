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

//零 获取精华和最新的类型列表
#define kNavBarListUrl (@"http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/")

//一 精华

//0.1
//精华接口后面共同的部分
#define kEssenceSuffixUrl (@"bs0315-iphone-4.3/%ld-20.json")

//1.1 推荐
#define kEssenceRecommendUrl (@"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.3/%ld-20.json")

//1.2 视频
#define kEssenceVideoUrl (@"http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.3/%ld-20.json")

//1.3图片
//http://s.budejie.com/topic/list/jingxuan/10/bs0315-iphone-4.3/0-20.json

//http://s.budejie.com/topic/list/jingxuan/10/bs0315-iphone-4.3/1471964401-20.json

//1.4段子
//http://s.budejie.com/topic/tag-topic/64/hot/bs0315-iphone-4.3/0-20.json

//http://s.budejie.com/topic/tag-topic/64/hot/bs0315-iphone-4.3/1471964023-20.json

//1.5网红

//http://s.budejie.com/topic/tag-topic/3096/hot/bs0315-iphone-4.3/0-20.json

//http://s.budejie.com/topic/tag-topic/3096/hot/bs0315-iphone-4.3/1472002248-20.json

//1.6排行
//http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.3/0-20.json
//http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.3/1471525321-20.json


//1.7社会
//http://s.budejie.com/topic/tag-topic/473/hot/bs0315-iphone-4.3/0-20.json
//http://s.budejie.com/topic/tag-topic/473/hot/bs0315-iphone-4.3/1471879282-20.json


//1.8美女
//http://s.budejie.com/topic/tag-topic/117/hot/bs0315-iphone-4.3/0-20.json

//http://s.budejie.com/topic/tag-topic/117/hot/bs0315-iphone-4.3/1471966771-20.json


//1.9冷知识
//http://s.budejie.com/topic/tag-topic/3176/hot/bs0315-iphone-4.3/0-20.json
//http://s.budejie.com/topic/tag-topic/3176/hot/bs0315-iphone-4.3/1471941754-20.json

//1.10游戏
//http://s.budejie.com/topic/tag-topic/164/hot/bs0315-iphone-4.3/0-20.json
//http://s.budejie.com/topic/tag-topic/164/hot/bs0315-iphone-4.3/1471888028-20.json

//二 最新

//三 发布

//四 关注

//五 我

#endif /* Const_h */
