//
//  DrawColorBar.h
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawToolBar.h"
#define DrawColorBarHeight 15 + itemWidth
typedef void(^colorSelectBlock)(UIColor *selectColor);
@interface DrawColorBar : DrawToolBar
@property (strong, nonatomic) NSArray *colorArray;
@property (copy, nonatomic) colorSelectBlock colorSelect;
@end
