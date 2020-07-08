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
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import "ProfileViewController.h"
@interface TimelineViewController ()<PostCellDelegate, ComposeViewControllerDelegate, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate, UIScrollViewDelegate>

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.postLimit=0;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TableViewHeaderView"];
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
    //go back to login
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}


-(void) refreshTimeline{
    //query for the post table
    PFQuery *postQuery= [PFQuery queryWithClassName:@"Post"];
    self.postLimit+=20;//get 20 more posts each time
    postQuery.limit=self.postLimit;//limit 20 posts
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];

    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<PFObject *> * _Nullable objects, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Error loading posts: %@", error.description);
        }
        else
        {
            //NSLog(@"Success getting post %@", objects);
            self.posts=objects;
            [self.tableView reloadData];
        }
        self.isMoreDataLoading=NO;
        [self.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *currCell= [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    currCell.post=self.posts[indexPath.row];
    currCell.delegate=self;
    [currCell loadData];//load cell data
    return currCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableViewHeaderView"];
    header.textLabel.text = ((Post *)self.posts[section]).author.username;
    return header;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (void)didPost {
    [self refreshTimeline];
    //[self showViewController:self sender:nil];
    //[self.tabBarController setSelectedIndex:0];

}
- (void)didTapUser: (PFUser *)user{
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if(!self.isMoreDataLoading){
         // Calculate the position of one screen length before the bottom of the results
         int scrollViewContentHeight = self.tableView.contentSize.height;
         int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
         
         // When the user has scrolled past the threshold, start requesting
         if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
             self.isMoreDataLoading = YES;
             [self refreshTimeline];
        }
     }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ComposeSegue"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"DetailsSegue"])
    {
        DetailViewController *detailsVC= segue.destinationViewController;
        UITableViewCell *tappedCell=sender;
        NSIndexPath *tappedIndex= [self.tableView indexPathForCell:tappedCell];
        detailsVC.post= self.posts[tappedIndex.row];
        [self.tableView deselectRowAtIndexPath:tappedIndex animated:YES];
    }
    else if([segue.identifier isEqualToString:@"profileSegue"])
    {
        ProfileViewController *profileVC= segue.destinationViewController;
        profileVC.user= (PFUser*) sender;
    }
}


@end
