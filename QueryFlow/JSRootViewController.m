//
//  JSRootViewController.m
//  QueryFlow
//
//  Created by jinshan on 14-3-19.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "JSRootViewController.h"
#import "JSViewController.h"
#import "JSSecViewController.h"
@interface JSRootViewController ()

@end

@implementation JSRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.firstVc = [[JSViewController alloc]
                               initWithNibName:@"JSViewController" bundle:nil];
    [self.view insertSubview:self.firstVc.view atIndex:0];
    UIImage *image=[UIImage imageNamed:@"help.png"];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 20, 45, 20);
    button1.backgroundColor=[UIColor clearColor];
    
    [button1 setImage:image forState:UIControlStateNormal];
    [self.view insertSubview:button1 atIndex:100];
    button1.layer.anchorPoint=CGPointMake(0,0);
    button1.center=CGPointMake(self.view.frame.size.width-50, button1.frame.size.height);
    [button1 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (self.firstVc.view.superview == nil) {
        self.firstVc = nil;
    } else {
        self.secVc = nil;
    }
}

- (void)butClick:(id)sender {
    [UIView beginAnimations:@"View Flip" context:nil];      // bold
    [UIView setAnimationDuration:1.25];                     // bold
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];   // bold
    if (self.secVc.view.superview == nil) {
        if (self.secVc == nil) {
            self.secVc =
            [[JSSecViewController alloc] initWithNibName:@"JSSecViewController"
                                                      bundle:nil];
        }
        [UIView setAnimationTransition:                         // bold
         UIViewAnimationTransitionFlipFromRight                 // bold
                               forView:self.view cache:YES];    // bold
        
        [self.firstVc.view removeFromSuperview];
        [self.view insertSubview:self.secVc.view atIndex:0];
    } else {
        if (self.firstVc == nil) {
            self.firstVc =
            [[JSViewController alloc] initWithNibName:@"JSViewController"
                                                    bundle:nil];
        }
        [UIView setAnimationTransition:                         // bold
         UIViewAnimationTransitionFlipFromLeft                  // bold
                               forView:self.view cache:YES];    // bold
        [self.secVc.view removeFromSuperview];
        [self.view insertSubview:self.firstVc.view atIndex:0];
    }
    [UIView commitAnimations];                                   // bold
}

@end
