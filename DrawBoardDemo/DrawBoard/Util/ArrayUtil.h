//
//  ArrayUtil.h
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayUtil : NSObject
/**
 * 数组中是否包含一个对象
 * @param array     数组
 * @param searchObj 对象
 * @return          是否包含
 */
+ (BOOL)isContain:(NSArray *)array searchObj:(id)searchObj;
/**
 * 截断数组
 * @param array     原数组
 * @param start     开始位置
 * @param endIndex  结束位置
 * @return          截断后的数组
 */
+ (NSArray *)subArray:(NSArray *)array startIndex:(int)start endIndex:(int)endIndex;
/**
 * 获得数组的最后一个元素
 * @param array     原数组
 * @return          对象
 */
+ (id)lastObject:(NSArray *)array;
/**
 * 获得一个数组中的元素
 * @param array     原数组
 * @param index     元素位置
 * @return          对象
 */
+ (id)getObject:(NSArray *)array atIndex:(int)index;
/**
 * 获得一个对象所在数组中第一次出现的位置
 * @param array     原数组
 * @param obj       对象
 * @return          位置
 */
+ (int)indexOf:(NSArray *)array searchObj:(id)obj;
/**
 * 获得一个对象所在数组中最后一次出现的位置
 * @param array     原数组
 * @param obj       对象
 * @return          位置
 */
+ (int)lastIndexOf:(NSArray *)array searchObj:(id)obj;
/**
 * 向一个数组中添加一个元素
 * @param array     原数组
 * @param obj       对象
 * @return          添加后的数组
 */
+ (NSArray *)add:(NSArray *)array obj:(id)obj;
/**
 * 将一个数组添加到另一个数组中
 * @param array     原数组
 * @param objs      将要添加的数组
 * @return          添加后的数组
 */
+ (NSArray *)addAll:(NSArray *)array objs:(NSArray *)objs;
/**
 * 将一个字符串拆分成数组
 * @param string    字符串
 * @param sep       分隔符
 * @return          数组
 */
+ (NSArray *)splitString:(NSString *)string separator:(NSString *)sep;
/**
 * 将一个数组转换成可变长度数组
 * @param array     原数组
 * @return          变长数组
 */
+ (NSMutableArray *)coventToMutableArray:(NSArray *)array;
/**
 * 判断一个数组是否为空
 * @param array     数组
 * @return          是否为空
 */
+ (BOOL)isEmpty:(NSArray *)array;
/**
 * 数组排序
 * @param array     原数组
 * @return          排序后的数组
 */
+ (NSArray *)sort:(NSArray *)array;
/**
 * 将数组倒排
 * @param array     原数组
 * @return          倒排后的数组
 */
+ (NSArray *)reverse:(NSArray *)array;

@end
