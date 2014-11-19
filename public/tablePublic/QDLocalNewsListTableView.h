//
//  QDLocalNewsListTableView.h
//  IQDII
//
//  Created by tele on 13-10-23.
//  Copyright (c) 2013年 konson. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "QDScrollViewPullView.h"



@interface QDLocalNewsListTableView : UITableView<UIScrollViewDelegate>{
    
        
        ScrollViewPullView *_pullUpView;		///< 向上pull
        ScrollViewPullView *_pullDownView;		///< 向下pull
        
        BOOL _isRefreshingPullUp;		///< 是否正在向上pull
        BOOL _isRefreshingPullDown;		///< 是否正在向下pull
//        id<QDWebViewScrollDeleagte> __weak _scrollDelegate;
    
}

@property (nonatomic, strong) ScrollViewPullView *pullUpView;
@property (nonatomic, strong) ScrollViewPullView *pullDownView;
@property (nonatomic, assign) BOOL isRefreshingPullUp;
@property (nonatomic, assign) BOOL isRefreshingPullDown;
//@property (nonatomic, weak) id<QDWebViewScrollDeleagte> scrollDelegate;

- (void) setPullUpHeight:(CGFloat)h;
- (void) setPullDownHeight:(CGFloat)h;
- (void) layoutPullViews;

@end
