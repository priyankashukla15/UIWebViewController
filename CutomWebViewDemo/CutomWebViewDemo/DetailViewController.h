//
//  DetailViewController.h
//  CutomWebViewDemo
//
//  Created by Priyanka Shah on 02/04/13.
//  Copyright (c) 2013 Priyanka Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
