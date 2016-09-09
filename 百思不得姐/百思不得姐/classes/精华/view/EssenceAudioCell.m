//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by qianfeng on 16/9/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EssenceAudioCell.h"
#import "EssenceModel.h"

@interface EssenceAudioCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *audioImageView;

@property (weak, nonatomic) IBOutlet UIButton *audioPlayBtn;

@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *loveBtn;

@property (weak, nonatomic) IBOutlet UIButton *hateBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

//图片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *audioImageHeightCon;

@end

@implementation EssenceAudioCell

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
    NSString *picName = [model.audio.thumbnail_small firstObject];
    [self.audioImageView sd_setImageWithURL:[NSURL URLWithString:picName]];
    
    //修改高度
    self.audioImageHeightCon.constant = self.audioImageView.frame.size.width*model.audio.height/model.audio.width;
    
    //播放次数
    self.playNumLabel.text = [NSString stringWithFormat:@"%ld播放", model.audio.playcount];
    
    //播放时长
    NSMutableString *timeStr = [NSMutableString string];
    NSInteger duration = model.audio.duration;
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
    
    //设置高度
    model.cellHeight = @((CGFloat)CGRectGetMaxY(self.commentBtn.frame)+10);//加@就会转换成对象
    
}

- (IBAction)favoriteAction:(id)sender {
}

- (IBAction)audioPlayAction:(id)sender {
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
