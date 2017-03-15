//
//  FileUtil.m
//  StudentClient
//
//  Created by Shadow on 14-4-22.
//  Copyright (c) 2014年 imobile. All rights reserved.
//

#import "FileUtil.h"
#import "StringUtil.h"
#define O2S(object) [NSString stringWithFormat:@"%@",object]
@interface FileUtil ()
+ (void)makeDirs:(NSString *)path;
@end

@implementation FileUtil

+ (void)makeDirs:(NSString *)path
{
    int i = [StringUtil lastIndexOf:path searchStr:@"/"];
    int j = [StringUtil lastIndexOf:path searchStr:@"."];
    NSString *tmp;
    if(i<j){
        tmp = [StringUtil subString:path startIndex:0 endIndex:i];
    }else{
        tmp = path;
    }
    [self createDirectory:tmp];
}

+ (NSString *)readFileToString:(NSString *)filePath
{
    return [self readFileToString:filePath charset:NSUTF8StringEncoding];
}

+ (NSString *)readFileToString:(NSString *)filePath charset:(NSStringEncoding)charset
{
    if([self isExsit:filePath isDirectory:NO]){
        return [NSString stringWithContentsOfFile:filePath encoding:charset error:nil];
    }else{
        return nil;
    }
}

+ (BOOL)isExsit:(NSString *)filePath isDirectory:(BOOL)isDirectory
{
    if([StringUtil isEmpty:filePath needTrim:YES]){
        return NO;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL flag = [fm fileExistsAtPath:filePath isDirectory:&isDirectory];
    if(flag){
        return YES;
    }else{
        return NO;
    }
}

+ (NSMutableDictionary *)getFileAttribute:(NSString *)filePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSString * strPath= [StringUtil replace:O2S(filePath) searchStr:@"file://" replaceStr:@""];
    NSDictionary *dic = [fm attributesOfItemAtPath:strPath error:&error];
    NSMutableDictionary *dicTmp = [NSMutableDictionary dictionary];
    [dicTmp setValue:[dic objectForKey:NSFileSize] forKey:@"size"];
    [dicTmp setValue:[dic objectForKey:NSFileCreationDate] forKey:@"createDate"];
    [dicTmp setValue:[dic objectForKey:NSFileOwnerAccountName] forKey:@"owner"];
    [dicTmp setValue:[dic objectForKey:NSFileModificationDate] forKey:@"modifyDate"];
    return dicTmp;
}

+ (BOOL)removeFile:(NSString *)filePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    BOOL flag = NO;
    flag = [fm removeItemAtPath:filePath error:&error];
    return flag;
}

+ (NSArray *)listFilesFromPath:(NSString *)filePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm subpathsAtPath:filePath];
}

+ (BOOL)createFile:(NSString *)fileName content:(NSData *)data
{
    [self makeDirs:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm createFileAtPath:fileName contents:data attributes:nil];
}
+ (BOOL)createDirectory:(NSString *)filePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm createDirectoryAtPath:filePath 
         withIntermediateDirectories:YES 
                          attributes:nil 
                               error:nil];
}

+ (BOOL)rename:(NSString *)sourceFilePath tagertFilePath:(NSString *)tagertFilePath
{
    [self makeDirs:tagertFilePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm moveItemAtPath:sourceFilePath toPath:tagertFilePath error:nil];
}

+ (BOOL)copy:(NSString *)sourceFilePath tagertFilePath:(NSString *)tagertFilePath
{
    [self makeDirs:tagertFilePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *err;
    BOOL flag = [fm copyItemAtPath:sourceFilePath toPath:tagertFilePath error:&err];
    NSLog(@"%@",err);
    return flag;
}

+ (NSData *)readFileToData:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (BOOL)writeFile:(NSString *)path data:(NSData *)data
{
    [self makeDirs:path];
    return [data writeToFile:path atomically:YES];
}

+ (NSData *)readFileFromUrl:(NSString *)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return data;
}
+ (BOOL)cleanDirectory:(NSString *)dirPath
{
    NSArray *files = [self listFilesFromPath:dirPath];
    if(files != nil){
        for (NSString *filePath in files) {
            [self removeFile:[dirPath stringByAppendingPathComponent:filePath]];
        }
    }
    return YES;
}
+(BOOL)appendFileWithPath:(NSString*)path data:(NSData*)data{
    @try {
        if (![self isExsit:path isDirectory:NO]) {
            [self writeFile:path data:data];
            return YES;
        }
        NSFileHandle  *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
        if(outFile == nil)
        {
            NSLog(@"Open of file for writing failed");
        }
        //找到并定位到outFile的末尾位置(在此后追加文件)
        [outFile seekToEndOfFile];
        
        [outFile writeData:data];
        //关闭读写文件
        [outFile closeFile];
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }

}
@end
