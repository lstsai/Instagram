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
#import "Post.h"
@interface TimelineViewController ()<UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self refreshTimeline];

}
//implement delegate method

- (IBAction)didTapLogout:(id)sender {
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

-(void) refreshTimeline{
    //query for the post table
    PFQuery *postQuery= [PFQuery queryWithClassName:@"Post"];
    postQuery.limit=20;//limit 20 posts
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable objects, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Error loading posts: %@", error.description);
        }
        else
        {
            self.posts=objects;
            [self.tableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *currCell= [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post= self.posts[indexPath.row];
    currCell.postCaption.text=post.caption;
    currCell.postImage.image=nil;
    
    currCell.postImage.file = post[@"image"];//load the image useing the PFFile
    [currCell.postImage loadInBackground];
    return currCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
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
