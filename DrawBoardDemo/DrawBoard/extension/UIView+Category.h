//
//  UIView+Category.h
//  Students_iOS
//
//  Created by 张真 on 16/4/22.
//  Copyright © 2016年 all. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
/**
 *  圆角位置
 */
typedef NS_ENUM(NSUInteger, RoundedPosition) {
    /**
     *  上部圆角
     */
    RoundedPositionTop,
    /**
     *  下部圆角
     */
    RoundedPositionButton,
    /**
     *  左部圆角
     */
    RoundedPositionLeft,
    /**
     *  右部圆角
     */
    RoundedPositionRight,
    /**
     *   圆角
     */
    RoundedPositionAll,
};

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (assign, nonatomic) CGFloat maxX;
@property (assign, nonatomic) CGFloat maxY;

/**
 *  设置View圆角
 *
 *  @param side 圆角位置
 */
- (void)setTheRoundedCorners:(RoundedPosition)side;
@end
