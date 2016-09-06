//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceVideoCell.h"
#import "EssenceModel.h"

@interface EssenceVideoCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (weak, nonatomic) IBOutlet UIButton *videoPlayBtn;

@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *loveBtn;

@property (weak, nonatomic) IBOutlet UIButton *hateBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation EssenceVideoCell

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
    
    //视频图片
    NSString *picName = [model.video.thumbnail_small firstObject];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:picName]];
    
    //播放次数
    self.playNumLabel.text = [NSString stringWithFormat:@"%ld播放", model.video.playcount];
    
    //播放时长
    NSMutableString *timeStr = [NSMutableString string];
    NSInteger duration = model.video.duration;
    //小时
    if (duration > 3600) {
        [timeStr appendFormat:@"%02ld:", duration/3600];
        duration = duration % 3600;
    }
    //分钟
    if (duration > 60) {
        [timeStr appendFormat:@"%02ld:", duration/60];
        duration = duration % 60;
    }
    //秒
    [timeStr appendFormat:@"%02ld", duration];
    self.playTimeLabel.text = timeStr;
    
    //热评
    NSString *commentStr = [NSString stringWithFormat:@"%@:%@", model.top_comment.u.name, model.top_comment.content];
    self.commentLabel.text = commentStr;
    
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
    
}

- (IBAction)favoriteAction:(id)sender {
}

- (IBAction)videoPlayAction:(id)sender {
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
