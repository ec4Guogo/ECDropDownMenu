//
//  ViewController.m
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "ECDropDownMenuTitleView.h"
#import "ECDropDownMenuTableView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ECDropDownMenuTableView *menuTableView;
@property (strong, nonatomic) ECDropDownMenuTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _menuTableView = [[ECDropDownMenuTableView alloc] initWithFrame:self.view.bounds];
    _menuTableView.menuTableViewDataSource = self;
    _menuTableView.menuTableViewDelegate = self;
    
    _titleView = [[ECDropDownMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _titleView.title = @"测试标题测测试标题测测试标题测测试标题测测试标题测";
    
    __weak ViewController *weakSelf = self;
    [_titleView setTapDropDownMenuTitleViewBlock:^(ECDropDownMenuTitleView *titleView) {
        if (weakSelf.menuTableView.isVisiable) {
            [weakSelf.menuTableView dismiss];
        }
        else{
            [weakSelf.menuTableView showInView:weakSelf.view];
        }
    }];
    self.navigationItem.titleView = _titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _titleView.title = [NSString stringWithFormat:@"Menu %ld", (long)indexPath.row];
    [_menuTableView dismiss];
    [_menuTableView reloadData];
}

@end
