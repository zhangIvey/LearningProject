//
//  LayerControllerViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/4/13.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "LayerControllerViewController.h"

@interface LayerControllerViewController ()

@end

@implementation LayerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLayers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create layer

#define width_D 50
#define height_D 50
#define WIDTH 200
#define HEIGHT 200
- (void)createLayers
{
    //简单的图形绘制
    CALayer *layer = [[CALayer alloc] init];
    
    //设置背景颜色
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    //设置中心点
    layer.position = CGPointMake(200, 200);
    
    //设置图层的大小
    layer.bounds = CGRectMake(0, 0, width_D, height_D);
    
    //设置图层的圆角
    layer.cornerRadius = width_D/2;
    
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(10, 10);
    layer.shadowOpacity = 1;
    
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 1;
    [self.view.layer addSublayer:layer];
}

#pragma mark - 点击放大
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = [[self.view.layer sublayers] objectAtIndex:0];
    layer.position = [touch locationInView:self.view];
    CGFloat width_temp = layer.bounds.size.width;
    if (width_temp == width_D) {
        width_temp = WIDTH;
    }else{
        width_temp = width_D;
    }
    layer.bounds = CGRectMake(0, 0, width_temp, width_temp);
    layer.cornerRadius = width_temp/2;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = [[self.view.layer sublayers] objectAtIndex:0];
    layer.position = [touch locationInView:self.view];
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
