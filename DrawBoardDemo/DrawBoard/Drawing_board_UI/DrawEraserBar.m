//
//  DrawEraserBar.m
//  Students_iOS
//
//  Created by zhangzhen on 16/5/25.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawEraserBar.h"
#import "DrawToolView.h"

@interface DrawEraserBar()

@property (strong, nonatomic) NSArray * eraserWidthArray;

@end

@implementation DrawEraserBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LeftMargon * 2 + itemWidth * 5 + DrawToolBarMagon * 4, DrawEraserBarHeight)])
    {
        _eraserWidthArray = @[@10,@20,@30,@40,@50];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    for (int i = 0; i < 5; i ++)
    {
        CGFloat itemW = itemWidth;
        CGFloat itemX = LeftMargon + i * (itemWidth + DrawToolBarMagon);
        CGFloat itemY = (DrawEraserBarHeight - itemWidth) / 2;
        CGFloat itemH = itemWidth;
        NSArray *normalImageName = @[@"ic_circle_white01",@"ic_circle_white02",@"ic_circle_white03",@"ic_circle_white04",@"ic_circle_white05"];
        NSArray *selectImageName = @[@"ic_circle_yellow01",@"ic_circle_yellow02",@"ic_circle_yellow03",@"ic_circle_yellow04",@"ic_circle_yellow05"];
        CommonlyUsedBtn *btn = [[CommonlyUsedBtn alloc]initWithFrame:CGRectMake(itemX, itemY, itemW, itemH) normalImageName:normalImageName[i] selectImageName:selectImageName[i] btnType:CommonlyUsedBtnTypeImageRight textLabelFont:0 title:nil];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (void)btnClick:(CommonlyUsedBtn *)btn
{
    self.recoderBtn.selected = NO;
    btn.selected = YES;
    self.recoderBtn = btn;
    self.eraserBlock([self.eraserWidthArray[btn.tag - 200] intValue]);
}

@end
