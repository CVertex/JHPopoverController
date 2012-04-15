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
@property (strong, nonatomic) UITapGestureRecognizer *tapOutsideGestureRecognizer;


- (void)didRotate:(NSNotification*)notification;
- (void)handleOutsideTap:(UITapGestureRecognizer*)tapGesture;

@end

@implementation JHPopoverViewController
@synthesize viewController = mViewController;
@synthesize contentSize = mContentSize;
@synthesize popoverView = mPopoverView;
@synthesize tapOutsideGestureRecognizer = mTapOutsideGestureRecognizer;

- (id)initWithViewController:(UIViewController*)viewController andContentSize:(CGSize)size{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.contentSize = size;
        UIDevice *device = [UIDevice currentDevice];
        [device beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        self.tapOutsideGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOutsideTap:)];
        self.tapOutsideGestureRecognizer.delegate = self;
    }
    
    return self;
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated{
    
    // do some boundary checking for sides here
    
    CGRect convertedRect = rect;
    CGFloat xPeak = kRectBuffer + self.contentSize.width/2;
    CGFloat xOrigin = -kRectBuffer;
    if (rect.origin.x - (self.contentSize.width/2 - kRectBuffer - kPopoverRadius) < 0 ){
        xPeak += rect.origin.x - (self.contentSize.width/2 - kPopoverRadius);
        xOrigin = 0;
    }
    else if (rect.origin.x + (self.contentSize.width/2 + kRectBuffer + kPopoverRadius) > view.bounds.size.width ){
        
        CGFloat rightBuffer = view.bounds.size.width - (rect.origin.x + rect.size.width/2);
        CGFloat tmpX = rightBuffer - kRectBuffer;
        
        xPeak = roundf(self.contentSize.width - tmpX);
        xOrigin = 0;
    }
    
    self.popoverView = [[JHPopoverView alloc]initWithFrame:CGRectMake(xOrigin, 0, self.contentSize.width + 2*kRectBuffer, self.contentSize.height + 2*kRectBuffer) andXPeak:xPeak];
    
    CGRect popOverFrame = self.popoverView.frame;
    
    popOverFrame.origin.y += convertedRect.origin.y + convertedRect.size.height;
    
    popOverFrame.origin.x = (convertedRect.origin.x + convertedRect.size.width/2) - xPeak - kRectBuffer;
    
    
    self.popoverView.frame = popOverFrame;
    
    [self.popoverView setContentView:self.viewController.view];

    
    if (animated) {
        self.popoverView.alpha = 0;
        [view addSubview:self.popoverView];
        [UIView animateWithDuration: 0.15 delay: 0
                            options: UIViewAnimationOptionCurveEaseInOut |
                                     UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{
                             
                             self.popoverView.alpha = 1;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }else{
        [view addSubview:self.popoverView];
    }
    
    [view addGestureRecognizer:self.tapOutsideGestureRecognizer];

}

- (void)dismissPopoverAnimated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration: 0.15 delay: 0
                            options: UIViewAnimationOptionCurveEaseInOut |
                                     UIViewAnimationOptionBeginFromCurrentState 
                         animations:^{
                                
                             self.popoverView.alpha = 0;
                                
                            } completion:^(BOOL finished) {
                                [self.popoverView.superview removeGestureRecognizer:self.tapOutsideGestureRecognizer];
                                [self.popoverView removeFromSuperview];
                                self.popoverView = nil;
                            }];
    }else{
        [self.popoverView.superview removeGestureRecognizer:self.tapOutsideGestureRecognizer];
        [self.popoverView removeFromSuperview];
        self.popoverView = nil;
    }
    
}

- (void)didRotate:(NSNotification*)notification{
    [self dismissPopoverAnimated:NO];
}

#pragma mark - Tap Methods

// delegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer != self.tapOutsideGestureRecognizer) {
        return YES;
    }
    CGPoint touchPoint = [gestureRecognizer locationInView:self.popoverView.superview];
    if (CGRectContainsPoint(self.popoverView.frame, touchPoint)) {
        return NO;
    }
    else return YES;
}

- (void)handleOutsideTap:(UITapGestureRecognizer*)tapGesture{
    [self dismissPopoverAnimated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
