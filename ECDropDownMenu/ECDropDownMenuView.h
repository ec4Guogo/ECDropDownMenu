//
//  ECDropDownMenuView.h
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO: ECDropDownMenuTableView
@interface ECDropDownMenuView : UIView

- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)reloadData;

@property (assign, nonatomic, readonly) BOOL isVisiable;

@end
