//
//  ViewController.m
//  MultiThreadSample
//
//  Created by fanqi on 17/4/26.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"
#import "NSOperationViewController.h"
#import "GCDViewController.h"
#import "NSConditionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutUI {
    CGFloat width = 150, height = 45, y = 130, padding = 20;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"NSThread" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, width, height);
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, y);
    [btn addTarget:self action:@selector(threadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    y += btn.bounds.size.height + padding;
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"NSOperation" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, width, height);
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, y);
    [btn addTarget:self action:@selector(operationBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    y += btn.bounds.size.height + padding;
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"GCD" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, width, height);
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, y);
    [btn addTarget:self action:@selector(gcdBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    y += btn.bounds.size.height + padding;
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"NSCondition" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, width, height);
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, y);
    [btn addTarget:self action:@selector(conditionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    y += btn.bounds.size.height + padding;
}


#pragma mark - Event

- (void)threadBtnClicked {
    NSThreadViewController *ctr = [NSThreadViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)operationBtnClicked {
    NSOperationViewController *ctr = [NSOperationViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)gcdBtnClicked {
    GCDViewController *ctr = [GCDViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)conditionBtnClicked {
    NSConditionViewController *ctr = [NSConditionViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}


@end
