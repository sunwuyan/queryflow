//
//  JSViewController.m
//  QueryFlow
//
//  Created by jinshan on 14-3-15.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "JSViewController.h"
#import "JSSecViewController.h"

@interface NSString (ETSeparate)
- (NSArray *)stringSeparatedByString:(NSString *)string;
@end

@implementation NSString (ETSeparate)
- (NSArray *)stringSeparatedByString:(NSString *)string{
    return [self componentsSeparatedByString:string];
}
@end

@interface JSViewController ()

@end

@implementation JSViewController

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.wifi.text=@"10.68.199.105";
//    self.from.text=@"20140319102000";
//    self.to.text=@"20140319114000";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeKeyBoard:(id)sender {
    [self.wifi resignFirstResponder];
    [self.from resignFirstResponder];
    [self.to resignFirstResponder];
}

-(IBAction)doQuery:(id)sender{
    if(_activityView){
        [_activityView removeFromSuperview];
    }
    self.totalFlow.text=@"";
    self.totalFlowPerHour.text=@"";
    self.actualFlow.text=@"";
    [self activityIndicatorView];
    NSString *baseUrl=@"http://10.68.191.206/y/testdriver/t.php";
    NSString *query=[NSString stringWithFormat:@"?ip=%@&from=%@&to=%@&isMobile=1",self.wifi.text,self.from.text,self.to.text];
    NSString *urlString=[baseUrl stringByAppendingString:query];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *req=[[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:req delegate:self];
    if(conn){
        self.webData=[NSMutableData data];
    }
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods
// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [self.webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [self.webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.conn = nil;
    self.webData = nil;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    [self.activityView stopAnimating];
    _activityView=nil;
    NSString *theData = [[NSString alloc] initWithBytes:[self.webData mutableBytes]
                                                length:[self.webData length]
                                              encoding:NSUTF8StringEncoding];
    NSArray *flow=[theData stringSeparatedByString:@"&"];
    self.totalFlow.text=[flow objectAtIndex:0];
    self.totalFlowPerHour.text=[flow objectAtIndex:1];
    self.actualFlow.text=[flow objectAtIndex:2];
}

#pragma mark - Getters

- (UIActivityIndicatorView *)activityIndicatorView {
    
    if(!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.center = CGPointMake(self.view.frame.size.width/2, self.actualFlow.frame.origin.y+self.actualFlow.frame.size.height+18);
        _activityView.hidesWhenStopped = YES;
        [self.view addSubview:_activityView];
        [_activityView startAnimating];
    }
    return _activityView;
}

#pragma mask - textField delgate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 226);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset > 0) {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"当用户按下return键或者按回车键，keyboard消失");
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"输入框编辑完成以后，将视图恢复到原始状态");
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//- (IBAction)hideSoftKeyboard:(id)sender{
//    NSLog(@"点击输入框外部UIView（其实已经变成拉UIController），软键盘隐藏");
//    [self.view endEditing:YES];
//}

@end
