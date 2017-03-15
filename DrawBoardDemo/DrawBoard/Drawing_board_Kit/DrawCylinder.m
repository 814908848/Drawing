//
//  DrawCylinder.m
//  DrawTest
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawCylinder.h"

@implementation DrawCylinder
- (UIBezierPath *)bezierPath
{
    return [UIBezierPath bezierPathWithOvalInRect:self.bounds];
}
@end
