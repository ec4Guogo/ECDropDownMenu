//
//  ECDropDownMenuView.h
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECDropDownMenuViewDataSource;
@protocol ECDropDownMenuViewDelegate;

@interface ECDropDownMenuView : UIView

@property (weak, nonatomic) id<ECDropDownMenuViewDataSource> dataSource;
@property (weak, nonatomic) id<ECDropDownMenuViewDelegate> delegate;
@property (assign, nonatomic, readonly) BOOL isVisiable;


- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)reloadData;


@end


@protocol ECDropDownMenuViewDataSource <NSObject>

  @required

- (NSInteger)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView
  numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView
        numberOfRowsInSection:(NSInteger)section
                  inTableView:(UITableView *)tableView;

- (UITableViewCell *)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView
                cellForRowAtIndexPath:(NSIndexPath *)indexPath
                          inTableView:(UITableView *)tableView;


@end


@protocol ECDropDownMenuViewDelegate <NSObject>

  @optional

- (CGFloat)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
                inTableView:(UITableView *)tableView;

- (void)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
                inTableView:(UITableView *)tableView;

@end