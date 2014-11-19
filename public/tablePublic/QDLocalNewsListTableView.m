//
//  QDLocalNewsListTableView.m
//  IQDII
//
//  Created by tele on 13-10-23.
//  Copyright (c) 2013年 konson. All rights reserved.
//

#import "QDLocalNewsListTableView.h"

@implementation QDLocalNewsListTableView

@synthesize pullUpView = _pullUpView, pullDownView = _pullDownView,
isRefreshingPullDown = _isRefreshingPullDown, isRefreshingPullUp = _isRefreshingPullUp;
//@synthesize scrollDelegate=_scrollDelegate;

- (void) setPullUpHeight:(CGFloat)h{
	
	assert(_pullUpView);
	_pullUpView.pullHeight = h;
}

- (void) setPullDownHeight:(CGFloat)h{
	
	assert(_pullDownView);
	_pullDownView.pullHeight = h;
}

- (void) createPullViews{
	
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
	if (_pullUpView == nil) {
		
		ScrollViewPullView *v = [[ScrollViewPullView alloc] initWithFrame:CGRectMake(0.0f, self.contentSize.height, CGRectGetWidth(self.frame), 1000) forPullUp:YES delegate:nil];
		

//        v.backgroundColor = [QDTool getColorWithKey:QDCOLOR_GEGU_TABLEVIEW_BACKGROUND];
        
		[self addSubview:v];
		_pullUpView = v;

	}
	
	if (_pullDownView == nil) {
		
		ScrollViewPullView *v = [[ScrollViewPullView alloc] initWithFrame:CGRectMake(0.0f, -1000, CGRectGetWidth(self.frame), 1000) forPullUp:NO delegate:nil];
//		 v.backgroundColor=[QDTool getColorWithKey:QDCOLOR_THEME];
		[self addSubview:v];
		_pullDownView = v;
	}
	
	_isRefreshingPullUp = NO;
	_isRefreshingPullDown = NO;
}

- (void) layoutPullViews{               ///让上拉下拉提示的view重新指定位置
    
    _pullUpView.frame = CGRectMake(0.0f, self.contentSize.height, CGRectGetWidth(self.frame), 1000);
    //CGFloat y=self.scrollView.contentSize.height;
	_pullDownView.frame = CGRectMake(0.0f, -1000, CGRectGetWidth(self.frame), 1000);
    
    [self sendSubviewToBack:_pullDownView];
    [self sendSubviewToBack:_pullUpView];
    
}

- (void) layoutSubviews{
    
    [super layoutSubviews];
    
    [self layoutPullViews];
}

-(id)init
{
    if(self=[super init])
    {
        [self createPullViews];

        return self;
    }
    return nil;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self=[super initWithFrame:frame style:style])
    {
        [self createPullViews];
        return self;
    }
    return nil;
}

-(void)reloadData
{
    if(self!=nil)
    {
        [super reloadData];
    }
    else
    {
        NSLog(@"出现nil！！！！！！！！！！！！");
    }
}
@end
