//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceImageCell.h"
#import "EssenceModel.h"

@interface EssenceImageCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *loveBtn;

@property (weak, nonatomic) IBOutlet UIButton *hateBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

//图片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigImageHeightCon;

//评论文字背景视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCon;

//评论top的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCon;

@end

@implementation EssenceImageCell

- (void)setModel:(ListModel *)model{
    
    _model = model;
    
    //图片
    NSString *userImageName = [model.u.header firstObject];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userImageName]];
    self.userImageView.layer.cornerRadius = 15;
    self.userImageView.layer.masksToBounds = YES;
    
    //名字
    self.nameLabel.text = model.u.name;
    
    //时间
    self.descLabel.text = model.passtime;
    
    //文字
    self.contentLabel.text = model.text;
    
    //大图片
    NSString *picName = [model.image.big firstObject];
    self.bigImageView.contentMode = UIViewContentModeTop;
    self.bigImageView.layer.masksToBounds = YES;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:picName]];
    
    //修改高度
    CGFloat h = self.bigImageView.frame.size.width*model.image.height/model.image.width;
    if (h > 500) {
        h = 500;
    }
    self.bigImageHeightCon.constant = h;
    
    //热评
    
    //修改背景视图的显示状态和高度
    if (model.top_comment == nil) {
        
        //隐藏
        self.commentView.hidden = YES;
        
    }else{
        
        //显示(因为cell重用可能隐藏了评论)
        self.commentView.hidden = NO;
        
        NSString *commentStr = [NSString stringWithFormat:@"%@:%@", model.top_comment.u.name, model.top_comment.content];
        self.commentLabel.text = commentStr;
                
    }
    
    //标签
    NSMutableString *tagStr = [NSMutableString string];
    for (TagModel *tag in model.tags) {
        [tagStr appendFormat:@"%@ ", tag.name];
        //有格式控制符要用appendFormat(没有用appendString)
    }
    self.tagLabel.text = tagStr;
    
    //顶一下
    [self.loveBtn setTitle:model.up forState:UIControlStateNormal];
    [self.loveBtn setTitle:model.up forState:UIControlStateSelected];
    
    //踩一下
    [self.hateBtn setTitle:[NSString stringWithFormat:@"%ld", model.down] forState:UIControlStateNormal];
    [self.hateBtn setTitle:[NSString stringWithFormat:@"%ld", model.down] forState:UIControlStateSelected];
    
    //分享
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld", model.forward] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld", model.forward] forState:UIControlStateSelected];
    
    //评论
    [self.commentBtn setTitle:model.comment forState:UIControlStateNormal];
    [self.commentBtn setTitle:model.comment forState:UIControlStateSelected];
    
    //强制刷新cell,也就是按照数据全部显示一次cell
    [self layoutIfNeeded];
    
    //修改背景视图的显示状态和高度
    if (model.top_comment == nil) {
        
        //隐藏
        self.commentViewHCon.constant = 0;
        self.commentViewYCon.constant = 0;
        
    }else{
        
        //修改高度
        self.commentViewHCon.constant = self.commentLabel.height + 4*2;
        self.commentViewYCon.constant = 14;
        
    }
    
    [self layoutIfNeeded];
    
    //设置高度
    model.cellHeight = @((CGFloat)CGRectGetMaxY(self.commentBtn.frame)+10);//加@就会转换成对象
    
}

- (IBAction)favoriteAction:(id)sender {
}

- (IBAction)loveAction:(id)sender {
}

- (IBAction)hateAction:(id)sender {
}

- (IBAction)shareAction:(id)sender {
}

- (IBAction)commentAction:(id)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
