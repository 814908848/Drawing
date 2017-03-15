//
//  DrawBoardView.h
//  StudentClient
//
//  Created by zhangzhen on 16/6/18.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoardQuestionView.h"
#import "DrawToolView.h"
typedef void(^CreateGestureBlock)();
@class DrawBoardView;

@protocol DrawBoardViewDelegate <NSObject>

@optional
/**
 *  保存按钮点击触发的事件，通过代理来实现
 *
 *  @param drawBoardView
 *  @param saveBtn
 */
- (void)drawBoardView:(DrawBoardView *)drawBoardView saveBtnClick:(CommonlyUsedBtn *)saveBtn;
/**
 * 删除按钮点击触发的事件，通过代理来实现
 *
 *  @param drawBoardView drawBoardView
 *  @param deleteBtn     deleteBtn
 */
- (void)drawBoardView:(DrawBoardView *)drawBoardView deleteBtnClick:(CommonlyUsedBtn *)deleteBtn;
/**
 *  返回按钮点击事件触发，通过代理来实现
 *
 *  @param drawBoardView drawBoardView
 *  @param dismissBtn    dismissBtn
 */
- (void)drawBoardView:(DrawBoardView *)drawBoardView dismissBtnClick:(CommonlyUsedBtn *)dismissBtn;
@end

typedef enum {
    DrawBoardViewTypeNote,
    DrawBoardViewTypeDrawingBoardQuestion,
    DrawBoardViewTypeDraftPaper,
    DrawBoardViewTypeImageEditing,
    DrawBoardViewTypeChoiceQuestionDraftPaper,//选择题草稿纸
}DrawBoardViewType;

@interface DrawBoardView : UIView <DrawViewDelegate>
@property (copy, nonatomic) CreateGestureBlock createGestureBlock;
/**
 *  保存按钮点击的代理
 */
@property (weak, nonatomic) id<DrawBoardViewDelegate> delegate;
/**
 *  画板类型
 */
@property (assign, nonatomic) DrawBoardViewType drawBoardType;
/**
 *  画板工具条
 */
@property (strong, nonatomic) DrawToolView * drawToolBar;
/**
 *  画板
 */
@property (strong, nonatomic) DrawBoardQuestionView * draw;
@property (strong, nonatomic) DrawBoardQuestionView * draw2;
/**
 *  大的画板背景
 */
@property (strong, nonatomic) UIView *bigView;
/**
 *  画板的背景图片
 */
@property (strong, nonatomic) UIImage * image;
//原始图的保存路径
@property (strong, nonatomic) NSString *saveImagePath;
//缩略图的保存路径
@property (strong, nonatomic) NSString *saveThumbImagePath;
/**
 *  是画板题中的截屏题
 */
@property (assign, nonatomic) BOOL isImageQuestion;

- (instancetype)initWithFrame:(CGRect)frame andDrawBoardViewType:(DrawBoardViewType)drawBoardViewType;
/**
 *  保存图片
 */
- (NSData *)saveDrawBoardQuestionImageWithCompressionRatio:(CGFloat)compressionRatio;
/**
 *  将图片转换成base64字符串
 *
 *  @param compressionRatio 图片压缩比率
 *
 *  @return 返回base64字符串
 */
- (NSString *)getBase64StringConvertedByImageWithCompressionRatio:(CGFloat)compressionRatio;
/**
 *  双指滑动手势
 *
 *  @param swipe
 */
- (void)swipe:(UISwipeGestureRecognizer *)swipe;
/**
 *  将第二张画板从父视图移除
 */
- (void)removeDraw2FromSuperView;
@end