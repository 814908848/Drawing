//
//  DrawTypeBar.h
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//
#import "DrawToolBar.h"

#import "DrawingRectangle.h"
#import "DrawCircle.h"
#import "DrawingLine.h"
#import "DrawTriangle.h"
#import "DrawCylinder.h"
#import "DrawCube.h"
#import "DrawNormalCircle.h"
#import "DrawingAnyLine.h"
#define DrawTypeBarHeight 90

typedef void(^DrawTypeAndLineWidthSelectBlock)(Class cla,CGFloat lineWidth);

@interface DrawTypeBar : DrawToolBar

@property (strong, nonatomic) NSArray *drawTypes;

@property (copy, nonatomic) DrawTypeAndLineWidthSelectBlock drawTypeAndLineWidthBlock;

@end
