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



- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawImageForTranform];
}


#pragma mark - 上下文的变换
- (void) drawImageForTranform
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //保存图形上下文的初始状态
    CGContextSaveGState(context);
    
    //形变第一步：图形上下文向右平移40
    CGContextTranslateCTM(context, 100, 0);
    
    //形变第二步：缩放0.8
    CGContextScaleCTM(context, 0.8, 0.8);
    
    
    //形变第三步：旋转
    CGContextRotateCTM(context, M_PI_4/4);
    
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    
//    [image drawInRect:CGRectMake(0, 0, 200, 200)];
//    CGContextDrawImage(context, CGRectMake(0, 0, 200, 200), image.CGImage);
    
    /*在Core Graphics中坐标系的y轴正方向是向上的，坐标原点在屏幕左下角，y轴方向刚好和UIKit中y轴方向相反。而使用UIKit进行绘图之所以没有问题是因为UIKit中进行了处理，事实上对于其他图形即使使用Core Graphics绘制也没有问题，因为UIKit统一了编程方式。但是使用Core Graphics中内置方法绘制图像是存在这种问题的，如何解决呢？
     
     其实图形上下文只要沿着x轴旋转180度，然后向上平移适当的高度即可（但是注意不要沿着z轴旋转，这样得不到想要的结果）。可是通过前面介绍的CGContextRotateCTM方法只能通过沿着z轴旋转，此时不妨使用另外一种方法，那就是在y轴方向缩放-1，同样可以达到想要的效果：
     UIImage *image=[UIImage imageNamed:@"image2.jpg"];
     CGSize size=[UIScreen mainScreen].bounds.size;
     CGContextSaveGState(context);
     CGFloat height=450,y=50;
     //上下文形变
     CGContextScaleCTM(context, 1.0, -1.0);//在y轴缩放-1相当于沿着x张旋转180
     CGContextTranslateCTM(context, 0, -(size.height-(size.height-2*y-height)));//向上平移
     //图像绘制
     CGRect rect= CGRectMake(10, y, 300, height);
     CGContextDrawImage(context, rect, image.CGImage);
     
     CGContextRestoreGState(context);
     */
    
    CGContextRestoreGState(context);
}


#define TILE_SIZE  10
#pragma mark - 无颜色填充模式
//填充瓷砖的回调函数（必须满足CGPatternCallbacks签名）
void drawTile(void *info,CGContextRef context){
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}
-(void)drawBackgroundWithPattern
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace= CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreatePattern(rgbSpace);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法（瓷砖摆放的方式）
     isClored:绘制的瓷砖是否已经指定了颜色（对于无颜色瓷砖此处指定位false）
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, false, &callback);
    
    CGFloat components[]={254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    //注意最后一个参数对于无颜色填充模式指定为当前颜色空间颜色数据
    CGContextSetFillPattern(context, pattern, components);
    //    CGContextSetStrokePattern(context, pattern, components);
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}

#pragma mark - draw 有颜色填充模式

void drawColoredTile(void *info,CGContextRef context) //创建填充用到的瓦片
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
    //有颜色填充，这里设置填充色
    CGContextSetRGBFillColor(context,  254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

-(void)drawBackgroundWithColoredPattern
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设备无关的颜色空间
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //创建模式填充颜色空间，注意对于有颜色的填充模式，这里传NULL
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    //将模式色填充颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    //填充模式回调函数结构体
    CGPatternCallbacks callBack = {0,&drawColoredTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法
     isClored:绘制的瓷砖是否已经指定了颜色(对于有颜色瓷砖此处指定位true)
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, true, &callBack);
    
    CGFloat alpha=1;
    //注意最后一个参数对于有颜色瓷砖指定为透明度的参数地址，对于无颜色瓷砖则指定当前颜色空间对应的颜色数组
    CGContextSetFillPattern(context, pattern, &alpha);
    
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    //    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
    
    
}


#pragma mark - draw 的叠加模式 
- (void) drawRectByQuertz2D
{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置颜色空间
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //设置颜色
    CGFloat compents[] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1
    };
    CGFloat compents2[] = {
        15.0/255.0,127.0/255.0,127.0/255.0,1
    };
    CGFloat compents3[] = {
        100.0/255.0,127.0/255.0,127.0/255.0,1,
    };
    
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    
    
//    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
//    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
//    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
//    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
//    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
//    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
//    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
//    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
//    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    
    

    CGContextAddRect(context, rect);
    CGContextSetFillColor(context, compents);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    CGContextAddRect(context, rect1);
    CGContextSetFillColor(context, compents2);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 500.0);
    CGContextAddRect(context, rect2);
    CGContextSetFillColor(context, compents3);
    CGContextSetBlendMode(context, kCGBlendModeLuminosity);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
//    CGContextAddRect(context, rect3);
//    CGContextAddRect(context, rect4);
//    CGContextAddRect(context, rect5);
//    CGContextAddRect(context, rect6);
//    CGContextAddRect(context, rect7);
//    CGContextAddRect(context, rect8);
//    CGContextAddRect(context, rect9);
//    CGContextAddRect(context, rect10);
//    CGContextAddRect(context, rect11);
    
   
    
//    CGContextSetBlendMode(context, kCGBlendModePlusDarker);
    
    
    
    
    
    
    
}

#pragma mark - draw 的叠加模式 UIKit
- (void) drawRectByUIKitWithContext2
{

    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    CGRect rect16=CGRectMake(30.0, 310.0, 10.0, 250.0);
    CGRect rect17=CGRectMake(50.0, 310.0, 10.0, 250.0);
    CGRect rect18=CGRectMake(70.0, 310.0, 10.0, 250.0);
    CGRect rect19=CGRectMake(90.0, 310.0, 10.0, 250.0);
    CGRect rect20=CGRectMake(110.0, 310.0, 10.0, 250.0);
    CGRect rect21=CGRectMake(130.0, 310.0, 10.0, 250.0);
    CGRect rect22=CGRectMake(150.0, 310.0, 10.0, 250.0);
    CGRect rect23=CGRectMake(170.0, 310.0, 10.0, 250.0);
    CGRect rect24=CGRectMake(190.0, 310.0, 10.0, 250.0);
    CGRect rect25=CGRectMake(210.0, 310.0, 10.0, 250.0);
    CGRect rect26=CGRectMake(230.0, 310.0, 10.0, 250.0);
    CGRect rect27=CGRectMake(250.0, 310.0, 10.0, 250.0);
    CGRect rect28=CGRectMake(270.0, 310.0, 10.0, 250.0);
    CGRect rect29=CGRectMake(290.0, 310.0, 10.0, 250.0);
    
    [[UIColor yellowColor] set];
    UIRectFill(rect);
    
    [[UIColor greenColor] setFill];
    UIRectFill(rect1);
    
    [[UIColor redColor] setFill];
    
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5, kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8, kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9, kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10, kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11, kCGBlendModeDestinationOver);
    UIRectFillUsingBlendMode(rect12, kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13, kCGBlendModeExclusion);
    UIRectFillUsingBlendMode(rect14, kCGBlendModeHardLight);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeHue);
    UIRectFillUsingBlendMode(rect16, kCGBlendModeLighten);
    
    UIRectFillUsingBlendMode(rect17, kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect18, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect19, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect20, kCGBlendModeOverlay);
    UIRectFillUsingBlendMode(rect21, kCGBlendModePlusDarker);
    UIRectFillUsingBlendMode(rect22, kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect23, kCGBlendModeSaturation);
    UIRectFillUsingBlendMode(rect24, kCGBlendModeScreen);
    UIRectFillUsingBlendMode(rect25, kCGBlendModeSoftLight);
    UIRectFillUsingBlendMode(rect26, kCGBlendModeSourceAtop);
    UIRectFillUsingBlendMode(rect27, kCGBlendModeSourceIn);
    UIRectFillUsingBlendMode(rect28, kCGBlendModeSourceOut);
    UIRectFillUsingBlendMode(rect29, kCGBlendModeXOR);
    
}


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
    [image drawAsPatternInRect:CGRectMake(100, 100, 200, 200)];//平铺的图片
}


#pragma mark - 线性渐变
- (void)drawLinearGradient
{
    CGContextRef context =  UIGraphicsGetCurrentContext();
    // 1 ：创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    
    //创建色值数组
    CGFloat components[] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        15.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[] = {
        0, 0.5, 1
    };
    
    
    // 2 ：创建一个渐变对象(一个颜色渐变的坡度)
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    
    // 3 ：开始绘制渐变颜色
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 100), kCGGradientDrawsAfterEndLocation);

    
    
}

#pragma mark - 径向渐变
- (void)drawRadiaGradient
{
    //1 ： 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2 ： 创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //3 : 设置绘图属性,创建一个渐变区域
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat components[] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        15.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[] = {
        0, 0.5, 1
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    
    //4 ： 绘制渐变
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGPoint startCenter = CGPointMake(100, 160);
    CGPoint endCenter = CGPointMake(200, 250);
    CGFloat startRadius = 100;
    CGFloat endRadius = 50;
    
    CGContextDrawRadialGradient(context, gradient, startCenter, startRadius, endCenter, endRadius, kCGGradientDrawsAfterEndLocation);
    
    
    
}

#pragma mark - 渐变填充
- (void)drawRectFillWithGradient
{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //裁剪制定的区域，然后再进行填充
    CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    
    //开始颜色的填充
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //创建色值
    CGFloat compents[] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    //创建渐变的点
    CGFloat locations[] = {
        0, 0.5,1
    };
    //创建渐变的坡度
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compents, locations, 3);
    //进行绘制渐变色
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsBeforeStartLocation);
}


@end
