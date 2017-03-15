//
//  DrawAnylineBar.h
//  StudentClient
//
//  Created by 张真 on 16/7/1.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import "DrawToolBar.h"

typedef void(^DrawAnylineWidthSelectBlock)(CGFloat drawWidth);
#define DrawAnylineBarHeight itemWidth + 15
@interface DrawAnylineBar : DrawToolBar

@property (copy, nonatomic) DrawAnylineWidthSelectBlock drawAnylineBlock;

@end
