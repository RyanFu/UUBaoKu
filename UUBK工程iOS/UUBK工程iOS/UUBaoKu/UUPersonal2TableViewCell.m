//
//  UUPersonal2TableViewCell.m
//  UUBaoKu
//
//  Created by admin on 16/11/12.
//  Copyright © 2016年 loongcrown. All rights reserved.
//

#import "UUPersonal2TableViewCell.h"

@implementation UUPersonal2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"UUPersonal2TableViewCell";
    UUPersonal2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"UUPersonal2TableViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}
@end
