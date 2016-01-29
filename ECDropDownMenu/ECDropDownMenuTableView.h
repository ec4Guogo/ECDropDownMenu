//
//  ECDropDownMenuTableView.h
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO: ECDropDownMenuTableView
@interface ECDropDownMenuTableView : UIView

@property (assign, nonatomic) id<UITableViewDelegate> menuTableViewDelegate;
@property (assign, nonatomic) id<UITableViewDataSource> menuTableViewDataSource;

- (void)showInView:(UIView *)view;
- (void)dismiss;

- (void)reloadData;

@property (assign, nonatomic, readonly) BOOL isVisiable;

@end
