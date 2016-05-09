//
//  watermarkViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/5/9.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "watermarkViewController.h"


@interface watermarkViewController ()

@end

@implementation watermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImage *image = [self drawWaterMark];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 100, 300, 300);
    [self.view addSubview:imageView];
}

#pragma mark - 图片添加水印
- (UIImage *)drawWaterMark
{
    CGSize size = CGSizeMake(300, 300);
    UIGraphicsBeginImageContext(size);
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    [image drawInRect:CGRectMake(0, 0, 300, 300)];
    
    
    //添加水印
    //绘制横线
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 200, 178);
    CGContextAddLineToPoint(context, 270, 178);
    
    [[UIColor redColor]setStroke];
    CGContextSetLineWidth(context, 2);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    //添加文字
    NSString *str = @"科比";
    [str drawAtPoint:CGPointMake(10, 10) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:15],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //保存图片
    NSData *data= UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/yaoln/Desktop/myPic.png" atomically:YES];
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
