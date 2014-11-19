//
//  QDBaseScrollPullTableViewController.m
//  IQDII
//
//  Created by hydra on 14-3-12.
//  Copyright (c) 2014年 konson. All rights reserved.
//

#import "QDBaseScrollPullTableViewController.h"

@interface QDBaseScrollPullTableViewController ()

@end

@implementation QDBaseScrollPullTableViewController
@synthesize tableView=_tableView;
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
//	[QDTool adjustIOS7NavigationController:(UIViewController*)self];
    
//    CGRect rect=self.view.bounds;
    self.tableView=[[QDLocalNewsListTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.scrollsToTop=YES;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.separatorColor=QDCOLOR_SKINBLACK;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.tableView.pullUpView.delegate = self;
    self.tableView.pullDownView.delegate = self;
//    if([QDTool versionValue]>=7.0)
    {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
//    if([QDTool versionValue]<7.0)
    {
//        self.tableView.backgroundColor=[UIColor whiteColor];
    }
    [self changeDetailColor];
    //主题改变
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetSkinColor) name:NNKEY_CHANGESKIPCOLOR object:nil];
}

-(void)layoutSubViews{
    
//    [super layoutSubViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ScrollViewPullDelegate

- (BOOL) canPullDown{
//    if(![QDTool isLinkedNetWork])                ///只有在网络可以连接的时候才刷新
    {
//        return NO;
    }
	return YES;
}

- (NSString*) tipWillPullDown{
	return NSLocalizedString(@"下拉即可更新...", @"");
}

- (NSString*) tipPullingDown{
	return NSLocalizedString(@"松开即可更新...", @"");
}

- (NSString*) tipPulledDown{
	return NSLocalizedString(@"加载中...", @"");
}

- (BOOL) canPullUp{
	
//    if(![QDTool isLinkedNetWork])   ///无网络连接的时候无法上拉
//    {
//        return NO;
//    }
//    
//    [self.tableView layoutPullViews];
	return YES;
}

- (NSString*) tipWillPullUp{
	return NSLocalizedString(@"上拉加载更多...", @"");
}

- (NSString*) tipPullingUp{
	return NSLocalizedString(@"松开加载更多...", @"");
}

- (NSString*) tipPulledUp{
	return NSLocalizedString(@"加载中...", @"");
}

- (void) stopRefreshPullUp{
	
	self.tableView.isRefreshingPullUp = NO;
	[self.tableView.pullUpView scrollViewDidFinishLoading:self.tableView];
    
    [self.tableView layoutPullViews];
}

- (void) stopRefreshPullDown{
	
	self.tableView.isRefreshingPullDown = NO;
	[self.tableView.pullDownView scrollViewDidFinishLoading:self.tableView];
    
    
}

- (void) startRefreshPullUp{
	
	self.tableView.isRefreshingPullUp = YES;
    
}

- (void) startRefreshPullDown{
	
	self.tableView.isRefreshingPullDown = YES;
}

- (BOOL) isRefreshingPullUp{
	return self.tableView.isRefreshingPullUp;
}

- (BOOL) isRefreshingPullDown{
	return self.tableView.isRefreshingPullDown;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

	if (scrollView != self.tableView) {
		return;
	}
	
	if (fabs(scrollView.contentOffset.y) < 0.0001) {
		return;
	}
	
    
    
	BOOL isDown = scrollView.contentOffset.y < 0 ? YES : NO;
    
	if (isDown) {                                                                       ///webview最顶端被拉下来的时候contentOffset.y才会小于0
		if (!self.tableView.isRefreshingPullUp && [self.tableView.pullDownView.delegate canPullDown]) {
			self.tableView.pullDownView.hidden = NO;
			[self.tableView.pullDownView scrollViewDidScroll:scrollView];
		}
		else {
			self.tableView.pullDownView.hidden = YES;
		}
	}
	else {
		if (!self.tableView.isRefreshingPullDown && [self.tableView.pullUpView.delegate canPullUp]) {
			self.tableView.pullUpView.hidden = NO;
			[self.tableView.pullUpView scrollViewDidScroll:scrollView];
		}
		else {
			self.tableView.pullUpView.hidden = YES;
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView != self.tableView) {
		return;
	}
	
	if (fabs(scrollView.contentOffset.y) < 0.0001) {
		return;
	}
	
	BOOL isDown = scrollView.contentOffset.y < 0 ? YES : NO;                            ///webview最顶端被拉下来的时候contentOffset.y才会小于0
	
	if (isDown) {
		if (!self.tableView.isRefreshingPullUp && [self.tableView.pullDownView.delegate canPullDown]) {
			self.tableView.pullDownView.hidden = NO;
			[self.tableView.pullDownView scrollViewDidEndDragging:scrollView];
		}
		else {
			self.tableView.pullDownView.hidden = YES;
		}
	}
	else {
		if (!self.tableView.isRefreshingPullDown && [self.tableView.pullUpView.delegate canPullUp]) {
			self.tableView.pullUpView.hidden = NO;
			[self.tableView.pullUpView scrollViewDidEndDragging:scrollView];
		}
		else {
			self.tableView.pullUpView.hidden = YES;
		}
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsListCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    return cell;
}


-(void)changeDetailColor
{
    
    self.tableView.backgroundColor = [UIColor clearColor];//[QDTool getColorWithKey:QDCOLOR_ZIXUN_TABLEVIEW_BACKGROUND];
    
    self.tableView.pullDownView.label1.textColor=[UIColor clearColor];//[QDTool getColorWithKey:QDCOLOR_PULLDOWNVIEW_LABEL];
    self.tableView.pullDownView.vActivity.color=[UIColor blackColor];//[QDTool getColorWithKey:QDCOLOR_PULLDOWNVIEW_ACTIVITYINDICATORVIEW];
    self.tableView.pullDownView.backgroundColor = [UIColor blackColor];//QDTool getColorWithKey:QDCOLOR_THEME];
    [self.tableView.pullDownView resetScrollViewLabelDetails];
    
    self.tableView.pullUpView.label1.textColor=[UIColor blackColor];//[QDTool getColorWithKey:QDCOLOR_PULLUPVIEW_LABEL];
    self.tableView.pullUpView.vActivity.color=[UIColor blackColor];//[QDTool getColorWithKey:QDCOLOR_PULLUPVIEW_ACTIVITYINDICATORVIEW];
    self.tableView.pullUpView.backgroundColor=[UIColor blackColor];//[QDTool getColorWithKey:QDCOLOR_GEGU_TABLEVIEW_BACKGROUND];
    [self.tableView.pullDownView resetScrollViewLabelDetails];
    
}



@end
