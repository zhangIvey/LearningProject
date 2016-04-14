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
    self.view.backgroundColor = [UIColor blueColor];
    [self createLayers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create layer
- (void)createLayers
{
    CALayer *layer1 = [CALayer layer];
    layer1.bounds = CGRectMake(100, 100, 100, 100);
    layer1.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    layer1.borderColor = [UIColor whiteColor].CGColor;
    layer1.borderWidth = 10;
    layer1.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer1];
    
    
    
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
