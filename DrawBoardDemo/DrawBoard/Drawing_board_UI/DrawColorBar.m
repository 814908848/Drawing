//
//  DrawColorBar.m
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawColorBar.h"

@implementation DrawColorBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LeftMargon * 2 + itemWidth * 6 + DrawToolBarMagon * 5, DrawColorBarHeight)]) {
        self.colorArray = @[RGB(0, 0, 0),RGB(0, 255, 51),RGB(255, 0, 238),RGB(51, 0, 255),RGB(255, 255, 0),RGB(255, 0, 0)];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    for (int i = 0; i < 6; i ++) {
        CGFloat itemW = itemWidth;
        CGFloat itemX = LeftMargon + i * (itemWidth + DrawToolBarMagon);
        CGFloat itemY = (DrawColorBarHeight - itemWidth) / 2;
        CGFloat itemH = itemWidth;
        NSArray *normalImageName = @[@"black_nomal",@"green_nomal",@"purple_nomal",@"blue_nomal",@"yellow_nomal",@"red_nomal"];
        NSArray *selectImageName = @[@"black_select",@"green_select",@"purple_select",@"blue_select",@"yellow_select",@"red_select"];
        CommonlyUsedBtn *btn = [[CommonlyUsedBtn alloc]initWithFrame:CGRectMake(itemX, itemY, itemW, itemH) normalImageName:normalImageName[i] selectImageName:selectImageName[i] btnType:CommonlyUsedBtnTypeImageRight textLabelFont:0 title:nil];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            [btn setSelected:YES];
            self.recoderBtn = btn;
        }
    }
}
- (void)btnClick:(CommonlyUsedBtn *)btn
{
    self.recoderBtn.selected = NO;
    btn.selected = YES;
    self.recoderBtn = btn;
    self.colorSelect(self.colorArray[btn.tag - 200]);
}
@end
