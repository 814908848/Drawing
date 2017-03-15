//
//  ViewController.m
//  DrawBoardDemo
//
//  Created by 张真 on 17/3/15.
//  Copyright © 2017年 张真. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoardView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DrawBoardView *draw = [[DrawBoardView alloc]initWithFrame:self.view.bounds andDrawBoardViewType:DrawBoardViewTypeNote];
    [self.view addSubview:draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
