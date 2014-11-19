//
//  WareTableViewCell.m
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import "WareTableViewCell.h"

@implementation WareTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
