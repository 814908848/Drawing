//
//  DrawView.m
//  DrawTest
//
//  Created by 张真 on 16/3/31.
//  Copyright © 2016年 张真. All rights reserved.
//

#import "DrawView.h"
#import "FileUtil.h"
#define CubeMargon 50
#define CyLinderMargon 150
static const CGFloat kPointMinDistance = 5.0f;
static const CGFloat kPointMinDistanceSquared = kPointMinDistance * kPointMinDistance;
@interface DrawView()

//当前正在绘画的图形
@property (strong, nonatomic) DrawingObject *currentObject;
@property (strong, nonatomic) DrawingObject *currentObject1;


//圆柱的两条线
@property (strong, nonatomic) DrawingLine *currentLine;
@property (strong, nonatomic) DrawingLine *currentLine1;

//立方体的四根线

@property (strong, nonatomic) DrawingLine *cubeLine1;
@property (strong, nonatomic) DrawingLine *cubeLine2;
@property (strong, nonatomic) DrawingLine *cubeLine3;
@property (strong, nonatomic) DrawingLine *cubeLine4;


//起始点，结束点
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint endPoint;


//三角形的三条线
@property (strong, nonatomic) DrawingLine *line1;
@property (strong, nonatomic) DrawingLine *line2;
@property (strong, nonatomic) DrawingLine *line3;

//移动之前的点
@property (assign, nonatomic) CGPoint previousPoint1;
//移动之前的点
@property (assign, nonatomic) CGPoint previousPoint2;

@property (assign, nonatomic) BOOL hasMoved;
@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame])
    {
        [self initialize];
        [self initParameter];
    }
    return self;
}
- (void)initParameter
{
    self.drawType = [DrawingAnyLine class];
    self.strokeAnylineWidth = 2;
    self.strokeColor = [UIColor blackColor];
}
#pragma mark ->初始化属性
- (void)initialize
{
    _drawingObjects = [NSMutableArray array];
    _goForwardObjects = [NSMutableArray array];
    _drawObjectsArray = [NSMutableArray array];
    _goForwardObjectsArray = [NSMutableArray array];
}
#pragma mark ->添加绘画物体
- (void)addDrawingObject:(DrawingObject *)drawingObject
{
    [drawingObject addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    [drawingObject addObserver:self forKeyPath:@"beginPoint" options:NSKeyValueObservingOptionNew context:nil];
    [self.drawingObjects addObject:drawingObject];
    
}
#pragma mark ->观察frame的改变来绘画图形
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setNeedsDisplay];
}
#pragma mark ->系统方法
- (void)drawRect:(CGRect)rect
{
    //如果在编辑有编辑图片，将编辑图片画入画板中
    if (self.editImage)
    {
        [self.editImage drawInRect:self.bounds];
    }
    [self drawObjects];
    //改变工具条上的按钮状态
    if ([self.delegate respondsToSelector:@selector(changeDrawToolBarBtnState)])
    {
        [self.delegate changeDrawToolBarBtnState];
    }
}
#pragma mark ->开始绘画
- (void)drawObjects
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (DrawingObject *object in self.drawingObjects)
    {
        CGContextSaveGState(context);
        [object draw];
        CGContextRestoreGState(context);
    }
}
#pragma mark ->后退一步
- (void)removeDrawingObject:(DrawingObject *)drawingObject
{
    if (self.drawingObjects.count > 0)
    {
        DrawingObject *drawObj = [self.drawObjectsArray lastObject];
        if ([drawObj isKindOfClass:[DrawTriangle class]])
        {
            [self removeDrawObjectFromDrawingObjectsToGoForwardObjectsArrayWithInt:3];
        }
        else if ([drawObj isKindOfClass:[DrawCube class]])
        {
            [self removeDrawObjectFromDrawingObjectsToGoForwardObjectsArrayWithInt:6];
        }
        else if ([drawObj isKindOfClass:[DrawCylinder class]])
        {
            [self removeDrawObjectFromDrawingObjectsToGoForwardObjectsArrayWithInt:4];
        }
        else
        {
            [self removeDrawObjectFromDrawingObjectsToGoForwardObjectsArrayWithInt:1];
        }
        if (drawObj)
        {
            [self.goForwardObjectsArray addObject:drawObj];
            [self.drawObjectsArray removeLastObject];
        }
        
        [self setNeedsDisplay];
    }
}
#pragma mark->从图形数组中的最后一个对象移入废旧图形数组中根据不同的图形，循环不同的次数
- (void)removeDrawObjectFromDrawingObjectsToGoForwardObjectsArrayWithInt:(int)times
{
    for (int i = 0; i < times; i ++)
    {
        [self.goForwardObjects addObject:[self.drawingObjects lastObject]];
        [self.drawingObjects removeLastObject];
    }
}
#pragma mark ->前进一步
- (void)goForward
{
    if (self.goForwardObjects.count > 0)
    {
        DrawingObject *drawObj = [self.goForwardObjectsArray lastObject];
        if ([drawObj isKindOfClass:[DrawTriangle class]])
        {
            [self removeDrawObjectFromGoForwardObjectsArrayToDrawingObjectsWithInt:3];
        }
        else if ([drawObj isKindOfClass:[DrawCube class]])
        {
            [self removeDrawObjectFromGoForwardObjectsArrayToDrawingObjectsWithInt:6];
        }
        else if ([drawObj isKindOfClass:[DrawCylinder class]])
        {
            [self removeDrawObjectFromGoForwardObjectsArrayToDrawingObjectsWithInt:4];
        }
        else
        {
            [self removeDrawObjectFromGoForwardObjectsArrayToDrawingObjectsWithInt:1];
        }
        
        [self.drawObjectsArray addObject:[self.goForwardObjectsArray lastObject]];
        [self.goForwardObjectsArray removeLastObject];
        [self setNeedsDisplay];
    }
}
#pragma mark->从废旧图形数组中的最后一个对象移入图形数组中根据不同的图形，循环不同的次数
- (void)removeDrawObjectFromGoForwardObjectsArrayToDrawingObjectsWithInt:(int)times
{
    for (int i = 0; i < times; i ++)
    {
        [self.drawingObjects addObject:[self.goForwardObjects lastObject]];
        [self.goForwardObjects removeLastObject];
    }
}
#pragma mark ->移除所有线条
- (void)removeAllDrawingObject
{
    for (DrawingObject *object in _drawingObjects)
    {
        [object removeObserver:self forKeyPath:@"bounds"];
        [object removeObserver:self forKeyPath:@"beginPoint"];
        if ([object isKindOfClass:[DrawingAnyLine class]] || [object isKindOfClass:[EraserLine class]])
        {
            CGPathRelease([object path]);
        }
    }
    
    for (DrawingObject *object in _goForwardObjects)
    {
        [object removeObserver:self forKeyPath:@"bounds"];
        [object removeObserver:self forKeyPath:@"beginPoint"];
        if ([object isKindOfClass:[DrawingAnyLine class]] || [object isKindOfClass:[EraserLine class]])
        {
            CGPathRelease(object.path);
        }
    }
    [self.drawingObjects removeAllObjects];
    [self.goForwardObjects removeAllObjects];
    [self.drawObjectsArray removeAllObjects];
    [self.goForwardObjectsArray removeAllObjects];
    [self setNeedsDisplay];

    if ([self.delegate respondsToSelector:@selector(hiddenOtherMengBan)])
    {
        [self.delegate hiddenOtherMengBan];
    }
}
#pragma mark ->清楚废旧的线条数组以及废旧的图形数组
- (void)cleargoForwardObjectsArrayAndgoForwardObjects
{
    for (DrawingObject *object in _goForwardObjects)
    {
        [object removeObserver:self forKeyPath:@"bounds"];
        [object removeObserver:self forKeyPath:@"beginPoint"];
        if ([object isKindOfClass:[DrawingAnyLine class]] || [object isKindOfClass:[EraserLine class]])
        {
            CGPathRelease([object path]);
        }
    }
    [self.goForwardObjects removeAllObjects];
    [self.goForwardObjectsArray removeAllObjects];
}
#pragma mark->保存画板中的图片
- (void)saveImageToPath:(NSString *)savePath
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //  渲染自身
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //  为image设置一个上下文并且当成当前的上下文
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    
    //  上下文栈弹出创建的context
    
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    [FileUtil writeFile:savePath data:data];
}
- (void)dealloc
{
    [self removeAllDrawingObject];
    self.delegate = nil;
    
    NSLog(@"画布dealloc");
}
#pragma mark ->三角形绘画区
- (DrawingLine *)line1
{
    CGPoint point = [self point1Posation];
    if (_line1 == nil)
    {
        _line1 = [[DrawingLine alloc]initWithBeginPoint:point];
        _line1.strokeWidth = self.strokeObjectWidth;
        _line1.strokeColor = self.strokeColor;
        _line1.drawingStroke = YES;
        [self addDrawingObject:_line1];
    }
    _line1.beginPoint = point;
    return _line1;
}

- (DrawingLine *)line2
{
    CGPoint point = [self point2Posation];;
    if (_line2 == nil)
    {
        _line2 = [[DrawingLine alloc]initWithBeginPoint:point];
        _line2.strokeWidth = self.strokeObjectWidth;
        _line2.strokeColor = self.strokeColor;
        _line2.drawingStroke = YES;
        [self addDrawingObject:_line2];
    }
    _line2.beginPoint = point;
    return _line2;
}

- (DrawingLine *)line3
{
    CGPoint point = [self point3Posation];;
    if (_line3 == nil)
    {
        _line3 = [[DrawingLine alloc]initWithBeginPoint:point];
        _line3.strokeWidth = self.strokeObjectWidth;
        _line3.strokeColor = self.strokeColor;
        _line3.drawingStroke = YES;
        [self addDrawingObject:_line3];
    }
    _line3.beginPoint = point;
    return _line3;
}

- (CGPoint)point1Posation
{
    return self.startPoint;
}
- (CGPoint)point2Posation
{
    CGFloat x = self.startPoint.x - (self.endPoint.y - self.startPoint.y)*3/4 + (self.endPoint.x - self.startPoint.x);
    CGFloat y = (self.endPoint.y - self.startPoint.y)/2 + self.endPoint.y;
    return CGPointMake(x, y);
}
- (CGPoint)point3Posation
{
    CGFloat x = self.startPoint.x + (self.endPoint.y - self.startPoint.y)*3/4 + (self.endPoint.x - self.startPoint.x);
    CGFloat y = (self.endPoint.y - self.startPoint.y)/2 + self.endPoint.y;
    return CGPointMake(x, y);
}
#pragma mark ->圆柱绘画区
//左边线
- (DrawingLine *)currentLine
{
    CGPoint point = CGPointMake(self.startPoint.x, (self.startPoint.y + self.endPoint.y)/2);
    if (_currentLine == nil)
    {
        _currentLine = [[DrawingLine alloc]initWithBeginPoint:point];
        //传进来的线宽
        _currentLine.strokeWidth = self.strokeObjectWidth;
        //传进来的颜色
        _currentLine.strokeColor = self.strokeColor;
        _currentLine.drawingStroke = YES;
        
        [self addDrawingObject:_currentLine];
    }
    //该步骤很重要，因为起始点发生变化，所以，必须监听起始点的变化重新绘图；
    _currentLine.beginPoint = point;
    return _currentLine;
}
//右边线
- (DrawingLine *)currentLine1
{
    CGPoint point = CGPointMake(self.endPoint.x, (self.startPoint.y + self.endPoint.y)/2);
    if (_currentLine1 == nil)
    {
        _currentLine1 = [[DrawingLine alloc]initWithBeginPoint:point];
        _currentLine1.strokeWidth = self.strokeObjectWidth;
        _currentLine1.strokeColor = self.strokeColor;
        _currentLine1.drawingStroke = YES;
        [self addDrawingObject:_currentLine1];
    }
    _currentLine1.beginPoint = point;
    return _currentLine1;
}
#pragma mark ->立方体绘画区
//左边线
- (DrawingLine *)cubeLine1
{
    //线一的起始点
    CGPoint point = CGPointMake(self.startPoint.x, self.startPoint.y);
    if (_cubeLine1 == nil)
    {
        _cubeLine1 = [[DrawingLine alloc]initWithBeginPoint:point];
        _cubeLine1.strokeWidth = self.strokeObjectWidth;
        _cubeLine1.strokeColor = self.strokeColor;
        _cubeLine1.drawingStroke = YES;
        [self addDrawingObject:_cubeLine1];
    }
    //该步骤很重要，因为起始点发生变化，所以，必须监听起始点的变化重新绘图；
    _cubeLine1.beginPoint = point;
    return _cubeLine1;
}

//右边线
- (DrawingLine *)cubeLine2
{
    CGPoint point = CGPointMake(self.endPoint.x, self.startPoint.y);
    if (_cubeLine2 == nil)
    {
        _cubeLine2 = [[DrawingLine alloc]initWithBeginPoint:point];
        _cubeLine2.strokeWidth = self.strokeObjectWidth;
        _cubeLine2.strokeColor = self.strokeColor;
        
        _cubeLine2.drawingStroke = YES;
        [self addDrawingObject:_cubeLine2];
    }
    _cubeLine2.beginPoint = point;
    return _cubeLine2;
}
- (DrawingLine *)cubeLine3
{
    CGPoint point = CGPointMake(self.startPoint.x, self.endPoint.y);
    if (_cubeLine3 == nil)
    {
        _cubeLine3 = [[DrawingLine alloc]initWithBeginPoint:point];
        _cubeLine3.strokeWidth = self.strokeObjectWidth;
        _cubeLine3.strokeColor = self.strokeColor;
        _cubeLine3.drawingStroke = YES;
        [self addDrawingObject:_cubeLine3];
    }
    _cubeLine3.beginPoint = point;
    return _cubeLine3;
}
- (DrawingLine *)cubeLine4
{
    CGPoint point = CGPointMake(self.endPoint.x, self.endPoint.y);
    if (_cubeLine4 == nil)
    {
        _cubeLine4 = [[DrawingLine alloc]initWithBeginPoint:point];
        _cubeLine4.strokeWidth = self.strokeObjectWidth;
        _cubeLine4.strokeColor = self.strokeColor;
        _cubeLine4.drawingStroke = YES;
        [self addDrawingObject:_cubeLine4];
    }
    _cubeLine4.beginPoint = point;
    return _cubeLine4;
}
#pragma mark ->两点之间的中点
CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}
#pragma mark ->屏幕点击触发
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //0、判断是否是双指滑动
    if ([event isKindOfClass:[NSClassFromString(@"UITouchesEvent") class]])
    {
        if ([event allTouches].count > 1)
        {//如果是双指滑动画板不响应
            return;
        }
    }
    //1、判断是在屏幕上点击  还是在屏幕上滑动
    _hasMoved = NO;
    //2、清楚废旧的线条数组以及废旧的图形数组
    [self cleargoForwardObjectsArrayAndgoForwardObjects];
    
    UITouch *touch = [touches anyObject];
    _previousPoint1 = [touch previousLocationInView:self];
    _previousPoint2 = [touch previousLocationInView:self];

    CGPoint point = [touch locationInView:self];
    self.startPoint = point;
    if (CGRectContainsPoint(self.bounds, point))
    {
        //传进来的线型
        Class drawingClass = self.drawType;
        DrawingObject *object = [[drawingClass alloc]initWithBeginPoint:point];
        if ([object isKindOfClass:[EraserLine class]]) {
            object.path = CGPathCreateMutable();
            [object setStrokeWidth:_strokeEraserWidth];
            object.strokeColor = self.backgroundColor;
            object.drawingStroke = YES;
            CGPathMoveToPoint(object.path, NULL, self.startPoint.x, self.startPoint.y);
            [self addDrawingObject:object];
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawingAnyLine class]])
        {
            object.path = CGPathCreateMutable();
            object.strokeWidth = _strokeAnylineWidth;
            object.strokeColor = _strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawingRectangle class]])
        {
            object.strokeWidth = self.strokeObjectWidth;
            
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawNormalCircle class]])
        {
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawingLine class]])
        {
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawTriangle class]])
        {
            self.currentObject = object;
        }
        else if ([object isKindOfClass:[DrawCylinder class]])
        {
            //上边的椭圆
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
            
            //下面的椭圆
            CGPoint point1 = CGPointMake(point.x, point.y + CyLinderMargon);
            DrawingObject *object = [[drawingClass alloc]initWithBeginPoint:point1];
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject1 = object;
        }
        else if ([object isKindOfClass:[DrawCube class]])
        {
            //前面的正方形
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject = object;
            
            //后面的正方形
            CGPoint point1 = CGPointMake(point.x + CubeMargon, point.y - CubeMargon);
            DrawingObject *object = [[drawingClass alloc]initWithBeginPoint:point1];
            object.strokeWidth = self.strokeObjectWidth;
            object.strokeColor = self.strokeColor;
            object.drawingStroke = YES;
            [self addDrawingObject:object];
            self.currentObject1 = object;
        }
        //将绘画的图形添加到图形数组中
        if (object != nil)
        {
            [self.drawObjectsArray addObject:object];
        }
    }
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([event isKindOfClass:[NSClassFromString(@"UITouchesEvent") class]])
    {
        if ([event allTouches].count > 1)
        {//如果是双指滑动画板不响应
            return;
        }
    }
    self.hasMoved = YES;
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    self.endPoint = point;
    if ([self.currentObject isKindOfClass:[EraserLine class]])
    {
        CGPathAddLineToPoint(self.currentObject.path, NULL, self.endPoint.x, self.endPoint.y);
        [self.currentObject moveEndPoint:self.endPoint];
    }
    else if ([self.currentObject isKindOfClass:[DrawingAnyLine class]])
    {
        CGFloat dx = self.endPoint.x - self.startPoint.x;
        CGFloat dy = self.endPoint.y - self.startPoint.y;
        if (dx * dx + dy * dy < kPointMinDistanceSquared)
        {
            return;
        }
        _previousPoint2  = _previousPoint1;
        _previousPoint1  = [touch previousLocationInView:self];
        CGPoint mid1    = midPoint(_previousPoint1, _previousPoint2);
        CGPoint mid2    = midPoint(self.endPoint, _previousPoint1);
        CGMutablePathRef subpath = CGPathCreateMutable();
        CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
        CGPathAddQuadCurveToPoint(subpath, NULL,
                                  _previousPoint1.x, _previousPoint1.y,
                                  mid2.x, mid2.y);
        CGRect bounds = CGPathGetBoundingBox(subpath);
        CGRect drawBox = CGRectInset(bounds, -2.0 * self.strokeAnylineWidth, -2.0 * self.strokeAnylineWidth);
        CGPathAddPath(self.currentObject.path, NULL, subpath);
        CGPathRelease(subpath);
        [self setNeedsDisplayInRect:drawBox];
    }
    else if ([self.currentObject isKindOfClass:[DrawingRectangle class]])
    {
        [self.currentObject moveEndPoint:point];
    }
    else if ([self.currentObject isKindOfClass:[DrawNormalCircle class]])
    {
        //圆的半径
        self.currentObject.corneradues = sqrt((self.endPoint.y - self.startPoint.y) * (self.endPoint.y - self.startPoint.y) + (self.endPoint.x - self.startPoint.x) * (self.endPoint.x - self.startPoint.x));
        [self.currentObject moveEndPoint:point];
    }
    else if ([self.currentObject isKindOfClass:[DrawingLine class]])
    {
        [self.currentObject moveEndPoint:point];
    }
    else if ([self.currentObject isKindOfClass:[DrawTriangle class]])
    {
        [self.line1 moveEndPoint:[self point2Posation]];
        [self.line2 moveEndPoint:[self point3Posation]];
        [self.line3 moveEndPoint:[self point1Posation]];
    }
    else if ([self.currentObject isKindOfClass:[DrawCylinder class]])
    {
        //左边线
        CGPoint leftBottom = CGPointMake(self.startPoint.x, (self.startPoint.y + self.endPoint.y)/2 + CyLinderMargon);
        [self.currentLine moveEndPoint:leftBottom];
        //上边椭圆
        [self.currentObject moveEndPoint:point];
        
        //右边线
        CGPoint rightBottom = CGPointMake(self.endPoint.x, (self.startPoint.y + self.endPoint.y)/2 + CyLinderMargon);
        [self.currentLine1 moveEndPoint:rightBottom];
        
        //下边椭圆
        CGPoint point1 = CGPointMake(point.x, point.y + CyLinderMargon);
        [self.currentObject1 moveEndPoint:point1];
    }
    else if ([self.currentObject isKindOfClass:[DrawCube class]])
    {
        //前面的正方形
        [self.currentObject moveEndPoint:point];
        //矩形线条1
        CGPoint point1 = CGPointMake(self.startPoint.x + CubeMargon, self.startPoint.y - CubeMargon);
        [self.cubeLine1 moveEndPoint:point1];
        
        //矩形线条2
        CGPoint point2 = CGPointMake(self.endPoint.x + CubeMargon, self.startPoint.y - CubeMargon);
        [self.cubeLine2 moveEndPoint:point2];
        
        //矩形线条3
        CGPoint point3 = CGPointMake(self.startPoint.x + CubeMargon, self.endPoint.y - CubeMargon);
        [self.cubeLine3 moveEndPoint:point3];
        
        //矩形线条4
        CGPoint point4 = CGPointMake(self.endPoint.x + CubeMargon, self.endPoint.y - CubeMargon);
        [self.cubeLine4 moveEndPoint:point4];
        
        //后面的正方形
        //        CGPoint point1 = CGPointMake(point.x, point.y + CubeMargon);
        [self.currentObject1 moveEndPoint:point4];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([event isKindOfClass:[NSClassFromString(@"UITouchesEvent") class]])
    {
        if ([event allTouches].count > 1)
        {//如果是双指滑动画板不响应
            return;
        }
    }
    self.currentObject = nil;
    //三角形的三条线释放掉；
    self.line1 = nil;
    self.line2 = nil;
    self.line3 = nil;
    //圆柱的两条线释放掉；
    self.currentObject1 = nil;
    self.currentLine = nil;
    self.currentLine1 = nil;
    //矩形线条的4根线释放掉
    self.currentObject1 = nil;
    self.cubeLine1 = nil;
    self.cubeLine2 = nil;
    self.cubeLine3 = nil;
    self.cubeLine4 = nil;
    if (self.hasMoved)
    {
        
    }
    else
    {
        [self removeLastGraphics];
        [self setNeedsDisplay];
    }
}
#pragma mark ->移除最后一个图形
- (void)removeLastGraphics
{
    DrawingObject *object = [self.drawObjectsArray lastObject];
    [self.drawObjectsArray removeLastObject];
    if ([object isKindOfClass:[DrawCube class]])
    {
        [self removeLastObjectWithNumber:2];
    }
    else if ([object isKindOfClass:[DrawCylinder class]])
    {
        [self removeLastObjectWithNumber:2];
    }
    else if (![object isKindOfClass:[DrawTriangle class]])
    {
        [self removeLastObjectWithNumber:1];
    }
}
#pragma mark ->移除最后一个图形
- (void)removeLastObjectWithNumber:(int)num
{
    for (int i = 0; i < num; i ++)
    {
        DrawingObject *obj = [self.drawingObjects lastObject];
        if (obj)
        {
            [obj removeObserver:self forKeyPath:@"bounds"];
            [obj removeObserver:self forKeyPath:@"beginPoint"];
            if ([obj isKindOfClass:[DrawingAnyLine class]] || [obj isKindOfClass:[EraserLine class]])
            {
                CGPathRelease([obj path]);
            }
            [self.drawingObjects removeLastObject];
        }
    }
}
@end