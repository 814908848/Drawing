//
//  EraserLine.m
//  DrawTest
//
//  Created by zhangzhen on 16/5/5.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "EraserLine.h"

@implementation EraserLine
- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.path];
    return path;
}
- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    UIBezierPath *path = [self bezierPath];
    CGContextAddPath(context, path.CGPath);
    [self.strokeColor set];
    CGContextSetLineWidth(context, self.strokeWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextDrawPath(context, kCGPathStroke);
}
@end
