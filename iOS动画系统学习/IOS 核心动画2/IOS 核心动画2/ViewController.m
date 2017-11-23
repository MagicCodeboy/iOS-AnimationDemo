//
//  ViewController.m
//  IOS 核心动画2
//
//  Created by lalala on 2017/11/21.
//  Copyright © 2017年 LSH. All rights reserved.
//

#import "ViewController.h"



float quadraticEaseInOut(float t)
{
    return (t < 0.5)? (2 * t * t): (-2 * t * t) + (4 * t) - 1;
    
}
float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}
float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}
@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property(nonatomic,strong) CALayer * colorLayer;
@property(nonatomic,strong) NSTimer * timer;
@property(nonatomic,assign) NSTimeInterval duration;
@property(nonatomic,assign) NSTimeInterval timeoffset;
@property(nonatomic,strong) id fromValue;
@property(nonatomic,strong) id toValue;
@end

@implementation ViewController
- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time {
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time) );return [NSValue valueWithCGPoint:result];
                                                                                      } }
                                                                                      //provide safe default implementation
                                                                                      return (time < 0.5)? fromValue: toValue;
                                                                                      }
- (void)viewDidLoad {
    [super viewDidLoad];

    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self preformTransition];
    
//    [self moveLayerViewBegan:touches withEvent:event];
    
//    [self changeColor];
    
//    [self animation];
    
    [self animationTwo];
}
-(void)moveLayerViewBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layerView.center = [[touches anyObject]locationInView:self.view];
    } completion:^(BOOL finished) {
        
    }];
}
//关键帧实现自定义的缓冲函数
-(void)animation{
    self.layerView.center = CGPointMake(150, 20);
    
    NSValue * fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue * toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    
    CFTimeInterval duration = 1.0;
    NSInteger numFrames = duration * 60;
    NSMutableArray * frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        time = quadraticEaseInOut(time);
        //add keyframe
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    
    [self.layerView.layer addAnimation:animation forKey:nil];
}
//基于定时器实现的关键帧动画
-(void)animationTwo{
    self.layerView.center = CGPointMake(150, 20);
    
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    self.duration = 1.0;
    self.timeoffset = 0.0;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(step:) userInfo:nil repeats:YES];
    
}
-(void)step:(NSTimer *)step{
    self.timeoffset = MIN(self.timeoffset + 1/60.0, self.duration);
    float time = self.timeoffset / self.duration;
    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.layerView.center = [position CGPointValue];
    if (self.timeoffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
//改变视图的颜色 缓冲函数
-(void)changeColor{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    CAMediaTimingFunction * fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn,fn,fn];
    [self.colorLayer addAnimation:animation forKey:nil];
}
//视图移动到手指点击的地方
-(void)touchMoveWithFigureBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}
-(void)preformTransition{
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    //捕获图层的图片和子图层
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView * coverView = [[UIImageView alloc]initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
