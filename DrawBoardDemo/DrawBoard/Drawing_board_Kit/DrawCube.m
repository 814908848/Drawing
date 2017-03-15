//
//  DrawCube.m
//  DrawTest
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawCube.h"

@implementation DrawCube
- (UIBezierPath *)bezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    return path;
}
@end
