//
//  StringUtil.m
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "StringUtil.h"
#import "ArrayUtil.h"
#import "GTMBase64.h"

@implementation StringUtil

+ (BOOL)isEmpty:(NSString *)string needTrim:(BOOL)isTrim
{
    if(string == nil || (NSNull *)string == [NSNull null] || [string isEqualToString:@""]){
        return YES;
    }
    NSString *tmp = string;
    if(isTrim){
        tmp = [tmp stringByTrimmingCharactersInSet:[NSCharacterSet 
                                                    whitespaceAndNewlineCharacterSet]];
    }
    if([tmp length] == 0){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isEmptyString:(NSString *)string needTrim:(BOOL)isTrim
{
    if(string == nil || (NSNull *)string == [NSNull null]||[string isEqualToString:@"<null>"]||[string isEqualToString:@"(null)"]||[string isEqualToString:@""]){
        return YES;
    }
    NSString *tmp = string;
    if(isTrim){
        tmp = [tmp stringByTrimmingCharactersInSet:[NSCharacterSet
                                                    whitespaceAndNewlineCharacterSet]];
    }
    if([tmp length] == 0){
        return YES;
    }else{
        return NO;
    }
}

+(NSString*)removeEmptyString:(NSString*)string{
    NSArray * stringArray = @[@"<null>",@"(null)"];
    NSString *newString =string;
    for (NSString * replace in stringArray) {
        newString = [string stringByReplacingOccurrencesOfString:replace withString:@""];
    }
    return newString;
}

+ (NSString *)trim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet 
                                                    whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isContain:(NSString *)string searchStr:(NSString *)str
{
    BOOL flag = NO;
    if(string != nil){
        NSRange range = [string rangeOfString:str];
        if(range.location != NSNotFound){
            flag = YES;
        }
    }
    return flag;
}

+ (NSString *)replace:(NSString *)string 
            searchStr:(NSString *)str 
           replaceStr:(NSString *)replaceStr{
    return [string stringByReplacingOccurrencesOfString:str withString:replaceStr];
}

+ (NSString *)jion:(NSArray *)array separator:(NSString *)sep
{
    return [array componentsJoinedByString:sep];
}
+ (NSString *)getValue:(NSString *)str
{
    if([self isEmpty:str needTrim:YES]){
        return nil;
    }
    return str;
}
+ (NSString *)subString:(NSString *)string startIndex:(int)start endIndex:(int)end
{
    int length = end - start;
    NSRange range = NSMakeRange(start, length);
    return [string substringWithRange:range];
}

+ (NSString *)subString:(NSString *)string startIndex:(int)start
{
    NSRange range = NSMakeRange(start, [string length]-start);
    return [string substringWithRange:range];
}

+ (BOOL)startWith:(NSString *)string searchStr:(NSString *)searchStr
{
    NSRange range = [string rangeOfString:searchStr];
    if(range.location == 0){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)endWith:(NSString *)string searchStr:(NSString *)searchStr
{
    NSRange range = [string rangeOfString:searchStr options:NSBackwardsSearch];
    long index = string.length - searchStr.length;
    if(index == range.location){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)equals:(NSString *)string otherStr:(NSString *)otherStr
{
    return [string isEqualToString:otherStr];
}

+ (BOOL)equalsIgnoreCase:(NSString *)string otherStr:(NSString *)otherStr
{
    return [[string lowercaseString] isEqualToString:[otherStr lowercaseString]];
}

+ (int)indexOf:(NSString *)string searchStr:(NSString *)searchStr
{
    NSRange range = [string rangeOfString:searchStr];
    if(range.location != NSNotFound){
        return [NSString stringWithFormat:@"%lu",(unsigned long)range.location].intValue;
    }else{
        return -1;
    }
}

+ (int)lastIndexOf:(NSString *)string searchStr:(NSString *)searchStr
{
    NSRange range = [string rangeOfString:searchStr options:NSBackwardsSearch];
    if(range.location != NSNotFound){
        return [NSString stringWithFormat:@"%lu",(unsigned long)range.location].intValue;
    }else{
        return -1;
    }
}


+ (NSString *)getAppFileByName:(NSString *)fileName withType:(NSString *)type
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

+ (NSString *)getDocFilePathByName:(NSString *)fileName
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                            NSUserDomainMask, 
                                                            YES);
    NSString *path = [ArrayUtil getObject:docPaths atIndex:0];
    return [path stringByAppendingPathComponent:fileName];
}

+ (NSString *)getCacheFilePathByName:(NSString *)fileName
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 
                                                            NSUserDomainMask, 
                                                            YES);
    NSString *path = [ArrayUtil getObject:docPaths atIndex:0];
    return [path stringByAppendingPathComponent:fileName];
}

+ (NSString *)getTmpFilePathByName:(NSString *)fileName
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
}

+ (NSString *)getAppPath
{
    return [NSSearchPathForDirectoriesInDomains(NSAllApplicationsDirectory, NSUserDomainMask, YES) 
            objectAtIndex:0];
}

+ (NSString *)getDocPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
            objectAtIndex:0];
}

+ (NSString *)getCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) 
            objectAtIndex:0];
}

+ (NSString *)getTmpPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)stringToBase64:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)base64ToString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)escapeSql:(NSString *)string
{
    return [self replace:string searchStr:@"'" replaceStr:@"''"];
}

+(NSString*)md5:(NSString*)string{
    const char *cStr = [string UTF8String];
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
