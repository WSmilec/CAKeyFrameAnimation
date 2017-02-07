//
//  ViewController.m
//  CAKeyFrameAnimationStudy
//
//  Created by WangS on 17/2/7.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "ViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic,weak) UIView *moveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self addBtn];
    UIView *moveView = [UIView new];
    moveView.backgroundColor = [UIColor purpleColor];
    moveView.frame = CGRectMake(50, 60, 30, 30);
    [self.view addSubview:moveView];
    self.moveView = moveView;
}
- (void)addBtn{
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+i*(ScreenW-60)/2, 20, (ScreenW-60)/2, 30);
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:
            [self addOptionOne];
            break;
        case 1:
            [self addOptionTwo];
            break;
        default:
            break;
    }
}
- (void)addOptionOne{
    //创建动画对象
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置value
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(90, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    animation.values = @[value1,value2,value3,value4,value5,value6];
    
    //重复次数 默认为1
    animation.repeatCount = 1;
    //设置是否原路返回默认为不
    animation.autoreverses = YES;
    //设置移动速度，越小越快
    animation.duration = 4.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    //给这个view加上动画效果
    [self.moveView.layer addAnimation:animation forKey:@"position"];
}
- (void)addOptionTwo{
    //创建动画对象
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建一个CGPathRef对象，就是动画的路线
    CGMutablePathRef path = CGPathCreateMutable();
    //自动沿着弧度移动
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 200, 200, 100));
    //设置开始位置
    CGPathMoveToPoint(path,NULL,100,100);
    //沿着直线移动
    CGPathAddLineToPoint(path,NULL, 200, 100);
    CGPathAddLineToPoint(path,NULL, 200, 200);
    CGPathAddLineToPoint(path,NULL, 100, 200);
    CGPathAddLineToPoint(path,NULL, 100, 300);
    CGPathAddLineToPoint(path,NULL, 200, 400);
    //沿着曲线移动
    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    animation.path = path;
    CGPathRelease(path);
    animation.autoreverses = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [self.moveView.layer addAnimation:animation forKey:@"position"];
}


@end
