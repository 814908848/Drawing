//
//  DrawingAnyLine.m
//  test
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawingAnyLine.h"

@implementation DrawingAnyLine
- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.path];
    return path;
}
- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [self bezierPath];
    CGContextAddPath(context, path.CGPath);
    [self.strokeColor set];
    CGContextSetLineWidth(context, self.strokeWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
