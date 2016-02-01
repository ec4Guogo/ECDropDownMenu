//
//  ViewController.m
//  ECDropDownMenuDemo
//
//  Created by Eric Wang on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "ECDropDownMenuTitleView.h"
#import "ECDropDownMenuView.h"

@interface ViewController ()<ECDropDownMenuViewDataSource, ECDropDownMenuViewDelegate>

@property (strong, nonatomic) ECDropDownMenuView *menuTableView;
@property (strong, nonatomic) ECDropDownMenuTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _menuTableView = [[ECDropDownMenuView alloc] initWithFrame:self.view.bounds];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
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

#pragma mark - ECDropDownMenuViewDataSource

- (NSInteger)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView numberOfRowsInSection:(NSInteger)section inTableView:(UITableView *)tableView{
    return 13;
}

- (UITableViewCell *)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView cellForRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Menu %ld", (long)indexPath.row];
    return cell;
}

#pragma mark - ECDropDownMenuViewDelegate


- (CGFloat)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView heightForRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    return 44;
}

- (void)dropDownMenuView:(ECDropDownMenuView *)dropDownMenuView didSelectRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    _titleView.title = [NSString stringWithFormat:@"Menu %ld", (long)indexPath.row];
}

@end
