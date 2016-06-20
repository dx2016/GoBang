//
//  GoBangViewController.m
//  GoBang
//
//  Created by Dxue on 16/6/15.
//  Copyright © 2016年 Dxue. All rights reserved.
//

#import "GoBangViewController.h"
#import "GoBangView.h"
#import "LineView.h"
#import "Header.h"

@interface GoBangViewController ()

/**
 *  全部棋子
 */
@property (nonatomic, strong) GoBangView *goBangView;

/**
 *  棋盘
 */
@property (nonatomic, strong) LineView *lineView;


@end

@implementation GoBangViewController

- (GoBangView *)goBangView{
    if (_goBangView == nil) {
        _goBangView = [[GoBangView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        [self.view addSubview:_goBangView];
    }
    return _goBangView;
}

- (LineView *)lineView{
    if (_lineView == nil) {
        _lineView = [[LineView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 )];
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    //    self.lineView.backgroundColor = [UIColor orangeColor];
//    self.lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        self.lineView.backgroundColor = [UIColor clearColor];
    self.goBangView.backgroundColor = [UIColor clearColor];
    
//    [self initNav];
//
    self.navigationItem.title = @"五子棋";
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//
//    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"悔棋" style:UIBarButtonItemStylePlain target:self action:@selector(UnDoAction)];
//
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重玩" style:UIBarButtonItemStylePlain target:self action:@selector(RePlayAction)];
}

- (void)initNav
{
//    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    nav.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:nav];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    
    effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    
    [self.view addSubview:effectView];
    
    
}

// 悔棋
- (void)UnDoAction
{
    [self.goBangView undo];
}

// 重玩
- (void)RePlayAction
{
    [self.goBangView RePlay];
}



@end
