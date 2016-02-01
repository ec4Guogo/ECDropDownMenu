//
//  ECDropDownMenuTableView.m
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ECDropDownMenuView.h"

@interface ECDropDownMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Menu %ld", (long)indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
