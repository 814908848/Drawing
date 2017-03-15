//
//  ImageUtil.m
//  StudentClient
//
//  Created by 吴鹏 on 16/5/26.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import "ImageUtil.h"
#import "GTMBase64.h"
#import "FileUtil.h"
#define ScreenScale [[UIScreen mainScreen] scale]
@implementation ImageUtil

//转base64;
+(NSString *) image2String:(UIImage *)image {
    NSData *pictureData = UIImageJPEGRepresentation(image, 0.5);
    NSString *pictureDataString = [GTMBase64 stringByEncodingData:pictureData];
    return pictureDataString;
}

//转图片
+ (UIImage *) string2Image:(NSString *)string {
    UIImage *image = [UIImage imageWithData:[GTMBase64 decodeString:string]];
    return image;
}

+(UIImage*)getImageByName:(NSString*)name{
    NSString *path;
    if (ScreenScale>=3) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@3x",name] ofType:@"png"];
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:@"png"];
        }
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        }
    }if (ScreenScale==2) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:@"png"];
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        }
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@3x",name] ofType:@"png"];
        }
    }else{
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:@"png"];
        }
        if (![FileUtil isExsit:path isDirectory:NO]) {
            path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@3x",name] ofType:@"png"];
        }
    }
  
    return  [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self getImageByName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
/**
 *  压缩图片，根据想要的图片宽度，按图片原比例或想要的比例
 *
 *  @param sourceImage    传入图片
 *  @param targatWidth    想要的宽度
 *  @param isOriginalSize 图片原比例
 *  @param scale          想要的比例
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targatWidth IsOriginalSize:(BOOL)isOriginalSize Scale:(CGFloat)scale{
    CGFloat targetHeight;
    if (isOriginalSize) {
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        targetHeight = (targatWidth / width) * height;
    }
    else{
        targetHeight = targatWidth * scale;
    }
    UIGraphicsBeginImageContext(CGSizeMake(targatWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targatWidth, targetHeight)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)compressImage:(UIImage*)sourceImage toTargetHeight:(CGFloat)targatHeight{
    CGFloat targetWidth;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    targetWidth = (targatHeight / height) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targatHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targatHeight)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 *  将两张尺寸相同的图片转合并成一张上下布局的图片
 *
 *  @param firstImage  上图
 *  @param secondImage 下图
 *
 *  @return 合并图
 */
+ (UIImage *)composeImage:(UIImage*)firstImage secondImage:(UIImage*)secondImage
{
    CGSize firstSize = firstImage.size;
    CGSize secondSize = secondImage.size;
    CGFloat maxWidth = MAX(firstSize.width, secondSize.width);
    CGSize size = CGSizeMake(maxWidth, firstSize.height + secondSize.height);
    UIGraphicsBeginImageContext(size);
    
    [firstImage drawInRect:CGRectMake((maxWidth - firstSize.width) / 2, 0, firstSize.width, firstSize.height)];
    
    [secondImage drawInRect:CGRectMake(0, firstSize.height, secondSize.width, secondSize.height)];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}
/**
 *  将图片转换成NSData
 *
 *  @param image 需要转换的图片
 *
 *  @param compressionRatio 图片采样率
 *
 *  @return 返回的NSData
 */
+ (NSData *)convertImageToDataWithImage:(UIImage *)image CompressionRatio:(CGFloat)compressionRatio
{
    return UIImagePNGRepresentation(image);
}

@end
