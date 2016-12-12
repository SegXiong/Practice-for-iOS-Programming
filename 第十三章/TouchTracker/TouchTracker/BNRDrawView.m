//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by More Xiong on 2016/11/10.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@property (nonatomic, weak) BNRLine *selectedLine;

@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecogizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecogizer.numberOfTapsRequired = 2;
        
        doubleTapRecogizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecogizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecogizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showColorPanel:)];
        swipeRecognizer.numberOfTouchesRequired = 3;
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        swipeRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:swipeRecognizer];
    }
    return self;
}

- (void)strokeLine:(BNRLine *)line withWidth:(float)width
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = width;
    //bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        
        [self.selectedColor set];     //高级练习
        
        [self strokeLine:line withWidth:line.width];
    }

    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        BNRLine *line = self.linesInProgress[key];
        [self strokeLine:line withWidth:line.width];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine withWidth:self.selectedLine.width];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
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
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        CGPoint velocity = [self.moveRecognizer velocityInView:self];
        //NSLog(@"The speed is %@", NSStringFromCGPoint(velocity));
        line.width = (fabs(velocity.x) + fabs(velocity.y)) / 50;   //高级练习
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
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

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Tap");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

- (BNRLine *)lineAtPoint:(CGPoint)p
{
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        for (float t = 0.0; t <= 1; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    return nil;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    //NSLog(@"Recognized Long Press");
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    //NSLog(@"Recognized Pan Gesture");
    if (!self.selectedLine) {
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        [self setNeedsDisplay];
        [gr setTranslation:CGPointZero inView:self];
    }
}
//中级练习 解决Silver Challenge，如果Menu可见，就把他设成不可见，把选中的线设nil
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[UIMenuController sharedMenuController] isMenuVisible])
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        self.selectedLine = nil;
    }

    return YES;
}

- (void)showColorPanel:(UISwipeGestureRecognizer *)gr
{
    CGRect frame = CGRectMake(0, self.frame.size.height - 550, self.frame.size.width, 50);
    [[NSBundle mainBundle] loadNibNamed:@"ColorPickView" owner:self options:nil];
    self.colorView.frame = frame;
    self.colorView.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.colorView];
    [self.window setNeedsDisplay];
}

- (IBAction)colorPicked:(UIButton *)sender
{
    self.selectedColor = sender.backgroundColor;
    [self.colorView removeFromSuperview];
}




@end
