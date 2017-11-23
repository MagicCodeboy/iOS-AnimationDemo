//
//  ScrollView.m
//  简单layer属性
//
//  Created by lalala on 2017/11/20.
//  Copyright © 2017年 吕山虎. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

+(Class)layerClass{
    return [CAScrollLayer class];
}
-(void)setUp{
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer * recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:recognizer];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)panGesture:(UIPanGestureRecognizer *)recognizer{
    
    NSLog(@"1");
    CGPoint offset =self.bounds.origin;
    
    offset.x = [recognizer translationInView:self].x;
    offset.y = [recognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollPoint:offset];
    
    [recognizer setTranslation:CGPointZero inView:self];
}

@end
