//
//  UUReplyCell.h
//  UUBaoKu
//
//  Created by dev2 on 2017/5/24.
//  Copyright © 2017年 loongcrown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUReplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;
@property (nonatomic,strong)void(^(setIdea))(NSString *idea);
@end
