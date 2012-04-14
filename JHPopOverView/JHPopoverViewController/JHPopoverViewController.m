//
//  JHPopoverViewController.m
//  JHPopOverView
//
//  Created by Jon Hocking on 12/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopoverViewController.h"
#import "JHPopoverView.h"

#define kRectBuffer 7
#define kPopoverRadius 6

@interface JHPopoverViewController ()

@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic) CGSize contentSize;
@property (strong, nonatomic) JHPopoverView *popoverView;
@end

@implementation JHPopoverViewController
@synthesize viewController = mViewController;
@synthesize contentSize = mContentSize;
@synthesize popoverView = mPopoverView;

- (id)initWithViewController:(UIViewController*)viewController andContentSize:(CGSize)size{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.contentSize = size;
    }
    
    return self;
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated{
    
    // do some boundary checking for sides here
    
    CGRect convertedRect = rect;    //[view convertRect:rect toView:view];
    CGFloat xPeak = kRectBuffer + self.contentSize.width/2;
    CGFloat xOrigin = -kRectBuffer;
    if (rect.origin.x - (self.contentSize.width/2 - kRectBuffer - kPopoverRadius) < 0 ){
        xPeak += rect.origin.x - (self.contentSize.width/2 - kPopoverRadius);
        xOrigin = 0;
    }
    else if (rect.origin.x + (self.contentSize.width/2 + kRectBuffer + kPopoverRadius) > view.bounds.size.width ){
        xPeak += (rect.origin.x + (self.contentSize.width/2 + kRectBuffer + kPopoverRadius)) - view.bounds.size.width;
        xOrigin = 0;
    }
    
    self.popoverView = [[JHPopoverView alloc]initWithFrame:CGRectMake(xOrigin, 0, self.contentSize.width + 2*kRectBuffer, self.contentSize.height + 2*kRectBuffer) andXPeak:xPeak];
    
    CGRect popOverFrame = self.popoverView.frame;
    
    popOverFrame.origin.y += convertedRect.origin.y + convertedRect.size.height;
    
    popOverFrame.origin.x = (convertedRect.origin.x + convertedRect.size.width/2) - xPeak - kRectBuffer;
    
    
    self.popoverView.frame = popOverFrame;
    
    [self.popoverView setContentView:self.viewController.view];
    
    [view addSubview:self.popoverView];
}

@end
