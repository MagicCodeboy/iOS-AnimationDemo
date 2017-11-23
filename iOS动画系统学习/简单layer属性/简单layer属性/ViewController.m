//
//  ViewController.m
//  简单layer属性
//
//  Created by lalala on 2017/11/15.
//  Copyright © 2017年 吕山虎. All rights reserved.
//

#import "ViewController.h"
#import "ScrollView.h"
@interface ViewController ()<CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer * blueLayerdd;

@property(nonatomic,strong) ScrollView * layerScrollView;
@end

@implementation ViewController
-(ScrollView *)layerScrollView{
    if (_layerScrollView == nil) {
        _layerScrollView = [[ScrollView alloc]initWithFrame:CGRectMake(10, 20, 300, 300)];
        _layerScrollView.backgroundColor = [UIColor yellowColor];
    }
    return _layerScrollView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self changeColor];
}
- (void)changeColor
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.blueLayerdd.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.blueLayerdd.affineTransform = transform;
    }];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.blueLayerdd.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    [CATransaction commit];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//   添加layer视图图层
    CALayer * blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.f, 50.f, 100.f, 100.f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.blueLayerdd = blueLayer;
    [self.layerView.layer addSublayer:blueLayer];
//    添加contents  图片的添加   contentsGravity 设置图片的填充方式 类似于view中的contentModel
//    UIImage * image = [UIImage imageNamed:@"1125X2436"];
//    self.layerView.layer.contents = (__bridge id _Nullable)(image.CGImage);
//    self.layerView.layer.contentsGravity = kCAGravityCenter;
//    //依照原始比例显示图片
//    self.layerView.layer.contentsScale = image.scale;
//    self.layerView.layer.masksToBounds = YES;
//
//
//    // 实现CALayerDelegate 实现绘图的工作
////    [self drawCalayerDelegateMethod];
//    //超出边界的视图的控制
////    [self maskLayerMethod];
//    //像素组透明的效果
////    [self shouldRasterizationMethod];
//
//
//
//    UIBezierPath * path = [[UIBezierPath alloc]init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
//
//    //create shape layer
//    CAShapeLayer * shapelayer = [CAShapeLayer layer];
//    shapelayer.strokeColor = [UIColor redColor].CGColor;
//    shapelayer.fillColor = [UIColor clearColor].CGColor;
//    shapelayer.lineWidth = 5;
//    shapelayer.lineJoin = kCALineJoinRound;
//    shapelayer.lineCap = kCALineCapRound;
//    shapelayer.path = path.CGPath;
//
//    [self.layerView.layer addSublayer:shapelayer];
//
//    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.layerView.bounds;
//    [self.layerView.layer addSublayer:gradientLayer];
//
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
////    gradientLayer.locations = @[@0.0,@0.25,@0.5,@1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//
//    //重复图层
//    CAReplicatorLayer * replicatorlayer = [CAReplicatorLayer layer];
//    replicatorlayer.frame = self.layerView.bounds;
//    [self.view.layer addSublayer:replicatorlayer];
//
//    replicatorlayer.instanceCount = 10;
//
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform, 0, 200, 0);
//    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
//    transform = CATransform3DTranslate(transform, 0, -200, 0);
//    replicatorlayer.instanceTransform = transform;
//
//    replicatorlayer.instanceBlueOffset = -0.1;
//    replicatorlayer.instanceGreenOffset = -0.1;
//
//    CALayer * layer = [CALayer layer];
//    layer.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [replicatorlayer addSublayer:layer];
//
//
//    [self.view addSubview:self.layerScrollView];
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"QQ20171101-164912-HD" withExtension:@"mp4"];
    AVPlayer * player = [AVPlayer playerWithURL:url];
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.layerView.bounds;
    [self.layerView.layer addSublayer:playerLayer];
    
    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = -1.0/500.0;
    transform3d = CATransform3DRotate(transform3d, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform3d;
    
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;
    
    //play the video
    [player play];
}

//仿射变换
-(void)transformMethod{
    
        [UIView animateWithDuration:0.5 animations:^{
            //旋转45°
    //        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    //        self.layerView.layer.affineTransform = transform;
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformScale(transform, 0.5, 0.5);
            transform = CGAffineTransformRotate(transform, M_PI/180.0 * 30.0);
            transform = CGAffineTransformTranslate(transform, 100, 0);
            self.layerView.layer.affineTransform = transform;
        } completion:^(BOOL finished) {
            self.layerView.layer.affineTransform = CGAffineTransformIdentity;
            [UIView animateWithDuration:0.5 animations:^{
                //绕y轴旋转45°
    //            CATransform3D transform3d = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    //            self.layerView.layer.transform = transform3d;
    
                //视图透视效果
                CATransform3D transform3d = CATransform3DIdentity;
                transform3d.m34 = -1.0 / 500.0;
                transform3d = CATransform3DRotate(transform3d, M_PI_4, 0, 1, 0);
                self.layerView.layer.transform = transform3d;
            }];
        }];
}

//像素组透明问题
-(void)shouldRasterizationMethod{
    UIButton * button1 = [self customButton];
    button1.center = CGPointMake(50, 150);
    [self.view addSubview:button1];
    
    UIButton * button2 = [self customButton];
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
-(UIButton *)customButton{
    CGRect frame = CGRectMake(0, 0, 150, 150);
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = @"hello world";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}
-(void)maskLayerMethod{
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = self.layerView.bounds;
    UIImage * maskImage = [UIImage imageNamed:@"1125X2436"];
    maskLayer.contents =  (__bridge id _Nullable)(maskImage.CGImage);
    
    self.layerView.layer.mask = maskLayer;
}
-(void)drawCalayerDelegateMethod{
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    //CALayerDelegate
    layer.delegate = self;
    //ensure that layer backing image uses correct scale
    layer.contentsScale = [UIScreen mainScreen].scale;
    [self.layerView.layer addSublayer:layer];
    
    //force layer to redraw
    [layer display];
}
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 10.f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
