//
//  GOGuideViewController.h
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
#import "QDBaseScrollPullTableViewController.h"

@interface GOGuideViewController : QDBaseScrollPullTableViewController<DropDownChooseDelegate,DropDownChooseDataSource>

@end
