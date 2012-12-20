//
//  LoginViewController.m
//  STS
//
//  Created by Ian Bettison on 14/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonPressed:(id)sender {
    [sender resignFirstResponder];
    self.emailAddress                   = [self.userEmailAddress.text lowercaseString];
    self.password                       = self.userPassword.text;
    
    //if([self checkloginDetails:self.emailAddress withPassword:self.password]) { //confirmed login
        //check here if the permissions allow management of samples
        [self dismissViewControllerAnimated:YES completion:nil];
    //}
    //this is where we check for the email and password has been entered and call the method and reset the Viewcontroller to the splitScreenViewController    
}

- (BOOL)checkloginDetails:(NSString *)email withPassword:(NSString *)password{
    //this method checks the values from the database and determines if the login details are correct
    // Prepare the URL for fetching
    NSString *encodedPass               = [self.password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedEmail              = [self.emailAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *searchLocation            = [NSString stringWithFormat:@"http://sampletrack.ncl.ac.uk/json.php?func=searchjson&password=%@&email_address=%@", encodedPass, encodedEmail];
    NSURL *searchURL                    = [NSURL URLWithString:searchLocation];
    NSLog(@"searchURL = %@", searchURL);
    // Download and parse the JSON
    // need to do this on another thread
    
    NSData *JSONData                    = [[NSData alloc] initWithContentsOfURL:searchURL];
    NSLog(@"%@", JSONData);
    if ([JSONData length] > 0) {
        // If data was returned, parse it as JSON
        NSError *error                  = nil;
        NSDictionary *JSONDictionary    = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        if (!JSONDictionary) {
            NSLog(@"JSON parsing failed: %@", error);
        }
        self.loginConfirmed             = [NSString stringWithFormat:@"%@",[JSONDictionary valueForKey:@"login"]];
        self.userName                   = [NSString stringWithFormat:@"%@",[JSONDictionary valueForKey:@"user"]];
        self.permissions                = [JSONDictionary valueForKey:@"permission"];
        NSLog(@"Permissions = %@", self.permissions);
        NSLog(@"Add Users permission = %@", [self.permissions valueForKey:@"permission_name"]);
        NSLog(@"%@", self.loginConfirmed);
        for(NSDictionary *accessPermissions in self.permissions) {
            if ([[accessPermissions objectForKey:@"permission_name"] isEqualToString:@"Manage Samples"]) {
                NSLog(@"Permission Access for Manage Sample = %@", [accessPermissions valueForKey:@"permission_value"]);
            }
        }
        [JSONData autorelease];
        //show login message
        if([[JSONDictionary objectForKey:@"login"] isEqualToString:@"true"]) {
            [[[UIAlertView alloc] initWithTitle:@"Login" message:@"You have logged in to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
            return YES;
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not been able to login to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
            return NO;
        }
    
    } else {
        // Otherwise show an error message
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not been able to login to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        
    }
    [JSONData autorelease];
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)Finished {
    [Finished resignFirstResponder];
    return YES;
}

@end