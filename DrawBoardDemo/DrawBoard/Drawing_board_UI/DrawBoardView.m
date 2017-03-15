//
//  DrawBoardView.m
//  StudentClient
//
//  Created by zhangzhen on 16/6/18.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import "DrawBoardView.h"
#import "GTMBase64.h"
#import "ImageUtil.h"
@interface DrawBoardView()

@property (strong, nonatomic) UIView *mengBan;

@property (strong, nonatomic) NSArray * widthArray;

@property (strong, nonatomic) NSArray * eraserWidthArray;


@end

@implementation DrawBoardView

- (instancetype)initWithFrame:(CGRect)frame andDrawBoardViewType:(DrawBoardViewType)drawBoardViewType
{
    _drawBoardType = drawBoardViewType;
    
    if (self = [super initWithFrame:frame])
    {
        _widthArray = @[@2,@4,@6,@8,@10];
        _eraserWidthArray = @[@10,@20,@30,@40,@50];
        self.backgroundColor = [UIColor clearColor];
        
        [self createUI];
    }
    return self;
}

- (void)hiddenMengBan:(UITapGestureRecognizer *)tap
{
    self.mengBan.hidden = YES;
    //隐藏底部工具栏
    [self.drawToolBar hiddenDrawToolBar];
    
}
- (void)createUI
{
    [self createBigView];
    [self createMengBan];
    [self createDrawToolBar];
}
- (void)createMengBan
{
    _mengBan = [[UIView alloc]initWithFrame:self.draw.frame];
    _mengBan.backgroundColor = [UIColor whiteColor];
    _mengBan.alpha = 0.2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMengBan:)];
    [_mengBan addGestureRecognizer:tap];
    _mengBan.hidden = YES;
    [self addSubview:_mengBan];
    
}
- (void)createBigView
{
    CGRect bigViewRect = CGRectZero;
    if (self.drawBoardType == DrawBoardViewTypeDraftPaper)
    {
        bigViewRect = CGRectMake(0, DrawToolBarHeight, self.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeNote)
    {
        bigViewRect = CGRectMake(0, 0, self.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        bigViewRect = CGRectMake(0, 0, self.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeImageEditing)
    {
        bigViewRect = CGRectMake(0, 0, self.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeChoiceQuestionDraftPaper)
    {
        bigViewRect = CGRectMake(0, DrawToolBarHeight, self.width, self.height - DrawToolBarHeight);
    }
    _bigView = [[UIView alloc]initWithFrame:bigViewRect];
    _bigView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bigView];
    if (_drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        upSwipe.numberOfTouchesRequired = 2;
        
        upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
        [_bigView addGestureRecognizer:upSwipe];
        
        UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        downSwipe.numberOfTouchesRequired = 2;
        downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
        [_bigView addGestureRecognizer:downSwipe];
    }
    CGRect rect = CGRectZero;
    if (self.drawBoardType == DrawBoardViewTypeDraftPaper)
    {
        rect = CGRectMake(0, 0, _bigView.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeNote)
    {
        rect = CGRectMake(0, 0, _bigView.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        rect = CGRectMake(0, 0, _bigView.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeImageEditing)
    {
        rect = CGRectMake(0, 0, _bigView.width, self.height - DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeChoiceQuestionDraftPaper)
    {
        rect = CGRectMake(0, 0, _bigView.width, self.height - DrawToolBarHeight);
    }
    DrawBoardQuestionView * draw = [[DrawBoardQuestionView alloc]initWithFrame:rect];
    draw.image = self.image;
    draw.drawView.strokeAnylineWidth = 5;
    draw.drawView.delegate = self;
    [self addSubview:draw];
    self.draw = draw;
    [_bigView addSubview:draw];
}
#pragma mark ->重写image的set方法
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.draw.image = image;
}
#pragma mark ->滑动手势
- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    if (self.bigView.height == self.draw.height)
    {
        if (swipe.direction == UISwipeGestureRecognizerDirectionDown)
        {
            return;
        }
        else
        {
            self.bigView.height = self.draw.height * 2;
        }
    }
    CGRect currentRect = self.bigView.frame;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        if (self.draw2 == nil)
        {//如果没有新增画板，创建一个新的画板
            DrawBoardQuestionView * draw2 = [[DrawBoardQuestionView alloc]initWithFrame:CGRectMake(0, self.draw.height, _bigView.width, self.draw.height)];
            if (_isImageQuestion)
            {//是教师端截屏题目
                draw2.image = nil;
            }
            else
            {//不是教师端截屏题目
                draw2.image = self.image;
            }
            draw2.drawView.strokeAnylineWidth = _draw.drawView.strokeAnylineWidth;
            draw2.drawView.drawType = _draw.drawView.drawType;
            draw2.drawView.strokeEraserWidth = _draw.drawView.strokeEraserWidth;
            draw2.drawView.strokeObjectWidth = _draw.drawView.strokeObjectWidth;
            draw2.drawView.strokeColor = _draw.drawView.strokeColor;
            draw2.drawView.delegate = self;
            [_bigView addSubview:draw2];
            self.draw2 = draw2;
            //给画板题的蒙版添加一个向上和向下的手势
            self.createGestureBlock();
        }
        if (currentRect.origin.y <= - self.draw.height)
        {
            return;
        }
        else
        {
            currentRect.origin.y = - self.draw.height;
            [UIView animateWithDuration:0.5 animations:^{
                self.bigView.frame = currentRect;
                [self.draw.drawView setNeedsDisplay];
                [self.draw2.drawView setNeedsDisplay];
            } completion:nil];
        }
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown)
    {
        if (currentRect.origin.y >= 0)
        {
            return;
        }
        else
        {
            currentRect.origin.y = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.bigView.frame = currentRect;
                [self.draw.drawView setNeedsDisplay];
                [self.draw2.drawView setNeedsDisplay];
            } completion:nil];
        }
    }
}
- (void)removeDraw2FromSuperView
{
    self.draw2 = nil;
    if (self.drawBoardType == DrawBoardViewTypeDraftPaper)
    {
        self.bigView.y = DrawToolBarHeight;
        
    }
    else if (self.drawBoardType == DrawBoardViewTypeNote)
    {
        self.bigView.y = 0;
        
    }
    else if (self.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        self.bigView.y = 0;
    }
    else if (self.drawBoardType == DrawBoardViewTypeImageEditing)
    {
        self.bigView.y = 0;
    }
    else if (self.drawBoardType == DrawBoardViewTypeChoiceQuestionDraftPaper)
    {
        self.bigView.y = DrawToolBarHeight;
    }
    self.bigView.height = self.draw.height;
    
}
#pragma mark ->初始化工具条
- (void)createDrawToolBar
{
    NSArray *normalImageNames = nil;
    NSArray *selectImageNames = nil;
    NSArray *tags = nil;
    CGRect rect = CGRectZero;
    DrawToolBarposition position;
    if (self.drawBoardType == DrawBoardViewTypeDraftPaper)
    {
        position = DrawToolBarpositionUp;
        normalImageNames = @[@"ic_triangle_nomal_draw",@"ic_bruch_nomal",@"ic_colour_nomal",@"ic_shape_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal",@"ic_delete_nomal_draw",@"ic_conserve"];
        selectImageNames = @[@"ic_triangle_nomal_draw",@"ic_bruch",@"ic_colour_select",@"ic_shape_select",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select",@"ic_delete_nomal_draw",@"ic_conserve_select"];
        
        tags = @[@108,@100,@101,@102,@104,@103,@106,@107,@105];
        rect = CGRectMake(0, 0, self.width, DrawToolBarHeight);
        
    }
    else if (self.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        position = DrawToolBarpositionDown;
        normalImageNames = @[@"ic_bruch_nomal",@"ic_colour_nomal",@"ic_shape_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal",@"ic_submit"];
        selectImageNames = @[@"ic_bruch",@"ic_colour_select",@"ic_shape_select",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select",@"ic_submit"];
        tags = @[@100,@101,@102,@104,@103,@106,@105];
        rect = CGRectMake(0, self.height - DrawToolBarHeight, self.width, DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeNote)
    {
        position = DrawToolBarpositionDown;
        normalImageNames = @[@"ic_bruch_nomal",@"ic_colour_nomal",@"ic_shape_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal",@"ic_conserve"];
        selectImageNames = @[@"ic_bruch",@"ic_colour_select",@"ic_shape_select",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select",@"ic_conserve_select"];
        tags = @[@100,@101,@102,@104,@103,@106,@105];
        rect = CGRectMake(0, self.height - DrawToolBarHeight, self.width, DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeImageEditing)
    {
        position = DrawToolBarpositionDown;
        normalImageNames = @[@"ic_cancel1",@"ic_bruch_nomal",@"ic_colour_nomal",@"ic_shape_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal",@"ic_conserve"];
        selectImageNames = @[@"ic_cancel1",@"ic_bruch",@"ic_colour_select",@"ic_shape_select",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select",@"ic_conserve_select"];
        tags = @[@108,@100,@101,@102,@104,@103,@106,@105];
        rect = CGRectMake(0, self.height - DrawToolBarHeight, self.width, DrawToolBarHeight);
    }
    else if (self.drawBoardType == DrawBoardViewTypeChoiceQuestionDraftPaper)
    {//选择题
        position = DrawToolBarpositionUp;
        normalImageNames = @[@"ic_cancel1",@"ic_bruch_nomal",@"ic_colour_nomal",@"ic_shape_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal"];
        selectImageNames = @[@"ic_cancel1",@"ic_bruch",@"ic_colour_select",@"ic_shape_select",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select"];
        tags = @[@108,@100,@101,@102,@104,@103,@106];
        rect = CGRectMake(0, 0, self.width, DrawToolBarHeight);
    }
    __weak DrawBoardView *weakSelf = self;
    DrawToolView *drawToolBar = [[DrawToolView alloc]initWithFrame:rect drawToolBarposition:position drawTypeAndLineWidthSelectBlock:^(__unsafe_unretained Class cla, CGFloat lineWidth) {
        weakSelf.draw.drawView.drawType = cla;
        weakSelf.draw2.drawView.drawType = cla;
        weakSelf.draw.drawView.strokeObjectWidth = lineWidth;
        weakSelf.draw2.drawView.strokeObjectWidth = lineWidth;
        
    } drawAnyLineWidthBlock:^(CGFloat drawWidth) {
        weakSelf.draw.drawView.drawType = [DrawingAnyLine class];
        weakSelf.draw2.drawView.drawType = [DrawingAnyLine class];
        weakSelf.draw.drawView.strokeAnylineWidth = drawWidth;
        weakSelf.draw2.drawView.strokeAnylineWidth = drawWidth;
        
    } colorSelectBlock:^(UIColor *selectColor) {
        weakSelf.draw.drawView.strokeColor = selectColor;
        weakSelf.draw2.drawView.strokeColor = selectColor;
    } eraserWidthSelect:^(CGFloat eraserWidth) {
        weakSelf.draw.drawView.drawType = [EraserLine class];
        weakSelf.draw.drawView.strokeEraserWidth = eraserWidth;
        weakSelf.draw2.drawView.drawType = [EraserLine class];
        weakSelf.draw2.drawView.strokeEraserWidth = eraserWidth;
    } goBackBlock:^{
        if (weakSelf.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
        {
            if (weakSelf.bigView.y == 0)
            {
                [weakSelf.draw.drawView removeDrawingObject:nil];
            }
            else
            {
                [weakSelf.draw2.drawView removeDrawingObject:nil];
            }
        }
        else
        {
            [weakSelf.draw.drawView removeDrawingObject:nil];
        }
        
    } saveImageBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(drawBoardView:saveBtnClick:)])
        {
            CommonlyUsedBtn *btn = [weakSelf.drawToolBar.drawToolBar viewWithTag:105];
            [weakSelf.delegate drawBoardView:weakSelf saveBtnClick:btn];
        }
    } goforwardBlock:^{
        if (weakSelf.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
        {
            if (weakSelf.bigView.y == 0)
            {
                [weakSelf.draw.drawView goForward];
            }
            else
            {
                [weakSelf.draw2.drawView goForward];
            }
        }
        else
        {
            [weakSelf.draw.drawView goForward];
        }
        
    } clearAllBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(drawBoardView:deleteBtnClick:)])
        {
            CommonlyUsedBtn *btn = [weakSelf.drawToolBar.drawToolBar viewWithTag:107];
            [weakSelf.delegate drawBoardView:weakSelf deleteBtnClick:btn];
        }
    } dissmissVCBlock:^{
        if (weakSelf.drawBoardType == DrawBoardViewTypeNote)
        {
//            [self popToViewController:nil isRoot:NO];
            
            //[weakSelf removeFromSuperview];
            NSLog(@"任意发挥");
        }
        else if (weakSelf.drawBoardType == DrawBoardViewTypeDraftPaper)
        {
            [weakSelf removeFromSuperview];
        }
        else
        {
            if ([weakSelf.delegate respondsToSelector:@selector(drawBoardView:dismissBtnClick:)])
            {
                CommonlyUsedBtn *btn = [weakSelf.drawToolBar.drawToolBar viewWithTag:108];
                [weakSelf.delegate drawBoardView:weakSelf dismissBtnClick:btn];
            }
        }
    }];
    drawToolBar.drawAnyLineBlock = ^(CGFloat width){
        weakSelf.draw.drawView.drawType = [DrawingAnyLine class];
        weakSelf.draw.drawView.strokeAnylineWidth = width;
        weakSelf.draw2.drawView.drawType = [DrawingAnyLine class];
        weakSelf.draw2.drawView.strokeAnylineWidth = width;
    };
    drawToolBar.drawEraser = ^(CGFloat drawWidth){
        weakSelf.draw.drawView.drawType = [EraserLine class];
        weakSelf.draw.drawView.strokeEraserWidth = drawWidth;
        weakSelf.draw2.drawView.drawType = [EraserLine class];
        weakSelf.draw2.drawView.strokeEraserWidth = drawWidth;
    };
    drawToolBar.showMengBanBlock = ^{
        weakSelf.mengBan.hidden = NO;
    };
    [drawToolBar createDrawToolBarWithNormalImageNames:normalImageNames selectImageNames:selectImageNames tags:tags];
    
    [self addSubview:drawToolBar];
    
    self.drawToolBar = drawToolBar;
}
#pragma mark ->DrawViewDelegate
- (void)changeDrawToolBarBtnState
{
    CommonlyUsedBtn *goBackBtn = nil;
    CommonlyUsedBtn *goforwardBtn = nil;
//    CommonlyUsedBtn *clearAllBtn = nil;
    for (CommonlyUsedBtn *btn in self.drawToolBar.btns)
    {
        if (btn.tag == 106)
        {
            goforwardBtn = btn;
        }
        if (btn.tag == 103)
        {
            goBackBtn = btn;
        }
//        if (btn.tag == 107)
//        {
//            clearAllBtn = btn;
//        }
    }
    DrawBoardQuestionView *draw = nil;
    if (self.drawBoardType == DrawBoardViewTypeDrawingBoardQuestion)
    {
        if (_bigView.y == 0)
        {
            draw = self.draw;
        }
        else
        {
            draw = self.draw2;
        }
    }
    else
    {
        draw = self.draw;
    }
    
    if (draw.drawView.drawingObjects.count > 0 && draw.drawView.goForwardObjects.count > 0)
    {
        
        goBackBtn.enabled = YES;
        goforwardBtn.enabled = YES;
//        clearAllBtn.enabled = YES;
        
    }
    else if (draw.drawView.drawingObjects.count > 0 && draw.drawView.goForwardObjects.count <= 0)
    {
        goBackBtn.enabled = YES;
        goforwardBtn.enabled = NO;
//        clearAllBtn.enabled = YES;
    }
    else if (draw.drawView.drawingObjects.count <= 0 && draw.drawView.goForwardObjects.count > 0)
    {
        goBackBtn.enabled = NO;
        goforwardBtn.enabled = YES;
//        clearAllBtn.enabled = NO;
    }
    else if (draw.drawView.drawingObjects.count <= 0 && draw.drawView.goForwardObjects.count <= 0)
    {
        goBackBtn.enabled = NO;
        goforwardBtn.enabled = NO;
//        clearAllBtn.enabled = NO;
    }
    else
    {
        return;
    }
}

- (NSData *)saveDrawBoardQuestionImageWithCompressionRatio:(CGFloat)compressionRatio
{
    if (self.draw2 == nil) {
        return [self.draw saveImageToDataCompressionRatio:compressionRatio];
    }
    else
    {
        UIImage *image1 = [self.draw getSnapshotImage];
        UIImage *image2 = [self.draw2 getSnapshotImage];
        UIImage *image = [ImageUtil composeImage:image1 secondImage:image2];
        return [ImageUtil convertImageToDataWithImage:image CompressionRatio:compressionRatio];
    }
}
- (NSString *)getBase64StringConvertedByImageWithCompressionRatio:(CGFloat)compressionRatio
{
    NSData *imageData = [self saveDrawBoardQuestionImageWithCompressionRatio:compressionRatio];
    return [GTMBase64 encodeBase64Data:imageData];
}
- (void)dealloc
{
    self.delegate = nil;
    NSLog(@"drawBoard已经dealloc");
}
@end

