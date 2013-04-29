//
//  MasterViewController.h
//  CutomWebViewDemo
//
//  Created by Priyanka Shah on 02/04/13.
//  Copyright (c) 2013 Priyanka Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
