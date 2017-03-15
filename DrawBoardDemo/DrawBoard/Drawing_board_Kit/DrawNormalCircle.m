//
//  DrawNomorCircle.m
//  test
//
//  Created by 张真 on 16/3/30.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawNormalCircle.h"

@implementation DrawNormalCircle
- (UIBezierPath *)bezierPath
{
    return [UIBezierPath bezierPathWithArcCenter:self.beginPoint radius:self.corneradues startAngle:0 endAngle:M_PI * 2 clockwise:YES];
}
@end
