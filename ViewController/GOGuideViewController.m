//
//  GOGuideViewController.m
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import "GOGuideViewController.h"
#import "DropDownListView.h"


@interface GOGuideViewController (){
   
        NSMutableArray *chooseArray ;
}

@end

@implementation GOGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"男人购", @"");
    chooseArray = [NSMutableArray arrayWithArray:@[@[@"评分从高到低",@"评分从低到高",@"信用从高到低"],
                                                   @[@"最新发布"],
                                                   @[@"筛选"],
                                                   @[@"分类"]]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
//    [self.view addSubview:dropDownView];
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%d ,index:%d",section,index);
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
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
