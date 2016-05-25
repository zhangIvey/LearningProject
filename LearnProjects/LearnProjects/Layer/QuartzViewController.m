//
//  QuartzViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/5/4.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "QuartzViewController.h"
#import "ShowView.h"


@interface QuartzViewController ()

@end

@implementation QuartzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowView *view = [[ShowView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
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
