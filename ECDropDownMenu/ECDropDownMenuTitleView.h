//
//  ECDropDownMenuTitleView.h
//  ECDropDownMenuDemo
//
//  https://github.com/ericwang24/ECDropDownMenu
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECDropDownMenuTitleView;

typedef void(^TapDropDownMenuTitleViewBlock)(ECDropDownMenuTitleView *titleView);

@interface ECDropDownMenuTitleView : UIView

@property (strong, nonatomic) NSString *title;

- (void)startArrowAnimationWithCompletion:(void (^)(BOOL finished))completion;

- (void)setTapDropDownMenuTitleViewBlock:(TapDropDownMenuTitleViewBlock)tapBlock;

@end
