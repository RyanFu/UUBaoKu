//
//  UULimitedtimeTableViewCell.h
//  UUBaoKu
//
//  Created by admin on 16/10/21.
//  Copyright © 2016年 loongcrown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UULimitedtimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *earncoins;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
