//
//  QDScrollViewPullView.h
//  IQDII
//
//  Created by administrator on 13-5-14.
//  Copyright (c) 2013年 konson. All rights reserved.
//

#import <UIKit/UIKit.h>

/** protocol of ScrollViewPullDelegate */
@protocol ScrollViewPullDelegate<NSObject>

/** @name canPull */
// @{
- (BOOL) canPullDown;
- (BOOL) canPullUp;
// @}

/** @name tipPull */
// @{
- (NSString*) tipWillPullDown;
- (NSString*) tipPullingDown;
- (NSString*) tipPulledDown;

- (NSString*) tipWillPullUp;
- (NSString*) tipPullingUp;
- (NSString*) tipPulledUp;
// @}

/** @name refreshPull */
// @{
- (void) startRefreshPullUp;
- (void) startRefreshPullDown;

- (void) stopRefreshPullUp;
- (void) stopRefreshPullDown;

- (BOOL) isRefreshingPullUp;
- (BOOL) isRefreshingPullDown;
// @}

@end

/** 正常的检测pull高度 */
//#define ScrollPullHeightNormal  100.0f

/** 较小的检测pull高度, 适用于小窗口 */
#define ScrollPullHeightSmall  60.0f


/** pullView状态 */
typedef enum tagQDEmPullState{
	
	QDstate_willPull,	///< 准备pull
	QDstate_pulling,	///< 正在pull
	QDstate_pulled,	///< 完成pull
	
} emQDPullState;


/** 向上/下pullView */
@interface ScrollViewPullView : UIView {
	
	BOOL _forPullUp;		///< 标示向上/向下pullView
	
	id<ScrollViewPullDelegate> __weak _delegate;
	
	emQDPullState _state;		///< 状态
	
	UILabel *_label1;		///< 标题
	UILabel *_label2;		///< 描述
	CALayer *_imgArrow;		///< 箭头
	UIActivityIndicatorView *_vActivity;	///< ActivityIndi
	
	CGFloat _pullHeight;
}

//@property (nonatomic, assign) id<TableViewPullDelegate> delegate;
@property (nonatomic) CGFloat pullHeight;	///< 检测pull高度
@property (nonatomic, weak) id<ScrollViewPullDelegate> delegate;
@property (nonatomic,strong) UIActivityIndicatorView *vActivity;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
- (id) initWithFrame:(CGRect)frame forPullUp:(BOOL)p delegate:(id<ScrollViewPullDelegate>) del;


- (void) scrollViewDidScroll:(UIScrollView*)scrollView;
- (void) scrollViewDidEndDragging:(UIScrollView*)scrollView;
- (void) scrollViewDidFinishLoading:(UIScrollView*)scrollView;

//按照股票或市场修改下拉刷新标签的字体位置等属性
-(void)resetScrollViewLabelDetails;

@end
