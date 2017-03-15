//
//  DrawToolView.m
//  Students_iOS
//
//  Created by 张真 on 16/5/25.
//  Copyright © 2016年 all. All rights reserved.
//

#import "DrawToolView.h"
#import "DrawTypeBar.h"
@interface DrawToolView()

@property (strong, nonatomic) DrawToolBar *currentToolBar;

@property (strong, nonatomic) NSArray * drawTypes;

@property (strong, nonatomic) id currentDrawObject;

@property (assign, nonatomic) CGFloat lineWidth;

@property (assign, nonatomic) CGFloat eraserWidth;
@end

@implementation DrawToolView
#pragma mark ->初始化方法
- (instancetype)initWithFrame:(CGRect)frame drawToolBarposition:(DrawToolBarposition)drawToolBarposition drawTypeAndLineWidthSelectBlock:(DrawTypeAndLineWidthSelectBlock)drawTypeAndLineWidthSelectBlock drawAnyLineWidthBlock:(DrawAnylineWidthSelectBlock)drawAnylineWidthSelectBlock colorSelectBlock:(colorSelectBlock)colorSelectBlock eraserWidthSelect:(EraserWidthSelect)eraserWidthSelect goBackBlock:(GoBackBlock)goBackBlock saveImageBlock:(SaveImageBlock)saveImageBlock goforwardBlock:(GoForwardBlock)goforwardBlock clearAllBlock:(ClearAllBlock)clearAllBlock dissmissVCBlock:(DismissVCBlock)dissmissVCBlock
{
    if (self = [super initWithFrame:frame])
    {
        _toolBarPosition = drawToolBarposition;
        _drawtypeAndLineWidthBlock = drawTypeAndLineWidthSelectBlock;
        _anylineWithSelectBlock = drawAnylineWidthSelectBlock;
        _colorSelect = colorSelectBlock;
        _eraserBlock = eraserWidthSelect;
        _goBackBlock = goBackBlock;
        _saveImageBlock = saveImageBlock;
        _goForwardBlock = goforwardBlock;
        _clearAllBlock = clearAllBlock;
        _dissmissVCBlock = dissmissVCBlock;
        _lineWidth = 2;
        _eraserWidth = 20;
    }
    return self;
}
#pragma mark ->懒加载
- (NSMutableArray *)btns
{
    
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (DrawEraserBar *)eraserSelectBar
{
    if (_eraserSelectBar == nil) {
        _eraserSelectBar = [[DrawEraserBar alloc]init];
        if (_toolBarPosition == DrawToolBarpositionUp)
        {
            _eraserSelectBar.y = DrawToolBarHeight;
        }
        else
        {
            _eraserSelectBar.y = 0;
        }
        CommonlyUsedBtn *btn = [self.drawToolBar viewWithTag:104];
        _eraserSelectBar.centerX = btn.centerX;
        [self addSubview:_eraserSelectBar];
    }
    return _eraserSelectBar;
}
- (DrawTypeBar *)typeSelectBar
{
    if (_typeSelectBar == nil) {
        _typeSelectBar = [[DrawTypeBar alloc]init];
        if (_toolBarPosition == DrawToolBarpositionUp)
        {
            _typeSelectBar.y = DrawToolBarHeight;
        }
        else
        {
            _typeSelectBar.y = 0;
        }
        CommonlyUsedBtn *btn = [self.drawToolBar viewWithTag:102];
        _typeSelectBar.centerX = btn.centerX + 50;
        
        [self addSubview:_typeSelectBar];
    }
    return _typeSelectBar;
}
- (DrawColorBar *)colorSelectBar
{
    if (_colorSelectBar == nil) {
        _colorSelectBar = [[DrawColorBar alloc]init];
        if (_toolBarPosition == DrawToolBarpositionUp)
        {
            _colorSelectBar.y = DrawToolBarHeight;
        }
        else
        {
            _colorSelectBar.y = 0;
        }
        CommonlyUsedBtn *btn = [self.drawToolBar viewWithTag:101];
        _colorSelectBar.centerX = btn.centerX + 100;

        [self addSubview:_colorSelectBar];
    }
    return _colorSelectBar;
}
- (DrawAnylineBar *)anylineWidthSelectBar
{
    if (_anylineWidthSelectBar == nil) {
        _anylineWidthSelectBar = [[DrawAnylineBar alloc]init];
        _anylineWidthSelectBar.x = 0;
        if (_toolBarPosition == DrawToolBarpositionUp)
        {
            _anylineWidthSelectBar.y = DrawToolBarHeight;
        }
        else
        {
            _anylineWidthSelectBar.y = 0;
        }
        [self addSubview:_anylineWidthSelectBar];
    }
    return _anylineWidthSelectBar;
}

#pragma mark ->初始化工具条
- (void)createDrawToolBarWithNormalImageNames:(NSArray *)normalImageNames selectImageNames:(NSArray *)selectImageNames tags:(NSArray *)tags
{
    _drawToolBar = [[UIView alloc]init];
    _drawToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, DrawToolBarHeight);
    _drawToolBar.backgroundColor = RGB(46, 69, 101);
    [self createUIWithNormalImageNames:normalImageNames selectImageNames:selectImageNames tags:tags];
    [self addSubview:_drawToolBar];
}
#pragma mark ->初始化工具条上的按钮
- (void)createUIWithNormalImageNames:(NSArray *)normalImageNames selectImageNames:(NSArray *)selectImageNames tags:(NSArray *)tags
{
    for (int i = 0; i < normalImageNames.count; i ++)
    {
        CGFloat toolItemWidth = (SCREEN_WIDTH - DrawToolBarMagon * 2) / normalImageNames.count;
        CGFloat itemHeight = DrawToolBarHeight;
        CGFloat itemY = 0;
        CGFloat itemX = DrawToolBarMagon + i * toolItemWidth;
        CommonlyUsedBtn *btn = [[CommonlyUsedBtn alloc]initWithFrame:CGRectMake(itemX , itemY, toolItemWidth, itemHeight) normalImageName:normalImageNames[i] selectImageName:selectImageNames[i] btnType:CommonlyUsedBtnTypeImageLeft textLabelFont:0 title:nil];
        
        btn.tag = [tags[i] integerValue];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (btn.tag == 100)
        {
            [btn setSelected:YES];
            self.recodeBtn = btn;
        }
        [self.btns addObject:btn];
        [self.drawToolBar addSubview:btn];
    }
}
#pragma mark ->工具条上的按钮点击监听
- (void)btnClick:(CommonlyUsedBtn *)btn
{
    self.recodeBtn.selected = NO;
    
    btn.selected = YES;
    
    self.recodeBtn = btn;
    
    __weak DrawToolView * weakSelf = self;
    
    switch (btn.tag)
    {
        case 100:
        {
            //任意线条的线宽选择
            self.currentToolBar.hidden = YES;
            self.anylineWidthSelectBar.hidden = NO;
            self.currentToolBar = self.anylineWidthSelectBar;
            
            self.height = DrawAnylineBarHeight + DrawToolBarHeight;
            
            if (_toolBarPosition == DrawToolBarpositionUp)
            {
                
            }
            else
            {
                self.y = self.superview.height - self.height;
                self.drawToolBar.y = DrawAnylineBarHeight;
            }
            self.anylineWidthSelectBar.hidden = !btn.selected;
            self.anylineWidthSelectBar.drawAnylineBlock = ^(CGFloat widthSelect){
                weakSelf.anylineWithSelectBlock(widthSelect);
                weakSelf.lineWidth = widthSelect;
            };
            self.anylineWithSelectBlock(self.lineWidth);
            self.showMengBanBlock();
            break;
        }
        case 101:
        {
            //颜色选择
            self.currentToolBar.hidden = YES;
            self.colorSelectBar.hidden = NO;
            self.currentToolBar = self.colorSelectBar;
            self.height = DrawColorBarHeight + DrawToolBarHeight;
            if (_toolBarPosition == DrawToolBarpositionUp)
            {
                
            }
            else
            {
                self.y = self.superview.height - self.height;
                self.drawToolBar.y = DrawColorBarHeight;
            }
            self.colorSelectBar.hidden = !btn.selected;
            self.colorSelectBar.colorSelect = ^(UIColor * colorSelect){
                weakSelf.colorSelect(colorSelect);
            };
            self.showMengBanBlock();
            break;
        }
        case 102:
        {
            //图形选择
            self.currentToolBar.hidden = YES;
            self.typeSelectBar.hidden = NO;
            self.currentToolBar =self.typeSelectBar;
            self.height = self.typeSelectBar.height + DrawToolBarHeight;
            if (_toolBarPosition == DrawToolBarpositionUp)
            {
                
            }
            else
            {
                self.y = self.superview.height - self.height;
                self.drawToolBar.y = self.typeSelectBar.height;
            }
            self.typeSelectBar.hidden = !btn.selected;
            self.typeSelectBar.drawTypeAndLineWidthBlock = ^(Class cla, CGFloat lineWidth){
                weakSelf.drawtypeAndLineWidthBlock(cla,lineWidth);
                weakSelf.currentDrawObject = cla;
            };
            if (_currentDrawObject == nil)
            {
                _currentDrawObject = [DrawingRectangle class];
            }
            self.drawtypeAndLineWidthBlock(_currentDrawObject,self.lineWidth);
            self.showMengBanBlock();
            
            break;
        }
        case 103:
        {
            //后退一步
            self.goBackBlock();
            
            [self hiddenDrawToolBar];
            break;
        }
        case 104:
        {
            //橡皮擦得粗细选择
            self.currentToolBar.hidden = YES;
            self.eraserSelectBar.hidden = NO;
            self.currentToolBar = self.eraserSelectBar;
            self.height = DrawEraserBarHeight + DrawToolBarHeight;
            if (_toolBarPosition == DrawToolBarpositionUp)
            {
                
            }
            else
            {
                self.y = self.superview.height - self.height;
                self.drawToolBar.y = DrawEraserBarHeight;
            }
            
            self.eraserSelectBar.eraserBlock = ^(CGFloat eraserWidth){
                weakSelf.eraserBlock(eraserWidth);
                weakSelf.eraserWidth = eraserWidth;
            };
            self.eraserBlock(_eraserWidth);
            self.showMengBanBlock();
            break;
        }
        case 105:
        {
            //保存图片
            self.saveImageBlock();
            [self hiddenDrawToolBar];
            break;
        }
        case 106:
        {
            //前进一步
            self.goForwardBlock();
            [self hiddenDrawToolBar];
            break;
        }
        case 107:
        {
            //清空所有线条
            self.clearAllBlock();
            [self hiddenDrawToolBar];
            break;
        }
        case 108:
        {
            //退出当前控制器
            self.dissmissVCBlock();
            [self hiddenDrawToolBar];
            break;
        }
        default:
            break;
    }
}
#pragma mark ->隐藏DrawToolBar
- (void)hiddenDrawToolBar
{
    if (self.toolBarPosition == DrawToolBarpositionDown)
    {
        self.y = self.superview.height - DrawToolBarHeight;
        self.drawToolBar.y = 0;
        self.height = DrawToolBarHeight;
        self.currentToolBar.hidden = YES;
    }
    else
    {
        self.y = 0;
        self.drawToolBar.y = 0;
        self.height = DrawToolBarHeight;
        self.currentToolBar.hidden = YES;
    }
    
}
@end
