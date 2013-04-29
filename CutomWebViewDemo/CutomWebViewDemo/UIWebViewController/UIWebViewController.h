//
//  UIWebViewController.h
//  CustomWebViewDemo
//
//  Created by Priyanka Shah on 02/04/13.
//  Copyright (c) 2013 Priyanka Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView*        webview;
    IBOutlet UIBarButtonItem*  backButton;
    IBOutlet UIBarButtonItem*  forwardButton;
    IBOutlet UIBarButtonItem*  refreshButton;
    IBOutlet UIBarButtonItem*  stopButton;
    IBOutlet UIActivityIndicatorView*  activityView;
    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
}
/**
 * Navigate to the given URL.
 */
- (void)openURL:(NSURL*)URL;

/**
 * Load the given request using UIWebView's loadRequest:.
 *
 * @param request  A URL request identifying the location of the content to load.
 */
- (void)openRequest:(NSURLRequest*)request;

-(void)openhtml:(NSString*)htmlstring WithbaseURL:(NSURL*)url;
@end
