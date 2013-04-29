//
//  UIWebViewController.m
//  CustomWebViewDemo
//
//  Created by Priyanka Shah on 02/04/13.
//  Copyright (c) 2013 Priyanka Shah. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

@implementation UIWebViewController

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
    // Do any additional setup after loading the view from its nib.
    webview.delegate= self;
    if (self.navigationController.navigationItem == nil) {
        navBar.hidden= NO;
    }else navBar.hidden = YES;
    webview.frame = CGRectMake(0,(self.navigationController.navigationItem == nil)?44:0, self.view.frame.size.width, self.view.frame.size.height);
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [webview stopLoading];
    webview.delegate = nil;
    [super dealloc];
}
#pragma mark - 
-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  Open Link in webview
- (void)openURL:(NSURL*)URL{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    [self openRequest:request];
}
- (void)openRequest:(NSURLRequest*)request{
    [webview loadRequest:request];
}

-(void)openhtml:(NSString*)htmlstring WithbaseURL:(NSURL*)url{
    [webview loadHTMLString:htmlstring baseURL:url];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([self isAppURL:request.URL]) {
        if (self.navigationController.navigationItem == nil) {
           [self dismissViewControllerAnimated:YES completion:nil];
        }else [self.navigationController popViewControllerAnimated:YES];
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    backButton.enabled = [webview canGoBack];
    forwardButton.enabled = [webview canGoForward];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
    [activityView startAnimating];
    [self replaceLoadingWithStop];
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [activityView stopAnimating];
    [self replaceLoadingWithStop];
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
    self.title = [webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.navigationController.navigationItem == nil) {
        navBar.topItem.title = [webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    [self webViewDidFinishLoad:webView];
}

-(void)replaceLoadingWithStop{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:toolBar.items];
    if (webview.isLoading) {
        [arr replaceObjectAtIndex:4 withObject:stopButton];
    }else{
         [arr replaceObjectAtIndex:4 withObject:refreshButton];
    }
    [toolBar setItems:arr];
}

#pragma mark - validate url
- (BOOL)isAppURL:(NSURL*)URL {
    return [self isExternalURL:URL]
    || ([[UIApplication sharedApplication] canOpenURL:URL]
        && ![self isSchemeSupported:URL.scheme]
        && ![self isWebURL:URL]);
}
- (BOOL)isWebURL:(NSURL*)URL {
    return [URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isExternalURL:(NSURL*)URL {
    if ([URL.host isEqualToString:@"maps.google.com"]
        || [URL.host isEqualToString:@"itunes.apple.com"]
        || [URL.host isEqualToString:@"phobos.apple.com"]) {
        return YES;
        
    } else {
        return NO;
    }
}
- (BOOL)isSchemeSupported:(NSString*)scheme {
    if (scheme == nil) {
        return NO;
    }
   NSArray *_schemes = [[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"] objectAtIndex:0]objectForKey:@"CFBundleURLSchemes"];
    if (_schemes) {
        int index = [_schemes indexOfObject:scheme];
        if (index > -1) {
            return YES;
        }
    }
    return NO;
}
@end
