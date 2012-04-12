//
//  JHPopoverViewController.m
//  JHPopOverView
//
//  Created by Jon Hocking on 12/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHPopoverViewController.h"
#import "JHPopoverView.h"

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
    
    CGRect convertedRect = [view convertRect:rect toView:view];
//    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    self.popoverView = [[JHPopoverView alloc]initWithFrame:CGRectMake(-5, 0, self.contentSize.width + 10, self.contentSize.height + 10) andXPeak:5 + self.contentSize.width/2];
    
    CGRect popOverFrame = self.popoverView.frame;
    
    popOverFrame.origin.y = convertedRect.origin.y + convertedRect.size.height;
    
    popOverFrame.origin.x = (convertedRect.origin.x + convertedRect.size.height/2) - popOverFrame.size.width/2;
    
    self.popoverView.frame = popOverFrame;
//    [window addSubview:self.popoverView];
    [view addSubview:self.popoverView];
}

@end
