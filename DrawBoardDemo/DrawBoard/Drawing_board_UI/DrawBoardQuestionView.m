//
//  DrawBoardQuestion.m
//  StudentClient
//
//  Created by 张真 on 16/6/3.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import "DrawBoardQuestionView.h"
#import "FileUtil.h"
#import "UIView+Category.h"
@implementation DrawBoardQuestionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self createImageView];
        
        [self createDrawView];
        
        [self addMengBan];
    }
    return self;
}
#pragma mark ->增添蒙版
- (void)addMengBan
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.width, self.height);
    view.alpha = 0.5;
    view.backgroundColor = [UIColor blackColor];
    view.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearAll)];
    [view addGestureRecognizer:tap];
    
    self.mengBanView = view;
    [self addSubview:view];
}
- (void)clearAll
{
    [self.drawView removeAllDrawingObject];
    self.mengBanView.hidden = YES;
}
#pragma mark ->初始化ImageView
- (void)createImageView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.backgroundColor = [UIColor clearColor];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
}
#pragma mark ->初始化画板
- (void)createDrawView
{
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.bounds];
    drawView.backgroundColor = [UIColor clearColor];
    [self addSubview:drawView];
    self.drawView = drawView;
}
#pragma mark ->给imageView设置图片
- (void)setImage:(UIImage *)image
{
    if (image == nil)
    {
        return;
    }
    self.imageView.image = image;
    if (image.size.width > self.width || image.size.height > self.height)
    {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else
    {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
}
/**
 *  给定文件路径，将图片保存到本地
 *
 *  @param savePath         图片的保存路径
 *  @param compressionRatio 图片打采样率
 */
- (void)saveImageToPath:(NSString *)savePath andCompressionRatio:(CGFloat)compressionRatio;
{
    if (savePath == nil)
    {
        return;
    }
    UIImage *image = [self getSnapshotImage];
//    NSData *data = UIImageJPEGRepresentation(image, compressionRatio);
    
    NSData *data = UIImagePNGRepresentation(image);
    [FileUtil writeFile:savePath data:data];
}

/**
 *  给定图片的采样率，将图片转换成NSData
 *
 *  @param compressionRatio 图片的采样率
 *
 *  @return NSData
 */
- (NSData *)saveImageToDataCompressionRatio:(CGFloat)compressionRatio
{
    UIImage *image = [self getSnapshotImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    return imageData;
}
/**
 *  截取屏幕的方法
 *
 *  @return 返回截取的图片
 */
- (UIImage *)getSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self drawViewHierarchyInRect:CGRectMake(0, 0, self.width, self.height) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}
@end
