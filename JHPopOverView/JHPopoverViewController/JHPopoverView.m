//
//  JHPopOverView.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopoverView.h"
#import <QuartzCore/QuartzCore.h>

@interface JHPopoverView ()

@property (strong, nonatomic) UIBezierPath *outerPath;
@property (strong, nonatomic) UIBezierPath *innerPath;
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation JHPopoverView

@synthesize outerPath = mOuterPath;
@synthesize innerPath = mInnerPath;
@synthesize scrollView = mScrollView;

- (id)initWithFrame:(CGRect)frame andXPeak:(CGFloat)xPeak
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        mYPeak = 0;
        mPeakWidth = 34;
        mPeakHeight = 18;
        mXPeak = xPeak;
        mCornerRadius = 4;
        mShadowRadius = 6;
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(mShadowRadius + 1, mYPeak + mPeakHeight + mShadowRadius + 0.5, frame.size.width - (2*mShadowRadius + 1.5), frame.size.height - mYPeak - mPeakHeight - mShadowRadius - mShadowRadius - 1.5)];
        containerView.layer.cornerRadius = mCornerRadius;
        containerView.clipsToBounds = YES;
        
        [self addSubview:containerView];
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:containerView.bounds];
        
        self.scrollView.contentSize = CGSizeMake(containerView.frame.size.width, 2* containerView.frame.size.height);
        [containerView addSubview:self.scrollView];
        
       
        
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
    self.outerPath.lineWidth = 1;//0.5;
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform
    CGContextSaveGState(aRef);
    CGContextSetShadowWithColor(aRef, CGSizeMake(0, 0), mShadowRadius, [UIColor colorWithWhite:0 alpha:0.3].CGColor);
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [self.outerPath fill];
    [self.outerPath stroke];
    
    
    CGContextRestoreGState(aRef);
    
    
    [[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.9] setStroke]; // white highlight inner stroke

    rect = CGRectInset(self.bounds, 6, 6);

    CGContextTranslateCTM(aRef, rect.origin.x - 5, rect.origin.y - 5);
    rect.origin = CGPointZero;
    if (nil == self.innerPath) {
        self.innerPath = [self bezierPathWithRect:rect xPeak:mXPeak - 1 yPeak:mYPeak + 0.5 peakWidth:mPeakWidth - 1 andPeakHeight:mPeakHeight - 1];
    }
    self.innerPath.lineWidth = 1;
//    [self.innerPath fill];
    [self.innerPath stroke];
    
}

- (void)setContentView:(UIView*)contentView{
    self.scrollView.contentSize = contentView.bounds.size;
    [self.scrollView addSubview:contentView];
}

@end
