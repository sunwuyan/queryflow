//
//  JSViewController.h
//  QueryFlow
//
//  Created by jinshan on 14-3-15.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSViewController : UIViewController<UITextFieldDelegate>{
   
}
@property(strong,nonatomic) UIActivityIndicatorView *activityView;

@property(strong,nonatomic) IBOutlet UITextField *wifi;

@property(strong,nonatomic) IBOutlet UITextField *from;

@property(strong,nonatomic) IBOutlet  UITextField *to;

@property(strong,nonatomic) IBOutlet UILabel *totalFlow;

@property(strong,nonatomic) IBOutlet UILabel *totalFlowPerHour;

@property (weak, nonatomic) IBOutlet UILabel *actualFlow;
@property (strong, nonatomic) NSMutableData *webData;

@property (strong, nonatomic) NSURLConnection *conn;

- (IBAction)closeKeyBoard:(id)sender;

-(IBAction)doQuery:(id)sender;

@end
