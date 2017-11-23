//
//  DrawingView.m
//  简单的绘图应用
//
//  Created by lalala on 2017/11/22.
//  Copyright © 2017年 LSH. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView()

@property(nonatomic,strong) UIBezierPath * path;

@end

@implementation DrawingView
+(Class)layerClass{
    return [CAShapeLayer class];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.path = [[UIBezierPath alloc]init];
    self.path.lineJoinStyle = kCGLineJoinRound;
    self.path.lineCapStyle = kCGLineCapRound;
    
    self.path.lineWidth = 5;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point  = [[touches anyObject] locationInView:self];
    
    [self.path moveToPoint:point];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:point];
    
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [[UIColor clearColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}
@end
