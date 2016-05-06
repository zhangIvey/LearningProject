//
//  TextVIew.m
//  LearnProjects
//
//  Created by yaoln on 16/5/6.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "TextVIew.h"

@implementation TextVIew

@synthesize fontSize;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *str = _title;
    UIFont *font = [UIFont fontWithName:@"Marker Felt" size:self.fontSize];
    UIColor *colorF = [UIColor redColor];
    UIColor *colorB = [UIColor blueColor];
    [str drawInRect:CGRectMake(0, 100, 360, 400) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:colorF,NSBackgroundColorAttributeName:colorB}];
    
}


@end
