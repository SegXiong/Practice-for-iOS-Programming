//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by More Xiong on 2016/11/2.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@end

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
    [[UIColor lightGrayColor] setStroke];
    [path stroke];
    
    
    //初级练习
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    
    CGRect imageRect = CGRectMake(bounds.size.width / 4.0, bounds.size.height / 4.0, bounds.size.width / 2.0, bounds.size.height / 2.0);
    [logoImage drawInRect:imageRect];    
    
    
    //高级练习
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(currentContext);
    
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    
    [trianglePath moveToPoint:CGPointMake(center.x, imageRect.origin.y)];
    [trianglePath addLineToPoint:CGPointMake(imageRect.origin.x, imageRect.origin.y + imageRect.size.height)];
    [trianglePath addLineToPoint:CGPointMake(imageRect.origin.x + imageRect.size.width, imageRect.origin.y + imageRect.size.height)];
    [trianglePath closePath];
    
    [trianglePath addClip];
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0,
                             1.0, 1.0, 0.0, 1.0};
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPonint = CGPointMake(center.x, imageRect.origin.y);
    CGPoint endPoint = CGPointMake(center.x, imageRect.origin.y + imageRect.size.height);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPonint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(currentContext);
    
    CGContextSaveGState(currentContext);
    
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    UIImage *logoImage2 = [UIImage imageNamed:@"logo.png"];
    [logoImage2 drawInRect:imageRect];
    
    CGContextRestoreGState(currentContext);
    
}

@end
