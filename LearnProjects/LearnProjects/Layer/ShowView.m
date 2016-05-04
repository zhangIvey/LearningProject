//
//  ShowView.m
//  LearnProjects
//
//  Created by yaoln on 16/4/28.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#pragma mark - draw line method 1
- (void)drawLine1
{
    //1：获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2：创建图形的路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);//（将画笔的初始坐标确定）
    CGPathAddLineToPoint(path, nil, 20, 100);//（绘制一条线，设置上线段结束的点）
    CGPathAddLineToPoint(path, nil, 300, 100);//（以上次的结束点为初始坐标，继续画线）
    
    
    //3：添加路径到图形的上下文上
    CGContextAddPath(context, path);
    
    //4：设置图形上下文的状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置线段的颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2);//设置线段的宽度
    CGContextSetLineCap(context, kCGLineCapSquare);//设置线段的端头样式(20, 50和300, 100的样式风格)
    CGContextSetLineJoin(context, kCGLineJoinRound); //设置线段的连接处样式（坐标是20, 100点的样式风格）
    /*设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = { 8, 3};
    CGContextSetLineDash(context, 0, lengths, 1);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 1, color);
    
    //5：绘制图像到制定图形上下文上
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    //6：释放对象
//    CGContextRelease(context);
}

#pragma mark - draw line method 2
- (void)drawLine2
{
    //1 ：获取图形的上线文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2 : 绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 100, 300);
//    CGContextAddLineToPoint(context, 500, 600);
    CGContextMoveToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 200, 300);
    
    /*
    封闭路径:a.创建一条起点和终点的线,不推荐
    CGPathAddLineToPoint(path, nil, 20, 50);
    封闭路径:b.直接调用路径封闭方法
     */
    CGContextClosePath(context);
    //3 ：设置图形上下文的属性
    [[UIColor redColor] setStroke];//设置红色边框
    [[UIColor greenColor] setFill];//设置绿色填充
    //同时设置填充和边框色
    //4 : 绘制路径
    CGContextDrawPath(context, kCGPathStroke);
}

#pragma mark - draw rect method 1
- (void)drawRect1
{
    //1：获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2：在图形上下文上绘制路径
    CGRect rect = CGRectMake(100, 100, 200, 60);
    CGContextAddRect(context, rect);
    
    CGContextClosePath(context);
    
    //3：设置图形上下文的属性
    [[UIColor blueColor] setFill];
    [[UIColor redColor] setStroke];
    
    //4：绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

#pragma mark - draw rect method 2 by UIKit
- (void)drawRect2
{

    CGRect rect= CGRectMake(20, 150, 280.0, 50.0);
    CGRect rect2=CGRectMake(20, 250, 280.0, 50.0);
    //设置属性
    [[UIColor yellowColor]set];
    //绘制矩形,相当于创建对象、添加对象到上下文、绘制三个步骤
    UIRectFill(rect);//绘制矩形（只有填充）
    
    [[UIColor redColor]setStroke];
    UIRectFrame(rect2);//绘制矩形(只有边框)
}


#pragma mark - draw Ellipse rect method 1
- (void)drawEllipse1
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制椭圆形也需要绘制矩形
    CGRect rect = CGRectMake(100, 100, 200, 60);
    CGContextAddEllipseInRect(context, rect);
    [[UIColor purpleColor]setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

#pragma mark - draw arc rect method 1
- (void)drawArc1
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*添加弧形对象
     x:中心点x坐标
     y:中心点y坐标
     radius:半径
     startAngle:起始弧度
     endAngle:终止弧度
     closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(context, 160, 300, 100, 0, M_PI_2, 1);
    [[UIColor yellowColor]setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - draw Curve rect method
- (void)drawCurve
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 20, 100);//移动到起始位置
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 100, 300, 150);
    [[UIColor redColor] setFill];
    
    CGContextMoveToPoint(context, 20, 500);
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 100, 200, 250, 400, 360, 400);
    [[UIColor yellowColor] setFill];
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - draw text rect method
- (void)drawtext
{
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device. It will become your go-to interactive astro guide to the night sky, following your every movement in real-time and allowing you to explore over 200, 000 celestial bodies with extensive information about stars and constellations that you find."; //绘制的内容
    CGRect rect = CGRectMake(0, 100, 200, 300); //绘制文字所在的区域
    UIFont *font = [UIFont systemFontOfSize:20];//设置字体
    UIColor *color=[UIColor redColor];//字体颜色
    NSTextAlignment align = NSTextAlignmentLeft;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = align;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
}

#pragma mark - draw image 
- (void)drawImage
{
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    
//    [image drawInRect:CGRectMake(100, 100, 200, 200)];
//    [image drawAtPoint:CGPointMake(0, 0)];
    [image drawAsPatternInRect:CGRectMake(100, 100, 200, 200)];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawImage];
}


@end
