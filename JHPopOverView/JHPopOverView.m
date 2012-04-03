//
//  JHPopOverView.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopOverView.h"

@implementation JHPopOverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
    }
    return self;
}

- (UIBezierPath*)bezierPathWithRect:(CGRect)rect andXPeak:(CGFloat)xPeak{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    
    CGFloat cornerRadius = 6;
    CGFloat pointHeight = 18;
    CGFloat pointWidth_2 = 17;
    [aPath moveToPoint:CGPointMake(xPeak - pointWidth_2, pointHeight)];
    [aPath addLineToPoint:CGPointMake(xPeak, 0)];
    
    [aPath addLineToPoint:CGPointMake(xPeak + pointWidth_2, pointHeight)];
    [aPath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, pointHeight)];
    
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, pointHeight + cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - pointHeight - cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(cornerRadius, rect.size.height)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(0, pointHeight + cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, pointHeight + cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
    
    [aPath closePath];
    return aPath;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    rect = CGRectInset(self.bounds, .5, .5);
    CGContextTranslateCTM(aRef, rect.origin.x, rect.origin.y);
    rect.origin = CGPointZero;
    // Create an oval shape to draw.

    UIBezierPath *aPath = [self bezierPathWithRect:rect andXPeak:218];

    // Set the render colors
    
    [[UIColor colorWithRed:0.67 green:0.66 blue:0.66 alpha:1.0] setStroke];
    [[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0] setFill];
    
    // Adjust the drawing options as needed.
    aPath.lineWidth = 0.5;
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform
//    CGContextSaveGState(aRef);

//    CGContextSetShadowWithColor(aRef, CGSizeMake(1,1), 1.0, [UIColor whiteColor].CGColor);
    
    // Adjust the view's origin temporarily. The oval is
    // now drawn relative to the new origin point.
//    CGContextTranslateCTM(aRef, 50, 50);
    
    
//    CGContextSetShadowWithColor(aRef, CGSizeMake(0, 1), 5.0, [UIColor blackColor].CGColor);
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
    
    
    
    
    [[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.9] setStroke];

    rect = CGRectInset(self.bounds, 1.5, 1.5);

    CGContextTranslateCTM(aRef, rect.origin.x - 0.5, rect.origin.y - 0.5);
    rect.origin = CGPointZero;
    
    UIBezierPath *innerPath = [self bezierPathWithRect:rect andXPeak:217];
    [innerPath fill];
    [innerPath stroke];
    // Restore the graphics state before drawing any other content.
    
//    CGContextRestoreGState(aRef);
    
}


@end
