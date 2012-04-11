//
//  JHPopOverView.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopOverView.h"
#import <QuartzCore/QuartzCore.h>

@interface JHPopOverView ()

@property (strong, nonatomic) UIBezierPath *outerPath;
@property (strong, nonatomic) UIBezierPath *innerPath;

@end

@implementation JHPopOverView

@synthesize outerPath = mOuterPath;
@synthesize innerPath = mInnerPath;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        mYPeak = 0;
        mPeakWidth = 34;
        mPeakHeight = 18;
        mXPeak = 218;
        mCornerRadius = 6;
        mShadowRadius = 6;
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(mShadowRadius + 1, mYPeak + mPeakHeight + mShadowRadius + 1, frame.size.width - (2*mShadowRadius + 2), frame.size.height - mYPeak - mPeakHeight - mShadowRadius - mShadowRadius - 2)];
        containerView.layer.cornerRadius = mCornerRadius - 1;
        containerView.clipsToBounds = YES;
//        containerView.backgroundColor = [UIColor redColor];
        
        [self addSubview:containerView];
        
        
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:containerView.bounds];
//        scrollView.layer.cornerRadius = mCornerRadius - 1;
        
        scrollView.contentSize = CGSizeMake(containerView.frame.size.width, 2* containerView.frame.size.height);
        [containerView addSubview:scrollView];
        
//        scrollView.backgroundColor = [UIColor greenColor];
        
        UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)];
        [scrollView addSubview:content];
//        content.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (UIBezierPath*)bezierPathWithRect:(CGRect)rect xPeak:(CGFloat)xPeak yPeak: (CGFloat)yPeak peakWidth:(CGFloat)peakWidth andPeakHeight:(CGFloat)peakHeight{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    
    CGFloat cornerRadius = mCornerRadius;
    CGFloat pointHeight = peakHeight;
    CGFloat pointWidth_2 = peakWidth/2;
    [aPath moveToPoint:CGPointMake(xPeak - pointWidth_2, yPeak + pointHeight)];
    [aPath addLineToPoint:CGPointMake(xPeak, yPeak)];
    
    [aPath addLineToPoint:CGPointMake(xPeak + pointWidth_2, yPeak + pointHeight)];
    [aPath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, yPeak + pointHeight)];
    
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, yPeak + pointHeight + cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height -  yPeak - pointHeight - cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(cornerRadius, rect.size.height)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(0, yPeak + pointHeight + cornerRadius)];
    [aPath addArcWithCenter:CGPointMake(cornerRadius, yPeak + pointHeight + cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
    
    [aPath closePath];
    return aPath;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    rect = CGRectInset(self.bounds, 5, 5);
    CGContextTranslateCTM(aRef, rect.origin.x, rect.origin.y);
    rect.origin = CGPointZero;
    // Create an oval shape to draw.
    if (nil == self.outerPath) {
        self.outerPath = [self bezierPathWithRect:rect xPeak:mXPeak yPeak:mYPeak peakWidth:mPeakWidth andPeakHeight:mPeakHeight];
    }
    

    // Set the render colors
    
    [[UIColor colorWithRed:0.67 green:0.66 blue:0.66 alpha:1.0] setStroke]; // gray
    [[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0] setFill];   // light grey inner fill
    
    // Adjust the drawing options as needed.
    self.outerPath.lineWidth = 0.5;
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform
    CGContextSaveGState(aRef);
    CGContextSetShadowWithColor(aRef, CGSizeMake(0, 0), mShadowRadius, [UIColor colorWithWhite:0 alpha:0.2].CGColor);
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [self.outerPath fill];
    [self.outerPath stroke];
    
    
    CGContextRestoreGState(aRef);
    
    
    [[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.9] setStroke]; // white highlight inner stroke

    rect = CGRectInset(self.bounds, 6.5, 6.5);

    CGContextTranslateCTM(aRef, rect.origin.x - 5, rect.origin.y - 5);
    rect.origin = CGPointZero;
    if (nil == self.innerPath) {
        self.innerPath = [self bezierPathWithRect:rect xPeak:mXPeak - 1.5 yPeak:mYPeak + 1 peakWidth:mPeakWidth - 2 andPeakHeight:mPeakHeight - 1];
    }
    
    [self.innerPath fill];
    [self.innerPath stroke];
    
}


@end
