//
//  DrawingRectangle.m
//  test
//
//  Created by 张真 on 16/3/29.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawingRectangle.h"

@implementation DrawingRectangle
- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    return path;
}
@end
