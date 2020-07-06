//
//  TimelineViewController.m
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "TimelineViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"here in Logging out");

}
- (IBAction)didTapLogout:(id)sender {
    NSLog(@"here in Logging out");
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error)
            NSLog(@"Error Logging out: %@", error.description);
        else
            NSLog(@"Success Logging out");
    }];
    
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
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
