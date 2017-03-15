//
//  ImageUtil.h
//  StudentClient
//
//  Created by 吴鹏 on 16/5/26.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject


//转base64;
+(NSString *) image2String:(UIImage *)image;

//转图片
+ (UIImage *) string2Image:(NSString *)string;
/**
 *  获取项目中的图片
 *
 *  @param name 图片名称
 *
 *  @return 图片
 */
+(UIImage*)getImageByName:(NSString*)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


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
+ (UIImage *)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targatWidth IsOriginalSize:(BOOL)isOriginalSize Scale:(CGFloat)scale;
/**
 *  压缩图片到某一指定高度
 *
 *  @param sourceImage  传入图片
 *  @param targatHeight 目标高度
 *
 *  @return 压缩后图片
 */
+ (UIImage *)compressImage:(UIImage*)sourceImage toTargetHeight:(CGFloat)targatHeight;

/**
 *  将两张图片合并成一张图片，上下布局
 *
 *  @param firstImage  上面的图片
 *  @param secondImage 下面的图片
 *
 *  @return 合并以后的图片
 */
+ (UIImage *)composeImage:(UIImage*)firstImage secondImage:(UIImage*)secondImage;

/**
 *  将图片转换成NSData
 *
 *  @param image 需要转换的图片
 *
 *  @param compressionRatio 图片采样率
 *
 *  @return 返回的NSData
 */
+ (NSData *)convertImageToDataWithImage:(UIImage *)image CompressionRatio:(CGFloat)compressionRatio;
@end
