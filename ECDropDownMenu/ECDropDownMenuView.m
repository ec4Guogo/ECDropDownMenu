//
//  ECDropDownMenuTableView.m
//  ECDropDownMenuDemo
//
//  https://github.com/ericwang24/ECDropDownMenu
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ECDropDownMenuView.h"

@interface ECDropDownMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (assign, nonatomic, readwrite) BOOL isVisiable;

@end

@implementation ECDropDownMenuView

- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.tableView.frame = self.bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - Getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - Setter

- (void)setDataSource:(id<ECDropDownMenuViewDataSource>)dataSource{
    _dataSource = dataSource;
    self.tableView.dataSource = self;
}

- (void)setDelegate:(id<ECDropDownMenuViewDelegate>)delegate{
    _delegate = delegate;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource dropDownMenuView:self numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource dropDownMenuView:self numberOfRowsInSection:section inTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource dropDownMenuView:self cellForRowAtIndexPath:indexPath inTableView:tableView];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownMenuView:heightForRowAtIndexPath:inTableView:)]) {
        return [self.delegate dropDownMenuView:self heightForRowAtIndexPath:indexPath inTableView:tableView];
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownMenuView:didSelectRowAtIndexPath:inTableView:)]) {
        [self.delegate dropDownMenuView:self didSelectRowAtIndexPath:indexPath inTableView:tableView];
    }
    [self dismiss];
}

#pragma mark - PublicMethod

- (void)showInView:(UIView *)view{
    self.isVisiable = YES;
    self.frame = view.bounds;
    if (self.delegate && [self.delegate respondsToSelector:@selector(frameForDropDownMenuView:)]) {
        self.frame = [self.delegate frameForDropDownMenuView:self];
    }
    [view addSubview:self];
    CGRect frame = self.tableView.frame;
    
    CGFloat height = MIN(self.tableView.contentSize.height, self.tableView.frame.size.height);
    frame.origin.y = - height;
    self.tableView.frame = frame;
    
    CGFloat red, green, blue, alpha;
    [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    
    self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0];
    
    __weak ECDropDownMenuView *weakSelf = self;
    [UIView animateWithDuration:0.36 animations:^{
        weakSelf.tableView.frame = weakSelf.bounds;
        weakSelf.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }];
}

- (void)dismiss{
    self.isVisiable = NO;
    
    CGRect frame = self.tableView.frame;
    CGFloat height = MIN(self.tableView.contentSize.height, self.tableView.frame.size.height);
    frame.origin.y = - height;
    
    CGFloat red, green, blue, alpha;
    [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    __weak ECDropDownMenuView *weakSelf = self;
    [UIView animateWithDuration:0.36 animations:^{
        weakSelf.tableView.frame = frame;
        weakSelf.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0];
    } completion:^(BOOL finished) {
        weakSelf.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        if (finished) {
            [weakSelf removeFromSuperview];
        }
    }];
    
}

- (void)reloadData{
    [self.tableView reloadData];
}


@end
