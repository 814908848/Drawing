//
//  DrawingObject.h
//  test
//
//  Created by 张真 on 16/3/29.
//  Copyright © 2016年 张真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawingObject : NSObject
@property (assign, nonatomic) CGPoint beginPoint;
@property (assign, nonatomic) CGPoint endPoint;
@property (assign, nonatomic) CGRect bounds;
@property (assign, nonatomic, getter=isDrawingStroke) BOOL drawingStroke;

// 线条宽度。
@property (assign, nonatomic) CGFloat strokeWidth;

// 线条颜色。
@property (strong, nonatomic) UIColor *strokeColor;

//圆的半径
@property (assign, nonatomic) CGFloat corneradues;

//任意线条的路径
@property (strong, nonatomic) UIBezierPath *bezierPath;

@property (nonatomic, assign) CGMutablePathRef path;

//图片
@property (strong, nonatomic) UIImage *editImage;
// 指定起始点
- (id)initWithBeginPoint:(CGPoint)beginPoint;
// 终点坐标
- (void)moveEndPoint:(CGPoint)endPoint;

// 图形类型路径
- (UIBezierPath *)bezierPath;

// 绘画
- (void)draw;





@end
