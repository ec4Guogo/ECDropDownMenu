//
//  ECDropDownMenuTableView.m
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ECDropDownMenuTableView.h"

@interface ECDropDownMenuTableView ()

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic, readwrite) BOOL isVisiable;

@end

@implementation ECDropDownMenuTableView

- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
    }
    return _tableView;
}

#pragma mark - Setter

- (void)setMenuTableViewDelegate:(id<UITableViewDelegate>)menuTableViewDelegate{
    _menuTableViewDelegate = menuTableViewDelegate;
    self.tableView.delegate = menuTableViewDelegate;
}

- (void)setMenuTableViewDataSource:(id<UITableViewDataSource>)menuTableViewDataSource{
    _menuTableViewDataSource = menuTableViewDataSource;
    self.tableView.dataSource = menuTableViewDataSource;
}

#pragma mark - PublicMethod

- (void)showInView:(UIView *)view{
    self.isVisiable = YES;
    self.frame = view.bounds;
    [view addSubview:self];
    CGRect frame = self.tableView.frame;
    
    CGFloat height = MIN(self.tableView.contentSize.height, self.tableView.frame.size.height);
    frame.origin.y = - height;
    self.tableView.frame = frame;
    
    CGFloat red, green, blue, alpha;
    [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    
    self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0];
    
    __weak ECDropDownMenuTableView *weakSelf = self;
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
    __weak ECDropDownMenuTableView *weakSelf = self;
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
