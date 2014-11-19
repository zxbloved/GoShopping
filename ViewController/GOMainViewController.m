//
//  GOMainViewController.m
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import "GOMainViewController.h"
#import "GOGuideViewController.h"
#import "GOFindViewController.h"
#import "GoMineViewController.h"


@interface GOMainViewController ()

@end

@implementation GOMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViewControllers];
}

#pragma mark 加载对话框
-(void)initViewControllers{
    NSString * firstString = NSLocalizedString(@"主页", @"");
    NSString * secString = NSLocalizedString(@"发现", @"");
    NSString * threeString = NSLocalizedString(@"我", @"");
    
    //第一个页面
    self.firstView = [[GOGuideViewController alloc]init];
    self.navFirstController = [[UINavigationController alloc] initWithRootViewController:self.firstView];
    self.firstView.title = firstString;
    UITabBarItem *itemBar = [[UITabBarItem alloc]initWithTitle:firstString image:[UIImage imageNamed:@"TabBar_1"] selectedImage:[UIImage imageNamed:@"TabBar_1d"]];
    
    self.firstView.tabBarItem=itemBar;
    //第2个页面
    self.secondView = [[GOFindViewController alloc]init];
    self.navSecondController = [[UINavigationController alloc] initWithRootViewController:self.secondView];
    self.secondView.title = secString;
    UITabBarItem *itemBar2 = [[UITabBarItem alloc]initWithTitle:secString image:[UIImage imageNamed:@"TabBar_Stock"] selectedImage:[UIImage imageNamed:@"TabBar_Stockd"]];
    self.secondView.tabBarItem = itemBar2;
    
    //第3个页面
    self.threeView = [[GoMineViewController alloc]init];
    self.navThreeController = [[UINavigationController alloc] initWithRootViewController:self.threeView];
    self.threeView.title = threeString;
    UITabBarItem *itemBar3 = [[UITabBarItem alloc]initWithTitle:threeString image:[UIImage imageNamed:@"TabBar_Me"] selectedImage:[UIImage imageNamed:@"TabBar_Med"]];
    self.threeView.tabBarItem = itemBar3;

  
    //把上面的对话框都作为一个集体放置到tabbar中，通过tabbar的选项来切换页面
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.navFirstController,self.navSecondController,self.navThreeController, nil];
    [self.view addSubview:self.tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
