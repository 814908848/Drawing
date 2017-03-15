//
//  CommonlyUsed.h
//  Students_iOS
//
//  Created by 张真 on 16/4/27.
//  Copyright © 2016年 all. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CommonlyUsedBtnTypeImageLeft,
    CommonlyUsedBtnTypeImageRight,
} CommonlyUsedBtnType;

@interface CommonlyUsedBtn : UIButton

@property (assign, nonatomic) CommonlyUsedBtnType btnType;

- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName btnType:(CommonlyUsedBtnType)btnType textLabelFont:(int)fontSize title:(NSString *)title;
@end
