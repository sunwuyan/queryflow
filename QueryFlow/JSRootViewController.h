//
//  JSRootViewController.h
//  QueryFlow
//
//  Created by jinshan on 14-3-19.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSViewController;
@class JSSecViewController;
@interface JSRootViewController : UIViewController
@property(strong,nonatomic) JSViewController *firstVc;
@property(strong,nonatomic) JSSecViewController *secVc;
@end