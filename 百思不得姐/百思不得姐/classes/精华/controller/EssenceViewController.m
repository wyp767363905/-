//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceModel.h"
#import "EssenceVideoCell.h"

@interface EssenceViewController ()<UITableViewDelegate,UITableViewDataSource>

//分页
@property (nonatomic, assign)NSInteger lastTime;

//表格
@property (nonatomic, strong)UITableView *tbView;

//数据
@property (nonatomic, strong)EssenceModel *dataModel;

@end

@implementation EssenceViewController

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
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
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
    
    NSString *urlString = [NSString stringWithFormat:kEssenceRecommendUrl, self.lastTime];
    
    __weak typeof(self) weakSelf = self;
    [BDJDownloader downloadWithUrlString:urlString finish:^(NSData *data) {
        
        NSError *error = nil;
        EssenceModel *model = [[EssenceModel alloc] initWithData:data error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        
        weakSelf.dataModel = model;
        //刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"videoCellId";
    EssenceVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceVideoCell" owner:nil options:nil] lastObject];
    }
    
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
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




















