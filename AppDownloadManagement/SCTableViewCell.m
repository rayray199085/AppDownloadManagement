//
//  SCTableViewCell.m
//  AppDownloadManagement
//
//  Created by Stephen Cao on 12/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCTableViewCell.h"
@interface SCTableViewCell()
@property(nonatomic,weak)UIImageView *iconView;
@property(nonatomic,weak)UILabel *appName;
@property(nonatomic,weak)UILabel *detailInfo;
@property(nonatomic,weak)UIButton *download;
@end
@implementation SCTableViewCell

- (void)didAddSubview:(UIView *)subview{
    CGFloat margin = 5;
    CGFloat imageW = 40;
    CGFloat imageY = (self.contentView.frame.size.height - imageW)/2;
    self.iconView.frame = CGRectMake(margin, imageY, imageW, imageW);
    CGFloat nameW = 200;
    CGFloat nameH = 25;
    self.appName.frame = CGRectMake(CGRectGetMaxY(self.iconView.frame) + margin, imageY, nameW, nameH);
    CGFloat infoW = 200;
    CGFloat infoH = 20;
    self.detailInfo.frame = CGRectMake(CGRectGetMaxY(self.iconView.frame) + margin, CGRectGetMaxY(self.appName.frame) + margin, infoW, infoH);
    CGFloat downloadH = 30;
    CGFloat downloadY = (self.contentView.frame.size.height - downloadH) / 2;
    CGFloat downloadW = 50;
    
    self.download.frame =  CGRectMake(self.contentView.frame.size.width - 2 * margin - downloadW, downloadY, downloadW, downloadH);
}

- (void)setItem:(SCAppItem *)item{
    _item = item;
    self.iconView.image = [UIImage imageNamed:item.icon];
    
    self.appName.text = item.name;
    self.detailInfo.text = [NSString stringWithFormat:@"大小：%@ | 下载量：%@",item.size,item.download];
    self.detailInfo.font = [UIFont systemFontOfSize:12];
    self.detailInfo.textColor = [UIColor grayColor];
    [self.download setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
    [self.download setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
    [self.download setTitle:@"下载" forState:UIControlStateNormal];
    [self.download setTitle:@"已下载" forState:UIControlStateDisabled];
    self.download.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.download addTarget:self action:@selector(clickDownloadButton:) forControlEvents:UIControlEventTouchUpInside];
    if(self.item.disable){
        self.download.enabled = NO;
    }else{
        self.download.enabled = YES;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        UILabel *appName = [[UILabel alloc]init];
        [self.contentView addSubview:appName];
        self.appName = appName;
        UILabel *detailInfo = [[UILabel alloc]init];
        [self.contentView addSubview:detailInfo];
        self.detailInfo = detailInfo;
        UIButton *download = [[UIButton alloc]init];
        [self.contentView addSubview:download];
        self.download = download;
    }
    return self;
}
+(instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"app_cell";
    SCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[SCTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)clickDownloadButton:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(displayDialogForDownlading:)]){
        [self.delegate displayDialogForDownlading:self];
        self.download.enabled = NO;
        self.item.disable = YES;
    }
}
@end
