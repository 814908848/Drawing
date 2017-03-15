//
//  DrawCircle.m
//  test
//
//  Created by 张真 on 16/3/29.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawCircle.h"

@implementation DrawCircle
- (UIBezierPath *)bezierPath
{
    return [UIBezierPath bezierPathWithOvalInRect:self.bounds];
}
@end
