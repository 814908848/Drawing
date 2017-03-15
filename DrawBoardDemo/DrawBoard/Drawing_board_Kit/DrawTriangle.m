//
//  DrawTriangle.m
//  DrawTest
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawTriangle.h"

@implementation DrawTriangle
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
