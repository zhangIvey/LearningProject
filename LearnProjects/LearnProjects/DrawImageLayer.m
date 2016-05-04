//
//  DrawImageLayer.m
//  LearnProjects
//
//  Created by yaoln on 16/5/4.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "DrawImageLayer.h"

@interface DrawImageLayer ()

@end

@implementation DrawImageLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    layer.bounds = CGRectMake(0, 0, 200, 200);
    
    //设置层的中心点
    layer.position = CGPointMake(300, 300);
    
    //设置层的圆角
    layer.cornerRadius = 200/2;
    
    layer.masksToBounds = YES;
    
    layer.borderWidth = 2;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(10, 10);
    layer.shadowOpacity = 1;
    
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
}

#pragma mark - layer delegate
- (void)drawLayer:(CALayer *)layer
        inContext:(CGContextRef)ctx
{
//    CGContextRef 
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
