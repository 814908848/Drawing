//
//  CommonUtil.h
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtil.h"
#import "GTMBase64.h"
#import <UIKit/UIColor.h>

@interface CommonUtil : NSObject
/**
 * 创建一个范围
 * @param start     开始位置
 * @param end       结束位置
 * @return          范围
 */
+ (NSRange)getRange:(int)start end:(int)end;


// 函数描述 : 文本数据进行DES加密
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

// 函数描述 : 文本数据进行DES解密
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

@end
