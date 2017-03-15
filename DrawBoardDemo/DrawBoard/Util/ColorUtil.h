//
//  ColorUtil.h
//  StudentClient
//
//  Created by 吴鹏 on 16/5/26.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ColorUtil : NSObject

/**
 * 颜色转换
 * @param color            16进制颜色
 * @return  UIColor        UICOlOR
 */

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
