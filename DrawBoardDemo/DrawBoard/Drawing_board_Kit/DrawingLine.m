//
//  DrawingLine.m
//  test
//
//  Created by 张真 on 16/3/29.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawingLine.h"

@implementation DrawingLine
- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.beginPoint];
    [path addLineToPoint:self.endPoint];
    return path;
}
- (void)draw
{
    UIBezierPath *path = [self bezierPath];
    path.lineWidth = self.strokeWidth;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinMiter;
    [self.strokeColor setStroke];
    [path stroke];
}
@end
