//
//  DrawView.h
//  DrawTest
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingObject.h"
#import "DrawCircle.h"
#import "DrawingAnyLine.h"
#import "DrawingLine.h"
#import "DrawingObject.h"
#import "DrawingRectangle.h"
#import "DrawNormalCircle.h"
#import "DrawTriangle.h"
#import "DrawCylinder.h"
#import "DrawCube.h"
#import "EraserLine.h"
@protocol DrawViewDelegate <NSObject>
//改变工具条上的按钮状态

@optional
- (void)changeDrawToolBarBtnState;
- (void)hiddenOtherMengBan;
@end

@class DrawingObject;
@interface DrawView : UIView

/*
 *添加图形
 */
- (void)addDrawingObject:(DrawingObject *)drawingObject;
/*
 *开始绘画
 */
- (void)drawObjects;
/*
 *删除图形，后退一步
 */
- (void)removeDrawingObject:(DrawingObject *)drawingObject;

/*
 *删除所有线条
 */
- (void)removeAllDrawingObject;

/*
 *在后退的基础上，前进一步
 */
- (void)goForward;
/*
 *保存画板中的图片
 */
- (void)saveImageToPath:(NSString *)savePath;
/*
 *往画布中添加图片
 */
@property (strong, nonatomic) UIImage * editImage;
/*
 *传进来的绘画图形的类型
 */
@property (strong, nonatomic) Class drawType;

/**
 *  传进来的图形的线宽
 */
@property (assign, nonatomic) CGFloat strokeObjectWidth;
/**
 *  传进来的任意线条的宽度
 */
@property (assign, nonatomic) CGFloat strokeAnylineWidth;
/*
 *传进来的橡皮线宽以及颜色
 */
@property (assign, nonatomic) CGFloat strokeEraserWidth;

/*
 *传进来的线条颜色
 */
@property (strong, nonatomic) UIColor *strokeColor;

//线条数组
@property (strong, nonatomic) NSMutableArray *drawingObjects;

//废旧线条存储
@property (strong, nonatomic) NSMutableArray *goForwardObjects;

//废旧的图形存储
@property (strong, nonatomic) NSMutableArray * goForwardObjectsArray;

//记录现在画板上的所有图形
@property (strong, nonatomic) NSMutableArray * drawObjectsArray;

@property (weak, nonatomic) id delegate;

@end
