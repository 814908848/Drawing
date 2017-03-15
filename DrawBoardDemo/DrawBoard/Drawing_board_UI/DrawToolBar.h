//
//  DrawToolBar.h
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUtil.h"
#import "CommonlyUsedBtn.h"
#define itemWidth 40
#define DrawToolBarMagon 20
#define LeftMargon 20
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
@interface DrawToolBar : UIImageView

@property (strong, nonatomic) CommonlyUsedBtn *recoderBtn;

@end
