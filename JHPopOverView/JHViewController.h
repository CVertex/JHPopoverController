//
//  JHViewController.h
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHPopoverViewController;

@interface JHViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) JHPopoverViewController *popoverController;

- (IBAction)buttonPressed:(id)sender;

@end
