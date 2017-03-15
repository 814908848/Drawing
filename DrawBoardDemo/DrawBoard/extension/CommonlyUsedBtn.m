//
//  CommonlyUsedBtn.m
//  Students_iOS
//
//  Created by 张真 on 16/4/27.
//  Copyright © 2016年 all. All rights reserved.
//

#import "CommonlyUsedBtn.h"
#import "ImageUtil.h"
#import "UIView+Category.h"
@interface CommonlyUsedBtn()

@property (assign, nonatomic) CGFloat  imageWidth;

@property (assign, nonatomic) CGFloat  titleWidth;

@property (assign, nonatomic) CGFloat totalWidth;

@property (assign, nonatomic) CGFloat gap;

@end

@implementation CommonlyUsedBtn

- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName btnType:(CommonlyUsedBtnType)btnType textLabelFont:(int)fontSize title:(NSString *)title;
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpProperty];
        if (normalImageName)
        {
            UIImage *image = [ImageUtil getImageByName:normalImageName];
            [self setImage:image forState:UIControlStateNormal];
            [self setImage:image forState:UIControlStateSelected];
        }
        if (selectImageName)
        {
            UIImage *image = [ImageUtil getImageByName:selectImageName];
            [self setImage:image forState:UIControlStateSelected];
        }
        
        if (fontSize == 0)
        {
            self.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        else
        {
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        if (title)
        {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (normalImageName && title.length != 0)
        {
            self.gap = 10;
        }
        else
        {
            self.gap = 0;
        }
        self.btnType = btnType;
    }
    return self;
}
#pragma mark ->重写设置title计算文字尺寸重新布局
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    self.titleWidth = [title boundingRectWithSize:CGSizeMake(0, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size.width;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    if (image)
    {
        self.imageWidth = image.size.width / 2;
    }
}

#pragma mark ->设置按钮的属性
- (void)setUpProperty
{
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setAdjustsImageWhenHighlighted:NO];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
}
#pragma mark ->按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat totalWidth = self.titleWidth + self.imageWidth + self.gap;
    if (self.btnType == CommonlyUsedBtnTypeImageRight)
    {
        CGFloat x = (self.width - totalWidth) / 2 + self.titleWidth + self.gap;
        CGFloat y = 0;
        CGFloat width = self.imageWidth;
        CGFloat height = self.height;
        return CGRectMake(x, y, width, height);
    }
    else
    {
        CGFloat x = (self.width - totalWidth) / 2;
        CGFloat y = 0;
        CGFloat width = self.imageWidth;
        CGFloat height = self.height;
        return CGRectMake(x, y, width, height);
    }
}
#pragma mark ->按钮文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat totalWidth = self.titleWidth + self.imageWidth + self.gap;
    if (self.btnType == CommonlyUsedBtnTypeImageRight)
    {
        CGFloat x = (self.width - totalWidth) / 2;
        CGFloat y = 0;
        CGFloat width = self.titleWidth;
        CGFloat height = self.height;
        return CGRectMake(x, y, width, height);
    }
    else
    {
        CGFloat x = (self.width - totalWidth) / 2 + self.imageWidth + self.gap;
        CGFloat y = 0;
        CGFloat width = self.titleWidth;
        CGFloat height = self.height;
        return CGRectMake(x, y, width, height);
    }
}

@end
