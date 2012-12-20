//
//  MasterViewController.h
//  STS
//
//  Created by Ian Bettison on 14/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *menuItems;
@property (strong, nonatomic) NSMutableArray *menuImages;
@property (strong, nonatomic) DetailViewController *detailViewController;

-(void)addItems;
@end
