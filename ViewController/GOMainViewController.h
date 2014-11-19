//
//  GOMainViewController.h
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GOGuideViewController;
@class GOFindViewController;
@class GoMineViewController;

@interface GOMainViewController : UIViewController

@property (strong, retain) UITabBarController       *tabBarController;
@property (strong, retain) UINavigationController   *navFirstController;
@property (strong, retain) UINavigationController   *navSecondController;
@property (strong, retain) UINavigationController   *navThreeController;

@property (strong, nonatomic) GOGuideViewController     *firstView;
@property (strong, nonatomic) GOFindViewController   *secondView;
@property (strong, nonatomic) GoMineViewController     *threeView;

@property (strong, nonatomic) UINavigationController *curNavi;


@end
