//
//  DrawBoardQuestion.h
//  StudentClient
//
//  Created by 张真 on 16/6/3.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"
@interface DrawBoardQuestionView : UIView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) DrawView *drawView;

@property (strong, nonatomic) UIImage *image;

@property (assign, nonatomic) BOOL isDictation;//是否为汉子听写大赛
//蒙版
@property (strong, nonatomic) UIView *mengBanView;
/*
 *将图片保存到指定路径
 */
- (void)saveImageToPath:(NSString *)savePath andCompressionRatio:(CGFloat)compressionRatio;
/**
 *  将画板的内容保存成流的形式
 *
 *  @return 返回图片流
 */
- (NSData *)saveImageToDataCompressionRatio:(CGFloat)compressionRatio;
/**
 *  截取图片
 *
 *  @return 截取图片
 */
- (UIImage *)getSnapshotImage;
@end
