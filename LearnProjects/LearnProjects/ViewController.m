//
//  ViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/4/13.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "ViewController.h"
#import "LayerControllerViewController.h"
#import "DrawImageLayer.h"
#import "QuartzViewController.h"
#import "ChangeingViewController.h"
#import "watermarkViewController.h"
#import "ProducePDFViewController.h"
#import "CoreImageViewController.h"
#import "KCMainViewController.h"
#import "CoreAnimationViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_optionsTableView; //知识点展示视图
    NSArray *_optionsArray; //知识点
}

@end

@implementation ViewController


- (void)loadView
{
    [super loadView];
    
    _optionsArray = [[NSArray alloc] initWithObjects:@"Layer",@"Layer2",@"Quartz 2D",@"视图的实时变化",@"位图上添加水印",@"绘制生成PDF",@"图片的滤镜功能",@"绘制图层的执行顺序",@"Core Animation", nil];
    _optionsTableView = [[UITableView alloc] init];
    _optionsTableView.backgroundColor = [UIColor yellowColor];
    _optionsTableView.frame = CGRectMake(0, 0,ScreenWidth, ScreenHeight);
    _optionsTableView.delegate = self;
    _optionsTableView.dataSource = self;
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_optionsTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - the methdo tableView dataSource;


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"Layer");
        LayerControllerViewController *layerViewController = [[LayerControllerViewController alloc] init];
        [self.navigationController pushViewController:layerViewController animated:YES];
    }else if (indexPath.row == 1)
    {
        DrawImageLayer *layerController = [[DrawImageLayer alloc] init];
        [self.navigationController pushViewController:layerController animated:YES];
    }else if (indexPath.row == 2)
    {
        QuartzViewController *viewController = [[QuartzViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 3){
        ChangeingViewController *viewController = [[ChangeingViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 4){
        watermarkViewController *viewController = [[watermarkViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 5){
        ProducePDFViewController *pdfViewController = [[ProducePDFViewController alloc] init];
        [self.navigationController pushViewController:pdfViewController animated:YES];
    }else if (indexPath.row == 6){
        CoreImageViewController *imageViewController = [[CoreImageViewController alloc] init];
        [self.navigationController pushViewController:imageViewController animated:YES];
    }else if (indexPath.row == 7){
        KCMainViewController *mainViewController = [[KCMainViewController alloc] init];
        [self.navigationController pushViewController:mainViewController animated:YES];
    }else if (indexPath.row == 8){
        CoreAnimationViewController *viewController = [[CoreAnimationViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    cell.textLabel.text = (NSString *)[_optionsArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _optionsArray.count;
}


@end
