//
//  JHViewController.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHViewController.h"
#import "JHPopoverViewController.h"
#import "ViewController.h"
@implementation JHViewController
@synthesize popoverController;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (IBAction)buttonPressed:(id)sender{
    
    ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    self.popoverController = nil;
    self.popoverController = [[JHPopoverViewController alloc]initWithViewController:vc andContentSize:vc.view.frame.size];
    [self.popoverController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
    
    /*
    // colour customisation with a single colour
    [self.popoverController setColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0] forKey:JHPopoverViewFillColorKey];
    
    // colour customisation with a dictionary
    
    NSArray *objects = [NSArray arrayWithObjects:[UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0],[UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0],[UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0],[UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0], nil];
    NSArray *keys = [NSArray arrayWithObjects:JHPopoverViewFillColorKey, JHPopoverViewInnerStrokeColorKey, JHPopoverViewOuterStrokeColorKey, JHPopoverViewShadowColorKey, nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [self.popoverController setColorsDictionary:dict];
     */
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
