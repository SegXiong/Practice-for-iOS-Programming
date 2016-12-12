//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by More Xiong on 2016/11/10.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRCircle.h"

@interface BNRDrawView ()

//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
//@property (nonatomic, strong) NSMutableArray *finishedCircle;

//- (void)strokeLine:(BNRLine *)line;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        //self.finishedCircle = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}
/*
- (void)drawRect:(CGRect)rect
{
    for (BNRLine *line in self.finishedLines)
    {
        float xDiff = line.end.x - line.begin.x;
        float yDiff = line.end.y - line.begin.y;
        float angle = atan2f(xDiff, yDiff);
        float colorSet = (angle + M_PI) / (M_PI * 2);
        [[UIColor colorWithHue:colorSet saturation:1.0 brightness:1.0 alpha:1.0]set];
        [self strokeLine:line];
    }*/
    /*[[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }*/
    /*if (self.currentLine) {
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
   }*/
    /*[[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
//    for (BNRCircle *circle in self.finishedCircle) {
//       [self strokeCircle:circle];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));                                 */
    /*UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    self.currentLine = [[BNRLine alloc] init];
    self.currentLine.begin = location;
    self.currentLine.end = location;*/
    
/*    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));                                 */
    /*UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    self.currentLine.end = location;*/
    
/*    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));                                 */
    /*[self.finishedLines addObject:self.currentLine];
    self.currentLine = nil;*/
    
    /*for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];//:removeAllObjects works too.(放快速枚举外）
    }*/
/*    if (touches.count != 2) {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            BNRLine *line = self.linesInProgress[key];
            [self.finishedLines addObject:line];
            [self.linesInProgress removeObjectForKey:key];//:removeAllObjects works too.(放快速枚举外）
        }
    } else {
        NSArray *touchArray = [touches allObjects];
        UITouch *t1 = [touchArray objectAtIndex:0];
        UITouch *t2 = [touchArray objectAtIndex:1];
        BNRCircle *circle = [[BNRCircle alloc] init];
        circle.point1 = [t1 locationInView:self];
        circle.point2 = [t2 locationInView:self];
//        [self.finishedCircle addObject:circle];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
*/

//高级练习
-(void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeCircle:line];
    }
    [[UIColor redColor] set];
    if (self.linesInProgress.count == 2) {
        BNRLine *line = [[BNRLine alloc] init];
        NSArray *array = [self.linesInProgress allValues];
        line.begin = [array[0] CGPointValue];
        line.end = [array[1] CGPointValue];
        [self strokeCircle:line];
    }
}
-(void)touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGPoint point = [t locationInView:self];
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = [NSValue valueWithCGPoint:point];
    }
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        CGPoint point = [t locationInView:self];
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = [NSValue valueWithCGPoint:point];
    }
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    if (self.linesInProgress.count == 2) {
        BNRLine *line = [[BNRLine alloc] init];
        NSArray *array = [self.linesInProgress allValues];
        line.begin = [array[0] CGPointValue];
        line.end = [array[1] CGPointValue];
        [self.finishedLines addObject:line];
    }
    [self.linesInProgress removeAllObjects];
    [self setNeedsDisplay];
}

//初级练习
/*- (void)saveAllLines
{
    NSMutableArray *linesToBeSaved = [[NSMutableArray alloc] init];
    for (BNRLine *line in self.finishedLines) {
        [linesToBeSaved addObject:[[NSNumber alloc]initWithFloat:line.begin.x]];
        [linesToBeSaved addObject:[[NSNumber alloc]initWithFloat:line.begin.y]];
        [linesToBeSaved addObject:[[NSNumber alloc]initWithFloat:line.end.x]];
        [linesToBeSaved addObject:[[NSNumber alloc]initWithFloat:line.end.y]];
    }
    [linesToBeSaved writeToFile:@"/Users/Moe/Desktop/TouchTracker" atomically:YES];
    NSLog(@"%lu lines were saved to disk!", linesToBeSaved.count / 4);
}

- (void)redrawSavedLines
{
    NSMutableArray *linesToBeDrawn = [[NSMutableArray alloc] initWithContentsOfFile:@"/Users/Moe/Desktop/TouchTracker"];
    if (linesToBeDrawn.count < 4) {
        NSLog(@"Imported %lu lines from savefile", linesToBeDrawn.count / 4);
        
        return;
    }
    for (int i = 0; i < linesToBeDrawn.count - 3; i += 4) {
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = CGPointMake([linesToBeDrawn[i] floatValue], [linesToBeDrawn[i + 1] floatValue]);
        line.end = CGPointMake([linesToBeDrawn[i + 2] floatValue], [linesToBeDrawn[i + 3] floatValue]);
        [self.finishedLines addObject:line];
    }
}*/

- (void)strokeCircle:(BNRLine *)line
{
    CGFloat w = fabs(line.end.x - line.begin.x);
    CGFloat h = fabs(line.end.y - line.begin.y);
    float radius = hypotf(w, h) / 2;
    CGPoint center = CGPointMake(line.end.x - (w / 2), line.end.y - (h / 2));
    UIBezierPath *bp = [UIBezierPath bezierPathWithArcCenter:center
                                                      radius:radius
                                                  startAngle:0
                                                    endAngle:2 * M_PI
                                                   clockwise:YES];
    bp.lineWidth = 10;
    [bp stroke];
}


@end
