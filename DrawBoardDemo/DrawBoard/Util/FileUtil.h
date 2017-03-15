//
//  FileUtil.h
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtil : NSObject
/**
 * 读取文件成字符串
 * @param filePath  文件路径
 * @return          字符串
 */
+ (NSString *)readFileToString:(NSString *)filePath;
/**
 * 读取文件成字符串
 * @param filePath  文件路径
 * @param charset   文件字符集
 * @return          字符串
 */
+ (NSString *)readFileToString:(NSString *)filePath charset:(NSStringEncoding)charset;
/**
 * 判断文件是否存在
 * @param filePath      文件路径
 * @param isDirectory   是否为目录
 * @return              是/否 存在
 */
+ (BOOL)isExsit:(NSString *)filePath isDirectory:(BOOL)isDirectory;
/**
 * 获取文件的属性
 * @param filePath      文件路径
 * @return              文件属性
 */
+ (NSMutableDictionary *)getFileAttribute:(NSString *)filePath;
/**
 * 删除文件
 * @param filePath      文件路径
 * @return              是否成功
 */
+ (BOOL)removeFile:(NSString *)filePath;
/**
 * 文件列表
 * @param filePath      文件路径
 * @return              文件列表
 */
+ (NSArray *)listFilesFromPath:(NSString *)filePath;
/**
 * 创建一个文件
 * @param fileName      文件名称（带路径）
 * @param data          文件内容
 * @return              是否创建成功
 */
+ (BOOL)createFile:(NSString *)fileName content:(NSData *)data;
/**
 * 创建一个目录
 * @param filePath      路径
 * @return              是否创建成功
 */
+ (BOOL)createDirectory:(NSString *)filePath;
/**
 * 重命名一个文件（也可以用作剪切）
 * @param sourceFilePath    原文件路径
 * @param tagertFilePath    目标文件路径
 * @return                  是否成功
 */
+ (BOOL)rename:(NSString *)sourceFilePath tagertFilePath:(NSString *)tagertFilePath;
/**
 * 拷贝一个文件
 * @param sourceFilePath    原文件路径
 * @param tagertFilePath    目标文件路径
 * @return                  是否成功
 */
+ (BOOL)copy:(NSString *)sourceFilePath tagertFilePath:(NSString *)tagertFilePath;
/**
 * 读取文件
 * @param filePath      文件路径
 * @return              data
 */
+ (NSData *)readFileToData:(NSString *)filePath;
/**
 * 写入文件
 * @param path      文件路径
 * @param data      文件内容
 * @return          是否写入成功
 */
+ (BOOL)writeFile:(NSString *)path data:(NSData *)data;
/**
 * 读取一个url地址
 * @param url   url地址
 * @return      data
 */
+ (NSData *)readFileFromUrl:(NSString *)url;
/**
 * 清空一个目录
 * @param dirPath   目录路径
 * @return          是否清空成功
 */
+ (BOOL)cleanDirectory:(NSString *)dirPath;

+(BOOL)appendFileWithPath:(NSString*)path data:(NSData*)data;
@end
