//
//  DrawToolView.h
//  Students_iOS
//
//  Created by 张真 on 16/5/25.
//  Copyright © 2016年 all. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DrawToolBar.h"
#import "DrawColorBar.h"
#import "DrawTypeBar.h"
#import "EraserLine.h"
#import "DrawEraserBar.h"
#import "DrawView.h"
#import "DrawAnylineBar.h"
#import "DrawingAnyLine.h"
#import "UIView+Category.h"
#define DrawToolBarHeight 55
typedef void(^DrawTypeAndLineWidthSelectBlock)(Class cla,CGFloat lineWidth);
typedef void(^DrawAnylineBlock)(CGFloat width);
typedef void(^DrawAnylineWidthSelectBlock)(CGFloat drawWidth);
typedef void(^DrawEraserWidthBlock)(CGFloat drawWidth);
typedef void(^colorSelectBlock)(UIColor *selectColor);
typedef void(^DrawTypeSelectBlock)(Class cla);
typedef void(^EraserWidthSelect)(CGFloat eraserWidth);
typedef void(^ShowMengBanBlock)();
typedef void(^GoBackBlock)();
typedef void(^SaveImageBlock)();
typedef void(^GoForwardBlock)();
typedef void(^ClearAllBlock)();
typedef void(^DismissVCBlock)();
typedef enum{
    DrawToolBarpositionUp,
    DrawToolBarpositionDown
}DrawToolBarposition;
@interface DrawToolView : UIView
/*
 *显示萌版
 */
@property (copy, nonatomic) ShowMengBanBlock showMengBanBlock;
/*
 *画线的按钮点击Block
 */
@property (copy, nonatomic) DrawAnylineBlock drawAnyLineBlock;
/*
 *线的类型选择
 */
@property (copy, nonatomic) DrawTypeSelectBlock typeSelectBlock;
/*
 *线宽的粗细
 */
@property (copy, nonatomic) DrawAnylineWidthSelectBlock anylineWithSelectBlock;
/*
 *颜色选择
 */
@property (copy, nonatomic) colorSelectBlock colorSelect;
/*
 *橡皮擦的粗细选择
 */
@property (copy, nonatomic) EraserWidthSelect eraserBlock;
/*
 *橡皮擦按钮点击
 */
@property (copy, nonatomic) DrawEraserWidthBlock drawEraser;
/*
 *后退一步
 */
@property (copy, nonatomic) GoBackBlock goBackBlock;
/*
 *保存图片
 */
@property (copy, nonatomic) SaveImageBlock saveImageBlock;
/*
 *前进一步
 */
@property (copy, nonatomic) GoForwardBlock goForwardBlock;
/*
 *清空画板
 */
@property (copy, nonatomic) ClearAllBlock clearAllBlock;
/*
 *退出当前控制器
 */
@property (copy, nonatomic) DismissVCBlock dissmissVCBlock;
/**
 *  线形的选择和线宽的选择
 */
@property (copy, nonatomic) DrawTypeAndLineWidthSelectBlock drawtypeAndLineWidthBlock;

/*
 *记录按钮状态btn
 */
@property (strong, nonatomic) CommonlyUsedBtn *recodeBtn;
/*
 *选择任意线条的线宽
 */

@property (strong, nonatomic) DrawAnylineBar *anylineWidthSelectBar;
/*
 *颜色选择条
 */
@property (strong, nonatomic) DrawColorBar *colorSelectBar;
/*
 *类型选择条
 */
@property (strong, nonatomic) DrawTypeBar *typeSelectBar;
/*
 *橡皮擦线宽选择条
 */
@property (strong, nonatomic) DrawEraserBar * eraserSelectBar;
/*
 *按钮的容器
 */
@property (strong, nonatomic) UIView *drawToolBar;
/*
 *未选中图片的数组
 */
@property (strong, nonatomic) NSArray *normalImageNames;
/*
 *选中图片的数组
 */
@property (strong, nonatomic) NSArray *selectImageNames;
/*
 *tags备注：100：任意线条的线宽选择，101：颜色选择，102：图形选择，103：后退一步，104：橡皮擦得粗细选择，105：保存图片，106：前进一步107：清空所有线条
 *         108：退出当前控制器
 */
@property (strong, nonatomic) NSArray *tags;
/*
 *工具条上的按钮数组
 */
@property (strong, nonatomic) NSMutableArray *btns;
/*
 *工具条的位置，上或者下
 */
@property (assign, nonatomic) DrawToolBarposition toolBarPosition;
/*
 *初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame drawToolBarposition:(DrawToolBarposition)drawToolBarposition drawTypeAndLineWidthSelectBlock:(DrawTypeAndLineWidthSelectBlock)drawTypeAndLineWidthSelectBlock drawAnyLineWidthBlock:(DrawAnylineWidthSelectBlock)drawAnylineWidthSelectBlock colorSelectBlock:(colorSelectBlock)colorSelectBlock eraserWidthSelect:(EraserWidthSelect)eraserWidthSelect goBackBlock:(GoBackBlock)goBackBlock saveImageBlock:(SaveImageBlock)saveImageBlock goforwardBlock:(GoForwardBlock)goforwardBlock clearAllBlock:(ClearAllBlock)clearAllBlock dissmissVCBlock:(DismissVCBlock)dissmissVCBlock;
/*
 *在工具条上创建相应的功能按钮
 */
- (void)createDrawToolBarWithNormalImageNames:(NSArray *)normalImageNames selectImageNames:(NSArray *)selectImageNames tags:(NSArray *)tags;
/**
 *  在绘画的时候隐藏底部工具条上的子工具条
 */
- (void)hiddenDrawToolBar;
@end