//
//  CoreAnimationViewController.m
//  LearnProjects
//
//  Created by yaoln on 16/5/10.
//  Copyright © 2016年 zhangze. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()
{
    CALayer *_flowerLayer;
}

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"flower.jpg"];
    _flowerLayer = [[CALayer alloc] init];
     _flowerLayer.position = CGPointMake(100, 100);
    _flowerLayer.bounds = CGRectMake(0, 100, 60, 40);
    _flowerLayer.anchorPoint = CGPointMake(0.5, 0.5); //设置锚点
    _flowerLayer.backgroundColor = [UIColor clearColor].CGColor;
    _flowerLayer.contents = (id)image.CGImage;
    [self.view.layer addSublayer:_flowerLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 基础动画 - 旋转动画
- (void)rolationTransation
{
    //1： 创建动画，并指明变化的属性
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2：设置动画的结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    
    //3 ： 设置动画对象的相关属性
    basicAnimation.duration=6.0;
    basicAnimation.autoreverses = true;//旋转后再旋转到原来的位置
    basicAnimation.removedOnCompletion = NO; //动画完成之后，移除动画；
    basicAnimation.repeatCount = HUGE_VALF;  //无限循环
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_flowerLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark - 继续动画 -
- (void)animationResume
{
    
    //获取暂停的时间
    CFTimeInterval beginTime  = CACurrentMediaTime() - _flowerLayer.timeOffset;
    //恢复之前的偏移量
    _flowerLayer.timeOffset = 0;
    //设置开始的时间
    _flowerLayer.beginTime = beginTime;

    //设置动画速度，开始运动
    _flowerLayer.speed = 1.0;
}

#pragma mark - 暂停动画 - 
- (void)animationPause
{
    //获取层的媒体时间 ,转变时间
    CFTimeInterval interval = [_flowerLayer convertTime:CACurrentMediaTime() toLayer:nil];
    
    //设置动画的媒体时间偏移量，是图片停留在旋转的角度上
    [_flowerLayer setTimeOffset:interval];
    
    //设置旋转的速度为0，就停止动画
    _flowerLayer.speed = 0;
}

#pragma mark - 基础动画 - 平移动画
- (void)basicAnimation:(CGPoint) endPoint
{
    //1：创建动画对象，指明动画对应的属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.delegate = self;
    //2：设置初始值和结束值
    basicAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    
    //3：设置动画对象的相关属性
    basicAnimation.duration = 5.0;//设置动画的持续时间
    //basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"aa"];
    //4：将动画添加到对象上
    [_flowerLayer addAnimation:basicAnimation forKey:@"KB_position_animation"];
}


#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self.view];
    
    //获取创建的动画，判断是否已经创建了动画
    CAAnimation *animation = [_flowerLayer animationForKey:@"KCBasicAnimation_Rotation"];
    if (animation) {
    
        //判断动画的当前速度
        if (_flowerLayer.speed == 0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建一个新动画
        [self basicAnimation:endPoint]; //基础动画
        [self rolationTransation];
    }
    
    
}


#pragma mark - 动画的代理方法(CoreAnimationDelegate)
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_flowerLayer.frame));
    NSLog(@"%@",[_flowerLayer animationForKey:@"KB_position_animation"]);//通过前面的设置的key获得动画
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_flowerLayer.frame));
    /*
      动画运行完成后会重新从起始点运动到终点。这个问题产生的原因就是前面提到的，对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）会产生动画效果。解决这个问题有两种办法：关闭图层隐式动画、设置动画图层为根图层，要关闭隐式动画需要用到动画事务CATransaction，在事务内将隐式动画关闭
     */
    //开始一个动画事务
    [CATransaction begin];
    
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    _flowerLayer.position=[[anim valueForKey:@"aa"] CGPointValue];
    //提交事务
    [CATransaction commit];
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
