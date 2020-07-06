//
//  LoginViewController.m
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapSignUp:(id)sender {
    [self.activityIndicator startAnimating];
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Signing Up"
           message:@"Usernamne or password cannot be empty."
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //nothing
    }];
    [alert addAction:okAction];
    if( [newUser.username isEqualToString:@""] || [newUser.password isEqualToString:@""]  )
        [self presentViewController:alert animated:YES completion:^{
            //nobthing
        }];
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [alert setMessage:[NSString stringWithFormat: @"%@", error.localizedDescription]];
            [self presentViewController:alert animated:YES completion:^{
                //nobthing
            }];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];//go to timeline after login
        }
        [self.activityIndicator stopAnimating];

    }];
}
- (IBAction)didTapLogin:(id)sender {
    [self.activityIndicator startAnimating];
    
    NSString *username= self.usernameField.text;
    NSString *password= self.passwordField.text;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Logging In"
           message:@"Incorrect usernamne or password "
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //nothing
    }];
    [alert addAction:okAction];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil)
        {
            [alert setMessage:[NSString stringWithFormat: @"%@", error.description]];
            [self presentViewController:alert animated:YES completion:^{
                //nobthing
            }];
            NSLog(@"User log in failed: %@", error.localizedDescription);
        }
        else
        {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
        [self.activityIndicator stopAnimating];

    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
