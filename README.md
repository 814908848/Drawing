# DrawBoard
**画板描述**

备注：此框架为iPad做了非常便利的封装

提供一个小画板，可以绘画直线，曲线，三角形，矩形，圆，立方体，圆柱。
使用方法简单，

**使用方法**

1、只需要将DrawBoard文件拖入项目中，

2、上代码

```
DrawBoardView *draw = [[DrawBoardView alloc]initWithFrame:self.view.bounds andDrawBoardViewType:DrawBoardViewTypeDraftPaper];
[self.view addSubview:draw];
```
