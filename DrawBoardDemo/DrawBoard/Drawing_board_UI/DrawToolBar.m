//
//  DrawToolBar.m
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawToolBar.h"

@implementation DrawToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(27, 47, 74, 0.95f);
        self.layer.cornerRadius = 7.5;
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end
