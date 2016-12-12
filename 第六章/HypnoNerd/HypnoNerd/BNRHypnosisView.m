//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by More Xiong on 2016/11/2.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.circleColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
        float maxRadius = hypot(bounds.size.width, bounds.size.height);
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    path.lineWidth = 10;
    [self.circleColor setStroke];//[[UIColor lightGrayColor] setStroke];
    [path stroke];
    
}
    
- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
