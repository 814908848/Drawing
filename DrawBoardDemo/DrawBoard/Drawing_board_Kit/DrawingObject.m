//
//  DrawingObject.m
//  test
//
//  Created by 张真 on 16/3/29.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawingObject.h"

@implementation DrawingObject
- (id)initWithBeginPoint:(CGPoint)beginPoint
{
    if (self = [super init])
    {
        _beginPoint = beginPoint;
        _endPoint = beginPoint;
        _strokeColor = [UIColor blackColor];
        _strokeWidth = 1.0f;
        _bounds = CGRectMake(beginPoint.x, beginPoint.y, 0, 0);
    }
    return self;
}
- (void)moveEndPoint:(CGPoint)endPoint
{
    self.endPoint = endPoint;
    CGFloat x, y,width,height;
    CGPoint beginPoint = self.beginPoint;
    x = (beginPoint.x < endPoint.x) ? beginPoint.x : endPoint.x;
    y = (beginPoint.y < endPoint.y) ? beginPoint.y : endPoint.y;
    width = ABS(beginPoint.x - endPoint.x);
    height = ABS(beginPoint.y - endPoint.y);
    self.bounds = CGRectMake(x, y, width, height);
}
- (UIBezierPath *)bezierPath
{
    return nil;
}
- (void)draw
{
    UIBezierPath *path = [self bezierPath];
    if (path) {
        if (self.isDrawingStroke)
        {
            path.lineWidth = self.strokeWidth;
            [self.strokeColor setStroke];
            [path stroke];
        }
    }
}
- (BOOL)containsPoint:(CGPoint)point
{
    return [[self bezierPath]containsPoint:point];
}
@end
