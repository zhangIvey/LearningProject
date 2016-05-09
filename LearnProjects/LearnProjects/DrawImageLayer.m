//
//  DrawImageLayer.m
//  LearnProjects
//
//  Created by yaoln on 16/5/4.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "DrawImageLayer.h"
#define PHOTO_HEIGHT 150
@interface DrawImageLayer ()

@end

@implementation DrawImageLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create layer
- (void)createLayer
{
    CALayer *layer = [[CALayer alloc] init];
    //设置层大小
    layer.bounds = CGRectMake(0, 0, 150, 150);
    
    //设置层的中心点
    layer.position = CGPointMake(200, 200);
    
    //设置层的圆角
    layer.cornerRadius = 150/2;
    
    layer.masksToBounds = YES;
    
    //设置边框宽度
    layer.borderWidth = 2;
    //设置边框颜色
    layer.borderColor = [UIColor whiteColor].CGColor;
    //设置阴影颜色
    layer.shadowColor = [UIColor grayColor].CGColor;
    //设置阴影区域
    layer.shadowOffset = CGSizeMake(10, 50);
    //设置阴影透明度
    layer.shadowOpacity = 1;
    
    [self.view.layer addSublayer:layer];
    
    //设置图层的代理
    layer.delegate = self;
    
    [layer setNeedsDisplay];
}

#pragma mark - layer delegate 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer
        inContext:(CGContextRef)ctx
{
    
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image=[UIImage imageNamed:@"timg.jpeg"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
