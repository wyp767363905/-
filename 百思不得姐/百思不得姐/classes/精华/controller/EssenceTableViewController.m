//
//  EssenceTableViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceTableViewController.h"
#import "EssenceModel.h"
#import "EssenceVideoCell.h"
#import "EssenceTextCell.h"

@interface EssenceTableViewController ()<UITableViewDelegate,UITableViewDataSource>

//分页
@property (nonatomic, assign)NSInteger lastTime;

//表格
@property (nonatomic, strong)UITableView *tbView;

//数据
@property (nonatomic, strong)EssenceModel *dataModel;

@end

@implementation EssenceTableViewController

/** 创建表格*/
- (void)createTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tbView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    //去掉分割线
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tbView];
    
    //约束
    __weak typeof(self) weakSelf = self;
    [self.tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    //下拉刷新和上拉加载更多
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}

//下拉刷新,只显示最新的第一页数据
- (void)loadFirstPage{
    self.lastTime = 0;
    
    [self downloadData];
}

//下拉加载更多,显示下一页数据
- (void)loadMore{
    self.lastTime = self.dataModel.info.np;
    
    [self downloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建表格
    [self createTableView];
    
    //下载数据
    [self downloadData];
    
}

//下载数据
- (void)downloadData{
    
    NSMutableString *urlString = [NSMutableString stringWithString:self.urlPrefix];
    [urlString appendFormat:kEssenceSuffixUrl, self.lastTime];
        
    __weak typeof(self) weakSelf = self;
    [BDJDownloader downloadWithUrlString:urlString finish:^(NSData *data) {
        
        NSError *error = nil;
        EssenceModel *model = [[EssenceModel alloc] initWithData:data error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (self.lastTime == 0) {
            //上拉刷新
            weakSelf.dataModel = model;
        }else{
            //下拉加载
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, weakSelf.dataModel.list.count)];
            [model.list insertObjects:weakSelf.dataModel.list atIndexes:indexSet];
            weakSelf.dataModel = model;
        }
        
        weakSelf.dataModel = model;
        //刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
            //结束刷新
            [weakSelf.tbView.mj_footer endRefreshing];
            [weakSelf.tbView.mj_header endRefreshing];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.list.count;
}

/** 视频的cell*/
- (UITableViewCell *)createVidelCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"videoCellId";
    EssenceVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceVideoCell" owner:nil options:nil] lastObject];
    }
    
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

/** 图片的cell*/
- (UITableViewCell *)createImageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

/** 声音的cell*/
- (UITableViewCell *)createAudioCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

/** 文字的cell*/
- (UITableViewCell *)createTextCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"textCellId";
    
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceTextCell" owner:nil options:nil] lastObject];
    }
    
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
}

/** gif的cell*/
- (UITableViewCell *)createGifCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

/** html的cell*/
- (UITableViewCell *)createHtmlCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    ListModel *model = self.dataModel.list[indexPath.row];
    
    if ([model.type isEqualToString:@"video"]) {
        //视频的cell
        cell = [self createVidelCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"image"]) {
        //图片的cell
        cell = [self createImageCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"text"]) {
        //文本的cell
        cell = [self createTextCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"audio"]) {
        //声音的cell
        cell = [self createAudioCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"gif"]) {
        //gif的cell
        cell = [self createGifCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"html"]) {
        //html的cell
        cell = [self createHtmlCellForTableView:tableView atIndexPath:indexPath];
    }else{
        cell = [[UITableViewCell alloc] init];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.dataModel.list[indexPath.row];
    return model.cellHeight.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 600;
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













