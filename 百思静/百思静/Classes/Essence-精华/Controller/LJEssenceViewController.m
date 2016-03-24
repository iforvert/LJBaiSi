//
//  LJEssenceViewController.m
//  百思不得静
//
//  Created by 李学林 on 16/3/9.
//  Copyright © 2016年 Upriver. All rights reserved.
//

#import "LJEssenceViewController.h"
#import "LJRecommandTagViewController.h"

#import "LJAllViewController.h"
#import "LJVedioViewController.h"
#import "LJVoiceViewController.h"
#import "LJWordViewController.h"
#import "LJPictureViewController.h"

@interface LJEssenceViewController ()

@property(nonatomic, weak) UIView *indicatorView;
@property(nonatomic, weak) UIButton *selectedButton;
@property(nonatomic, weak) UIView *titleView;

@end

@implementation LJEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 进行导航栏按钮的相关设置
    [self setupNav];
    // 设置顶部的titleView
    [self setupTitleView];
    // 底部的contentView
    [self setupContentView];
    // 添加子控制器
    [self setupChildVc];
}


/**
 *  添加子控制器
 */
- (void)setupChildVc
{
    LJAllViewController *allVc = [[LJAllViewController alloc] init];
    [self addChildViewController:allVc];
    
    LJVedioViewController *vedioVc = [[LJVedioViewController alloc] init];
    [self addChildViewController:vedioVc];
    
    LJVoiceViewController *voiceVc = [[LJVoiceViewController alloc] init];
    [self addChildViewController:voiceVc];
    
    LJWordViewController *wordVc = [[LJWordViewController alloc] init];
    [self addChildViewController:wordVc];
    
    LJPictureViewController *pictureVc = [[LJPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
}

/**
 *  设置内容view
 */
- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    
    UISwitch *s = [[UISwitch alloc] init];
    [contentView addSubview:s];
    
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = [UIColor blueColor];
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat botton = self.tabBarController.tabBar.height;
    contentView.contentInset = UIEdgeInsetsMake(top, 0,botton , 0);
    
    [self.view insertSubview:contentView atIndex:0];
}
/**
 *  设置标题view
 */
- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.width = self.view.width;
    titleView.height = 30;
    titleView.y = 64;
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // titleview底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
    
    // 添加内部的子控件
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat buttonW = titleView.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.height = titleView.height;
        button.width = buttonW;
        button.x = buttonW * i;
//        button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0  blue:arc4random_uniform(255)/255.0  alpha:1];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        // 默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
            
        }
    }
    
}

- (void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}

/**
 *  进行导航栏按钮的相关设置
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = LJBJColor;
}

/**
 *  
 */
- (void)tagClick
{
    LJRecommandTagViewController *vc = [[LJRecommandTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
