//
//  JHViewController.m
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import "JHViewController.h"
#import "JHPopoverView.h"
#import "JHPopoverViewController.h"
#import "ViewController.h"
@implementation JHViewController

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
//    JHPopoverView *jhPopOverView = [[JHPopoverView alloc]initWithFrame:CGRectMake(40, 40, 300, 400)];
//    [self.view addSubview:jhPopOverView];
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
    
    JHPopoverViewController *popOverViewController = [[JHPopoverViewController alloc]initWithViewController:vc andContentSize:vc.view.frame.size];
    [popOverViewController presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
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
