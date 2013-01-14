//
//  LoginViewController.h
//  STS
//
//  Created by Ian Bettison on 14/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userEmailAddress;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *loginConfirmed;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSDictionary *permissions;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
- (BOOL)checkloginDetails:(NSString *)email withPassword:(NSString *)password;

- (IBAction)loginButtonPressed:(id)sender;

@end
