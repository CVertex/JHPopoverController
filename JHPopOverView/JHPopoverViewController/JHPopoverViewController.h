//
//  JHPopoverViewController.h
//  JHPopOverView
//
//  Created by Jon Hocking on 12/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHPopoverViewController : NSObject

- (id)initWithViewController:(UIViewController*)viewController andContentSize:(CGSize)size;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@end
