//
//  DrawTypeBar.m
//  Students_iOS
//
//  Created by 张真 on 16/5/24.
//  Copyright © 2016年 all. All rights reserved.
//
#import "DrawTypeBar.h"
#import "ImageUtil.h"
#import "UIView+Category.h"
@interface DrawTypeBar()

@property (strong, nonatomic) Class cla;

@property (assign, nonatomic) CGFloat lineWidth;

@end

@implementation DrawTypeBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 11 * 2 + itemWidth * 6 + DrawToolBarMagon * 5, DrawTypeBarHeight)])
    {
        
        self.drawTypes = @[[DrawingRectangle class],[DrawNormalCircle class],[DrawingLine class],[DrawTriangle class],[DrawCylinder class],[DrawCube class]];
        self.cla = [DrawingRectangle class];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    //创建图形选择的按钮
    for (int i = 0; i < 6; i ++) {
        CGFloat itemW = itemWidth;
        CGFloat itemX = 11 + i * (itemWidth + DrawToolBarMagon);
        CGFloat itemY = SCREEN_HEIGHT * 22 / 1536;
        CGFloat itemH = itemWidth;
        NSArray *backImageName = @[@"ic_shape_square_white",@"ic_shape_circle_white",@"ic_shape_ine_white",@"ic_shape_triangle_white",@"Ic_shape_pillar_white",@"Ic_shape_cube_white"];
        NSArray *backHighlightedImageName = @[@"ic_shape_square_yellow",@"ic_shape_circle_yellow",@"ic_shape_line_yellow",@"ic_shape_triangle_yellow",@"Ic_shape_pillar_yellow",@"Ic_shape_cube_yellow"];
        CommonlyUsedBtn *btn = [[CommonlyUsedBtn alloc]initWithFrame:CGRectMake(itemX, itemY, itemW, itemH) normalImageName:backImageName[i] selectImageName:backHighlightedImageName[i] btnType:CommonlyUsedBtnTypeImageRight textLabelFont:0 title:nil];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0)
        {
            [btn setSelected:YES];
            self.recoderBtn = btn;
        }
    }
    //创建线宽选择的滑动条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(13.5, self.height - 24 - 11, self.width - 13.5 * 2, 12)];
    [slider addTarget:self action:@selector(changelineWidth:) forControlEvents:UIControlEventValueChanged];
    [slider setMinimumTrackTintColor:RGB(6, 101, 145)];
    [slider setMaximumTrackTintColor:RGB(19, 29, 44)];
    [slider setThumbImage:[self OriginImage: [ImageUtil getImageByName:@"ic_eraser_bt"] scaleToSize:CGSizeMake(12, 12)] forState:UIControlStateNormal];
    slider.minimumValue = 2;
    slider.maximumValue = 10;
    slider.value = self.lineWidth = 2;
    [self addSubview:slider];
    [self createLabel];
}
- (void)createLabel
{
    for (int i = 0; i < 4; i ++)
    {
        CGFloat labelX = 13.5 + i * (8 +(self.width - 4 * 8 - 13.5 * 2) / 3);
        CGFloat labelY = self.height - 11 - 12;
        CGFloat labelW = 8;
        CGFloat labelH = 12;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.text = [NSString stringWithFormat:@"%d",i + 1];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = RGB(107, 123, 137);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}
- (void)btnClick:(CommonlyUsedBtn *)btn
{
    self.recoderBtn.selected = NO;
    btn.selected = YES;
    self.recoderBtn = btn;
    self.cla = self.drawTypes[btn.tag - 200];
    self.drawTypeAndLineWidthBlock(self.cla, self.lineWidth);
}
- (void)changelineWidth:(UISlider *)slider
{
    self.lineWidth = slider.value;
    self.drawTypeAndLineWidthBlock(self.cla, self.lineWidth);
}

-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size
{
    
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
@end
