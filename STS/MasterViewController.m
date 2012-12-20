//
//  MasterViewController.m
//  STS
//
//  Created by Ian Bettison on 14/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [self addItems];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addItems{ //this method creates two arrays listing the menu text and the image for the Master ViewController
    
    self.menuItems = [[NSMutableArray alloc]init];
    self.menuImages = [[NSMutableArray alloc]init];
    
    [self.menuItems addObject:@"Scan New Receipts"];
    [self.menuItems addObject:@"Scan Samples Out"];
    [self.menuItems addObject:@"Scan Samples In"];
    [self.menuItems addObject:@"Identify Container"];
    [self.menuItems addObject:@"New Container"];
    [self.menuItems addObject:@"Logout & Exit"];
    [self.menuImages addObject:@"ScanReceipt.png"];
    [self.menuImages addObject:@"ScanOut.png"];
    [self.menuImages addObject:@"ScanIn.png"];
    [self.menuImages addObject:@"identify.png"];
    [self.menuImages addObject:@"NewContainer.png"];
    [self.menuImages addObject:@"Logout.png"];
    [self.menuItems autorelease];
    [self.menuImages autorelease];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];


    NSString *object = [self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = object;
    cell.imageView.image = [UIImage imageNamed:[self.menuImages objectAtIndex:indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row = %@", [self.menuItems objectAtIndex:indexPath.row]);
    self.detailViewController.detailItem = [self.menuItems objectAtIndex:indexPath.row];
    NSLog(@"detailItem = %@", self.detailViewController.detailItem);
}

@end
