//
//  QDScrollViewPullView.m
//  IQDII
//
//  Created by administrator on 13-5-14.
//  Copyright (c) 2013年 konson. All rights reserved.
//

#import "QDScrollViewPullView.h"
#import <QuartzCore/QuartzCore.h>

#define SCROLLVIEWPULLVIEW_HEIGHT		self.pullHeight//100.0f
//#define SCROLLVIEWPULLVIEW_TEXT_COLOR	 g_user.uiStyle.clrWhiteText//[UIColor lightTextColor]//colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define SCROLLVIEWPULLVIEW_FLIP_ANIMATION_DURATION 0.18f


@implementation ScrollViewPullView
@synthesize delegate = _delegate;
@synthesize pullHeight = _pullHeight;
@synthesize label1=_label1;
@synthesize label2=_label2;
- (void) updatePullText:(emQDPullState)a{
	
	NSString *tip = @"";
	
	switch (a) {
		case QDstate_willPull:
		{
			tip = _forPullUp ? [_delegate tipWillPullUp] : [_delegate tipWillPullDown];
		}
			break;
		case QDstate_pulling:
		{
			tip = _forPullUp ? [_delegate tipPullingUp] : [_delegate tipPullingDown];
		}
			break;
		case QDstate_pulled:
		{
			tip = _forPullUp ? [_delegate tipPulledUp] : [_delegate tipPulledDown];
		}
			break;
		default:
			break;
	}
	
	NSString *s1 = @"";
	NSString *s2 = @"";
	NSInteger pos = [tip rangeOfString:@"\n"].location;
	if (pos != NSNotFound) {
		s1 = [tip substringToIndex:pos];
		s2 = [tip substringFromIndex:pos];
	}
	else {
		s1 = tip;
	}
	
//    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!%@", tip);
	_label1.text = s1;
	_label2.text = s2;
	
}

- (void) setPullState:(emQDPullState)a{
	
	switch (a) {
		case QDstate_willPull:
		{
			if (_state == QDstate_pulling) {
				
				[CATransaction begin];
				[CATransaction setAnimationDuration:SCROLLVIEWPULLVIEW_FLIP_ANIMATION_DURATION];
				if (_forPullUp) {
					_imgArrow.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f) ;
				}
				else {
					_imgArrow.transform = CATransform3DIdentity;
				}
                [CATransaction commit];
			}
			
			//[self updatePullText:a];
			
			[_vActivity stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_imgArrow.hidden = NO;
			if (_forPullUp) {
				_imgArrow.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			}
			else {
				_imgArrow.transform = CATransform3DIdentity;
			}
			[CATransaction commit];
		}
			break;
		case QDstate_pulling:
		{
			//[self updatePullText:a];
			
			[CATransaction begin];
			[CATransaction setAnimationDuration:SCROLLVIEWPULLVIEW_FLIP_ANIMATION_DURATION];
			if (!_forPullUp) {
				_imgArrow.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);                                                    ///箭头图形变回向上
			}
			else {
				_imgArrow.transform = CATransform3DIdentity;     ///箭头图形原来是向上的的，pulling的话则将图片沿X轴旋转180度
			}
			[CATransaction commit];
		}
			break;
		case QDstate_pulled:
		{
			//[self updatePullText:a];
			
			[_vActivity startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_imgArrow.hidden = YES;
			[CATransaction commit];
		}
			break;
		default:
			break;
	}
	_state = a;
}

- (id) initWithFrame:(CGRect)frame forPullUp:(BOOL)p delegate:(id<ScrollViewPullDelegate>) del{
	
	if (self = [super initWithFrame:frame]) {
		
		self.pullHeight = ScrollPullHeightSmall;
		
		_delegate = del;
		
		self.hidden = YES;
		
		_forPullUp = p;
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
// 修改人：Hydra 修改日期：2014/03/12
//		self.backgroundColor = [UIColor colorWithRed:32/255.0 green:37/255.0 blue:45/255.0 alpha:1];
//        if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//        {
//            self.backgroundColor=QDCOLOR_SKINBLACK;
//            
//        }
//        else
//        {
//            self.backgroundColor=QDCOLOR_SKINBLUE;
//        }
        
// 修改结束
		UIView *backV = [[UIView alloc] initWithFrame:_forPullUp ? CGRectMake(0.0f, 0, CGRectGetWidth(self.frame), 65) : CGRectMake(0.0f, CGRectGetHeight(self.frame)-65, CGRectGetWidth(self.frame), 65)];
		backV.backgroundColor = [UIColor clearColor];          //////////////////////////////////////////////
		backV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self addSubview:backV];
		
		UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(backV.frame)-30.0F, CGRectGetWidth(self.frame), 20.0f)];
		lab.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		lab.font = [UIFont systemFontOfSize:18.0f];
		lab.textColor = [UIColor whiteColor];
		lab.shadowColor = [UIColor colorWithWhite:0.9 alpha:1];
		lab.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lab.backgroundColor = [UIColor clearColor];
		lab.textAlignment = UITextAlignmentCenter;
		[backV addSubview:lab];
		_label2 = lab;
		//[lab release];

// 修改人：Hydra 修改日期：2014/03/12
//		lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(backV.frame)-48.0f, CGRectGetWidth(self.frame), 20.0f)];
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, (65-18)/2, CGRectGetWidth(self.frame), 18.0f)];
		lab.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        

//		lab.font = [UIFont systemFontOfSize:20.0];
        lab.font = [UIFont systemFontOfSize:14.0f];
//		lab.textColor = [QDTool getColorWithKey:QDCOLOR_PULLVIEW_LABEL];
//		lab.shadowColor = [UIColor colorWithWhite:0.9 alpha:1];
//		lab.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lab.backgroundColor = [UIColor clearColor];
		lab.textAlignment = UITextAlignmentCenter;
		[backV addSubview:lab];
		_label1 = lab;
// 修改结束
		//[lab release];
		
		CALayer *layer = [[CALayer alloc] init];
        
// 修改人：Hydra 修改日期：2014/03/12
//		layer.frame = CGRectMake(15.0f, 0, 30.0f, 55.0f);
        layer.frame=CGRectMake(40.0f, (65-18)/2, 11.0f, 18.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
        

//		layer.contents = (id)[UIImage imageNamed:@"whitearrow.png"].CGImage;
//        if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
        {
            layer.contents=(id)[UIImage imageNamed:@"RefreshArrow@2x.png"].CGImage;
            
        }
//        else
        {
//            layer.contents=(id)[UIImage imageNamed:@"t1_RefreshArrow@2x.png"].CGImage;
        }
// 修改结束
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		[[backV layer] addSublayer:layer];
		_imgArrow = layer;
		//[layer release];
		
		UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		v.frame = CGRectMake(35.0f, CGRectGetHeight(backV.frame)-38.0f-5.0f, 20.0f, 20.0f);
		[backV addSubview:v];
		_vActivity = v;
		//[v release];
		
		[self setPullState:QDstate_willPull];
	}
	
	return self;
}

- (id) initWithFrame:(CGRect)frame{
	
	self = [self initWithFrame:frame forPullUp:YES delegate:nil];
	
	return self;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
	
	if (_forPullUp) {
		
		if (_state == QDstate_pulled) {
			
			CGFloat offset = MAX(scrollView.contentOffset.y, 0);
			offset = MIN(offset, SCROLLVIEWPULLVIEW_HEIGHT);
			scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, offset, 0.0f);
			
		}
		else if (scrollView.isDragging) {
			
			BOOL _loading = NO;
			if ([_delegate respondsToSelector:@selector(isRefreshingPullUp)]) {
				_loading = [_delegate isRefreshingPullUp];
			}
			
			if (_state == QDstate_pulling && scrollView.contentOffset.y + (scrollView.frame.size.height) < scrollView.contentSize.height + SCROLLVIEWPULLVIEW_HEIGHT && scrollView.contentOffset.y > 0.0f && !_loading) {
                
				[self setPullState:QDstate_willPull];
			} else if (_state == QDstate_willPull && scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + SCROLLVIEWPULLVIEW_HEIGHT  && !_loading) {
				[self setPullState:QDstate_pulling];
			}
			
			
			if (scrollView.contentInset.bottom != 0) {
				scrollView.contentInset = UIEdgeInsetsZero;
			}
            //NSLog(@"self.view.frame.height=%f",self.frame.origin.y);
		}
	}
	else {
		//NSLog(@"%f", scrollView.contentOffset.y);
		if (_state == QDstate_pulled) {
			
			CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
			offset = MIN(offset, SCROLLVIEWPULLVIEW_HEIGHT);
			scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
			
		}
		else if (scrollView.isDragging) {                                                                               ///手指还在拖动的情况下
			
			BOOL _loading = NO;
			if ([_delegate respondsToSelector:@selector(isRefreshingPullDown)]) {
				_loading = [_delegate isRefreshingPullDown];                                                            ///判断是否在向下刷新中
			}
			
			if (_state == QDstate_pulling && scrollView.contentOffset.y > -SCROLLVIEWPULLVIEW_HEIGHT && scrollView.contentOffset.y < 0.0f && !_loading) {     ///即拖动时尽管超过了100，但没有放开手指，拖动距离再变回少于100的时候，当前状态转为state_willPull
				[self setPullState:QDstate_willPull];
			} else if (_state == QDstate_willPull && scrollView.contentOffset.y < -SCROLLVIEWPULLVIEW_HEIGHT  && !_loading) {             ///状态为准备pull且拖动的的幅度即contentOffset.y大于100且不在请求数据中，当前状态转化为state_pulling
				[self setPullState:QDstate_pulling];
			}
			
			if (scrollView.contentInset.top != 0) {
				scrollView.contentInset = UIEdgeInsetsZero;
			}
		}
	}
	
	[self updatePullText:_state];
	
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView{
	
	if (_forPullUp) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(isRefreshingPullUp)]) {
			_loading = [_delegate isRefreshingPullUp];
		}
		
		if (scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + SCROLLVIEWPULLVIEW_HEIGHT && !_loading) {
			
			if ([_delegate respondsToSelector:@selector(startRefreshPullUp)]) {
				[_delegate startRefreshPullUp];
			}
			
			[self setPullState:QDstate_pulled];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.2];
			scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, SCROLLVIEWPULLVIEW_HEIGHT, 0.0f);
			[UIView commitAnimations];
			
		}
	}
	else {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(isRefreshingPullDown)]) {
			_loading = [_delegate isRefreshingPullDown];
		}
		
		if (scrollView.contentOffset.y < -SCROLLVIEWPULLVIEW_HEIGHT && !_loading) {
			
			if ([_delegate respondsToSelector:@selector(startRefreshPullDown)]) {
				[_delegate startRefreshPullDown];
			}
			
			[self setPullState:QDstate_pulled];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.2];
			scrollView.contentInset = UIEdgeInsetsMake(SCROLLVIEWPULLVIEW_HEIGHT, 0.0f, 0.0f, 0.0f);
			[UIView commitAnimations];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"afterNow" object:nil];
		}
	}
	
	[self updatePullText:_state];
}

- (void) scrollViewDidFinishLoading:(UIScrollView *)scrollView{
    
	
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
    //self.hidden = YES;
	[self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:.4];
	
	[self setPullState:QDstate_willPull];
	
	[self updatePullText:_state];
}

#pragma mark -
#pragma mark 修改下拉刷新标签的字体位置等属性
-(void)resetScrollViewLabelDetails
{
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
    {
        _imgArrow.contents=(id)[UIImage imageNamed:@"RefreshArrow@2x.png"].CGImage;
        
    }
//    else
    {
//        _imgArrow.contents=(id)[UIImage imageNamed:@"t1_RefreshArrow@2x.png"].CGImage;
    }
}
@end
