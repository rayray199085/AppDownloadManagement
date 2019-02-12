//
//  SCTableViewController.m
//  AppDownloadManagement
//
//  Created by Stephen Cao on 12/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCTableViewController.h"
#import "SCAppItem.h"
#import "SCTableViewCell.h"
@interface SCTableViewController ()<UITabBarDelegate,UITableViewDataSource,SCTableViewCellDelegate>
@property(nonatomic,strong)NSArray *appList;
@end

@implementation SCTableViewController
- (NSArray *)appList{
    if(_appList == nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"apps_full.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempList = [NSMutableArray arrayWithCapacity:array.count];
        for(NSDictionary *dict in array){
            SCAppItem *item = [SCAppItem appItemWithDictionary:dict];
            [tempList addObject:item];
        }
        _appList = tempList;
    }
    return _appList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 60;
}
#pragma mark - hide status bar
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCAppItem *item = self.appList[indexPath.row];
    SCTableViewCell *cell = [SCTableViewCell tableViewCellWithTableView:tableView];
    cell.delegate = self;
    cell.item = item;
    return cell;
}
- (void)displayDialogForDownlading:(SCTableViewCell *)cell{
    UILabel *notification = [[UILabel alloc]init];
    notification.text = @"Downloading...";
    notification.textColor = [UIColor redColor];
    notification.backgroundColor = [UIColor grayColor];
    notification.alpha = 0.0;
    notification.frame = CGRectMake((self.view.frame.size.width - 200)/2,(self.view.frame.size.height - 30)/2, 200, 30);
    notification.layer.cornerRadius = 5;
    notification.textAlignment = NSTextAlignmentCenter;
    notification.layer.masksToBounds = YES;
//    [self.view addSubview:notification]; this method would add subViews to the tableView
    [[[UIApplication sharedApplication]keyWindow] addSubview:notification];
    [UIView animateWithDuration:1 animations:^{
        notification.alpha = 0.6;
    } completion:^(BOOL finished) {
        if(finished){
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                notification.alpha = 0.0;
            } completion:^(BOOL finished) {
                if(finished){
                    [notification removeFromSuperview];
                }
            }];
        }
    }];
}
@end
