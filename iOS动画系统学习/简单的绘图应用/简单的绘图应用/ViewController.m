//
//  ViewController.m
//  简单的绘图应用
//
//  Created by lalala on 2017/11/22.
//  Copyright © 2017年 LSH. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DrawingView * drawView = [[DrawingView alloc]initWithFrame:self.view.bounds];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
