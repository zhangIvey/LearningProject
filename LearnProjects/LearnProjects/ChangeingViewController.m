//
//  ChangeingViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/5/6.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "ChangeingViewController.h"

#import "TextVIew.h"

@interface ChangeingViewController ()
{
        NSArray *sizeArray;
    TextVIew *view;
}

@end

@implementation ChangeingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLayout];
}

#pragma mark - initLayout
- (void)initLayout
{
    sizeArray = @[@10,@20,@12,@45,@78,@12,@45];
    
    
    view = [[TextVIew alloc] init];
    view.frame = [[UIScreen mainScreen] bounds];
    view.backgroundColor = [UIColor whiteColor];
    view.title = @"hello world";
    self.view = view;
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 400, 360, 300)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
}

#pragma mark - pickerView delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

#pragma mark - pickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return sizeArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView
                      titleForRow:(NSInteger)row
                     forComponent:(NSInteger)component
{
    NSString *number = (NSString *)[sizeArray objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%@号字体",number];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    NSString *number = (NSString *)[sizeArray objectAtIndex:row];
    view.fontSize = number.intValue;
    [view setNeedsDisplay];
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
