//
//  DrawEraserBar.h
//  Students_iOS
//
//  Created by zhangzhen on 16/5/25.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawToolBar.h"
#define DrawEraserBarHeight itemWidth + 15
typedef void(^EraserWidthSelect)(CGFloat eraserWidth);
@interface DrawEraserBar : DrawToolBar
@property (strong, nonatomic) UISlider * slider;
@property (copy, nonatomic) EraserWidthSelect eraserBlock;
@end
