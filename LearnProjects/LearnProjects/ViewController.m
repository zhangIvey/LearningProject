//
//  ViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/4/13.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "ViewController.h"

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
    
    _optionsArray = [[NSArray alloc] initWithObjects:@"Layer", nil];
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
