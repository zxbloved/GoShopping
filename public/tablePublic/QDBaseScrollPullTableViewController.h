//
//  QDBaseScrollPullTableViewController.h
//  IQDII
//
//  Created by hydra on 14-3-12.
//  Copyright (c) 2014年 konson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDLocalNewsListTableView.h"

@interface QDBaseScrollPullTableViewController : UIViewController<ScrollViewPullDelegate,UITableViewDataSource,UITableViewDelegate>{
    QDLocalNewsListTableView *_tableView;
    
}
@property (nonatomic,strong)QDLocalNewsListTableView *tableView;

-(void)changeDetailColor;
@end
