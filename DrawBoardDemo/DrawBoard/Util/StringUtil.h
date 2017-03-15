//
//  StringUtil.h
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject
/**
 * 判断字符串是否为空
 * @param string    字符串
 * @param isTrim    是否需要两端去空格
 * @return          是/否 为空
 */
+ (BOOL)isEmpty:(NSString *)string needTrim:(BOOL)isTrim;

/**
 *  判断字符串是否为空 包含(<null>,(null),@"",nil)
 *
 *  @param string 字符串
 *  @param isTrim 是否需要两端去空格
 *
 *  @return 是/否 为空
 */

+ (BOOL)isEmptyString:(NSString *)string needTrim:(BOOL)isTrim;
/**
 * 去字符串两端空格
 * @param string    字符串
 * @return          去掉两端空格的字符串
 */
+ (NSString *)trim:(NSString *)string;
/**
 * 判断字符串是否含有别的字符串
 * @param string    字符串
 * @param str       被包含的字符串
 * @return          是/否 包含
 */
+ (BOOL)isContain:(NSString *)string searchStr:(NSString *)str;
/**
 * 字符串替换
 * @param string        原字符串
 * @param str           需要被替换的字符串
 * @param replaceStr    替换字符串
 * @return              替换后的字符串
 */
+ (NSString *)replace:(NSString *)string 
            searchStr:(NSString *)str 
           replaceStr:(NSString *)replaceStr;
/**
 * 将一个字符串数组 连接成一个字符串
 * @param array     字符串数组
 * @param sep       连接字符串
 * @return          连接后的字符串
 */
+ (NSString *)jion:(NSArray *)array separator:(NSString *)sep;
/**
 * 获得一个string的值，主要是为了过滤NSNULL为nil
 * @param str     字符串数组
 * @return        连接后的字符串
 */
+ (NSString *)getValue:(NSString *)str;
/**
 * 截断字符
 * @param string    原字符串
 * @param start     开始位置
 * @param end       结束位置（开区间）
 * @return          截断后的字符串
 */
+ (NSString *)subString:(NSString *)string startIndex:(int)start endIndex:(int)end;
/**
 * 截断字符
 * @param string    原字符串
 * @param start     开始位置
 * @return          截断后的字符串
 */
+ (NSString *)subString:(NSString *)string startIndex:(int)start;
/**
 * 判断一个字符串是否以一个字符串开头
 * @param string    原字符串
 * @param searchStr 开头字符
 * @return          是/否 开头
 */
+ (BOOL)startWith:(NSString *)string searchStr:(NSString *)searchStr;
/**
 * 判断一个字符串是否以一个字符串结尾
 * @param string    原字符串
 * @param searchStr 结尾字符
 * @return          是/否 结尾
 */
+ (BOOL)endWith:(NSString *)string searchStr:(NSString *)searchStr;
/**
 * 判断两个字符串是否相同
 * @param string    源字符串
 * @param otherStr  比较字符串
 * @return          是/否 相同
 */
+ (BOOL)equals:(NSString *)string otherStr:(NSString *)otherStr;
/**
 * 判断两个字符串是否相同，忽略大小写
 * @param string    源字符串
 * @param otherStr  比较字符串
 * @return          是/否 相同
 */
+ (BOOL)equalsIgnoreCase:(NSString *)string otherStr:(NSString *)otherStr;
/**
 * 查找给定字符串在原字符串中首次出现的位置
 * @param string    原字符串
 * @param searchStr 给定字符串
 * @return          位置号
 */
+ (int)indexOf:(NSString *)string searchStr:(NSString *)searchStr;
/**
 * 查找给定字符串在原字符串中最后一次出现的位置
 * @param string    原字符串
 * @param searchStr 给定字符串
 * @return          位置号
 */
+ (int)lastIndexOf:(NSString *)string searchStr:(NSString *)searchStr;

/**
 * 获得一个应用路径下的文件路径
 * @param fileName  文件名
 * @param type      文件后缀
 * @return          文件路径
 */
+ (NSString *)getAppFileByName:(NSString *)fileName withType:(NSString *)type;
/**
 * 获得docment下的一个文件的路径
 * @param fileName  文件名称（可以包含路径）
 * @return          文件路径
 */
+ (NSString *)getDocFilePathByName:(NSString *)fileName;
/**
 * 获得cache目录下的一个文件的路径
 * @param fileName  文件名称（可以包含路径）
 * @return          文件路径
 */
+ (NSString *)getCacheFilePathByName:(NSString *)fileName;
/**
 * 获得template目录下的一个文件路径
 * @param fileName  文件名称（可以包含路径）
 * @return          文件路径
 */
+ (NSString *)getTmpFilePathByName:(NSString *)fileName;
/**
 * 获得app路径
 * @return  app路径
 */
+ (NSString *)getAppPath;
/**
 * 获得document路径
 * @return  document路径
 */
+ (NSString *)getDocPath;
/**
 * 获得cache路径
 * @return  cache路径
 */
+ (NSString *)getCachePath;
/**
 * 获得template路径
 * @return  template路径
 */
+ (NSString *)getTmpPath;
/**
 * 将一个字符串转换成base64编码
 * @param string    原字符串
 * @return          base64字符串
 */
+ (NSString *)stringToBase64:(NSString *)string;
/**
 * 将一个base64的字符串转换成原字符串
 * @param string    base64字符串
 * @return          原字符串
 */
+ (NSString *)base64ToString:(NSString *)string;

/**
 * 过滤sql字符串
 * @param string    原字符串
 * @return          过滤后的字符串
 */

+ (NSString *)escapeSql:(NSString *)string;
/**
 *  去除空字符
 *
 *  @param string 原字符串
 *
 *  @return 处理后的
 */

+(NSString*)removeEmptyString:(NSString*)string;
/**
 *  md5 加密
 *
 *  @param string 原始字符串
 *
 *  @return 加密后的
 */
+(NSString*)md5:(NSString*)string;
@end
