//
//  Drawboard_Mini.h
//  StudentClient
//
//  Created by 张真 on 16/9/7.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"
#import "CommonlyUsedBtn.h"
@class Drawboard_Mini;
@protocol Drawboard_MiniDelegate <NSObject>
/**
 *  保存按钮点击
 *
 *  @param drawboard_Mini drawboard_Mini
 *  @param btn            btn
 */
- (void)drawboard_Mini:(Drawboard_Mini *)drawboard_Mini saveBtnClick:(CommonlyUsedBtn *)btn;

@end

@interface Drawboard_Mini : UIView
/*
 *tags备注：100：任意线条的线宽选择，101：颜色选择，102：图形选择，103：后退一步，104：橡皮擦得粗细选择，105：保存图片，106：前进一步107：清空所有线条
 *         108：退出当前控制器
 */
@property (strong, nonatomic) NSMutableArray *btns;//工具条上的所有按钮，每个按钮的tag值参照上方备注
@property (strong, nonatomic) DrawView *drawView;
@property (weak, nonatomic) id<Drawboard_MiniDelegate> delegate;
@end
