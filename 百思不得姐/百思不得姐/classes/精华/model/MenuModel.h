//
//  MenuModel.h
//  百思不得姐
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class DefaultMenuModel;
@protocol SubMenuModel;
@protocol NavTitleModel;

@interface MenuModel : JSONModel

@property (nonatomic, strong)NSArray<Optional,SubMenuModel> *menus;
@property (nonatomic, strong)DefaultMenuModel<Optional> *default_menu;

@end

@interface SubMenuModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *name;
@property (nonatomic, strong)NSArray<Optional,NavTitleModel> *submenus;

@end

@interface NavTitleModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *url;
@property (nonatomic, copy)NSString<Optional> *god_topic_type;
@property (nonatomic, copy)NSString<Optional> *type;

@property (nonatomic, copy)NSString<Optional> *entrytype;
@property (nonatomic, copy)NSString<Optional> *name;

@end

@interface DefaultMenuModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *offline_day_3;
@property (nonatomic, copy)NSString<Optional> *initial;
@property (nonatomic, copy)NSString<Optional> *offline_day_7;

@end























