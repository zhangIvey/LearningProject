//
//  Kview.m
//  LearnProjects
//
//  Created by yaoln on 16/5/10.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "Kview.h"
#import "K_layer.h"

@implementation Kview

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"initWithFrame:");
    if (self=[super initWithFrame:frame]) {
        K_layer *layer=[[K_layer alloc]init];
        layer.bounds=CGRectMake(0, 0, 185, 185);
        layer.position=CGPointMake(160,284);
        layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        
        
        
        [self.layer addSublayer:layer];
        //显示图层
        [layer setNeedsDisplay];
    }
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"1-drawLayer:inContext:");
    NSLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"2-drawRect:");
    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
}




@end
