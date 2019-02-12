//
//  SCTableViewCell.h
//  AppDownloadManagement
//
//  Created by Stephen Cao on 12/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppItem.h"
@class SCTableViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol SCTableViewCellDelegate <NSObject>
-(void)displayDialogForDownlading:(SCTableViewCell *)cell;
@end
@interface SCTableViewCell : UITableViewCell
@property(nonatomic,assign)SCAppItem *item;
@property(nonatomic,weak)id<SCTableViewCellDelegate> delegate;
+(instancetype)tableViewCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
