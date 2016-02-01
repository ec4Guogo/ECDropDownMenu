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

@interface ViewController ()

@property (strong, nonatomic) ECDropDownMenuView *menuTableView;
@property (strong, nonatomic) ECDropDownMenuTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _menuTableView = [[ECDropDownMenuView alloc] initWithFrame:self.view.bounds];
    
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


@end
