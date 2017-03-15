//
//  Drawboard_Mini.m
//  StudentClient
//
//  Created by 张真 on 16/9/7.
//  Copyright © 2016年 lirenkj. All rights reserved.
//

#import "Drawboard_Mini.h"
#import "UIView+Category.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
@interface Drawboard_Mini()<DrawViewDelegate>

@property (strong, nonatomic) CommonlyUsedBtn *recordBtn;
@property (assign, nonatomic) CGFloat drawViewY;
@property (assign, nonatomic) CGFloat drawViewHeight;
@end

@implementation Drawboard_Mini
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initParameter];
        [self createUI];
        [self addSwipeGesture];
    }
    return self;
}
#pragma mark ->初始化参数
- (void)initParameter
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    _btns = [NSMutableArray array];
}
#pragma mark ->初始化UI
- (void)createUI
{
    UIView *drawToolBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
    drawToolBar.backgroundColor = RGB(200, 200, 200);
    NSArray *normalImageName = @[@"ic_bruch_nomal",@"ic_eraser_nomal",@"ic_recall_nomal",@"ic_back_nomal",@"ic_conserve"];
    NSArray *selectImageNames = @[@"ic_bruch",@"ic_eraser_select",@"ic_recall_select",@"ic_back_select",@"ic_conserve_select"];
    NSArray *tags = @[@100,@104,@103,@106,@105];
    for (int i = 0; i < 5; i ++)
    {
        CGFloat x = i * self.width / 5;
        CGFloat y = 0;
        CGFloat w = self.width / 5;
        CGFloat h = drawToolBar.height;
        CommonlyUsedBtn *btn = [[CommonlyUsedBtn alloc]initWithFrame:CGRectMake(x, y, w, h) normalImageName:normalImageName[i] selectImageName:selectImageNames[i] btnType:CommonlyUsedBtnTypeImageLeft textLabelFont:0 title:nil];
        btn.tag = [tags[i] integerValue];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [drawToolBar addSubview:btn];
        if (i == 0)
        {
            _recordBtn = btn;
            btn.selected = YES;
        }
        [_btns addObject:btn];
    }
    [self addSubview:drawToolBar];
    _drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, drawToolBar.maxY, self.width, (self.height - drawToolBar.height) * 2)];
    _drawViewY = _drawView.y;
    _drawViewHeight = _drawView.height / 2;
    _drawView.backgroundColor = [UIColor clearColor];
    _drawView.delegate = self;
    [self addSubview:_drawView];
    [self bringSubviewToFront:drawToolBar];
}
/*
 *tags备注：100：任意线条的线宽选择，101：颜色选择，102：图形选择，103：后退一步，104：橡皮擦得粗细选择，105：保存图片，106：前进一步107：清空所有线条
 *         108：退出当前控制器
 */
#pragma mark ->工具条按钮点击
- (void)btnClick:(CommonlyUsedBtn *)btn
{
    _recordBtn.selected = NO;
    btn.selected = YES;
    _recordBtn = btn;
    switch (btn.tag)
    {
        case 100:
        {
            _drawView.drawType = [DrawingAnyLine class];
            _drawView.strokeAnylineWidth = 2;
            break;
        }
        case 103:
        {
            [_drawView removeDrawingObject:nil];
            break;
        }
        case 104:
        {
            _drawView.drawType = [EraserLine class];
            _drawView.strokeEraserWidth = 50;
            break;
        }
        case 105:
        {
            if ([self.delegate respondsToSelector:@selector(drawboard_Mini:saveBtnClick:)])
            {
                [self.delegate drawboard_Mini:self saveBtnClick:_btns[4]];
            }
            break;
        }
        case 106:
        {
            [_drawView goForward];
            break;
        }
        default:
            break;
    }
}
#pragma mark- 添加滑动手势
- (void)addSwipeGesture
{
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scroll:)];
    swipeUp.numberOfTouchesRequired = 2;
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [_drawView addGestureRecognizer:swipeUp];
    
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(scroll:)];
    swipeDown.numberOfTouchesRequired = 2;
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [_drawView addGestureRecognizer:swipeDown];
}
- (void)scroll:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {//向上
        [UIView animateWithDuration:0.25 animations:^{
            
            _drawView.y = _drawViewY - _drawViewHeight;
        }];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionDown)
    {//向下
        [UIView animateWithDuration:0.25 animations:^{
            
            _drawView.y = _drawViewY;
        }];
    }
    else
    {
        return;
    }
}
#pragma mark ->DrawViewDelegate
- (void)changeDrawToolBarBtnState
{
    CommonlyUsedBtn *goBackBtn = nil;
    CommonlyUsedBtn *goforwardBtn = nil;

    for (CommonlyUsedBtn *btn in _btns)
    {
        if (btn.tag == 106)
        {
            goforwardBtn = btn;
        }
        if (btn.tag == 103)
        {
            goBackBtn = btn;
        }
    }
    if (_drawView.drawingObjects.count > 0 && _drawView.goForwardObjects.count > 0)
    {
        
        goBackBtn.enabled = YES;
        goforwardBtn.enabled = YES;
        //        clearAllBtn.enabled = YES;
        
    }
    else if (_drawView.drawingObjects.count > 0 && _drawView.goForwardObjects.count <= 0)
    {
        goBackBtn.enabled = YES;
        goforwardBtn.enabled = NO;
        //        clearAllBtn.enabled = YES;
    }
    else if (_drawView.drawingObjects.count <= 0 && _drawView.goForwardObjects.count > 0)
    {
        goBackBtn.enabled = NO;
        goforwardBtn.enabled = YES;
        //        clearAllBtn.enabled = NO;
    }
    else if (_drawView.drawingObjects.count <= 0 && _drawView.goForwardObjects.count <= 0)
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
#pragma mark- dealloc
- (void)dealloc
{
    self.delegate = nil;
    self.btns = nil;
    NSLog(@"迷你画板已经销毁");
}
@end
