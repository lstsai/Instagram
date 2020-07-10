//
//  DetailViewController.m
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTools.h"
#import "CommentsViewController.h"
#import "ProfileViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPostDetails];
}

-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"appear");
    [self refreshData];
}

-(void) loadPostDetails{
    self.captionLabel.text=self.post.caption;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%@", self.post.likeCount];
    self.commentCount.text=[NSString stringWithFormat:@"%@", self.post.commentCount];
    self.nameLabel.text= self.post.author.username;
    self.nameLabel2.text= self.post.author.username;
    self.timeLabel.text=[self.post.createdAt timeAgoSinceNow];
    self.postImage.file = self.post.image;//load the image useing the PFFile
    [self.postImage loadInBackground];
    
    [self.profilePic setUserInteractionEnabled:YES];
    self.profilePic.layer.masksToBounds=YES;
    self.profilePic.layer.cornerRadius=self.profilePic.bounds.size.width/2;
    self.profilePic.layer.borderWidth=1;
    self.profilePic.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    if(self.post.author[@"profilePicture"])
    {
        self.profilePic.file=self.post.author[@"profilePicture"];
        [self.profilePic loadInBackground];
    }
}

-(void) refreshData{
    PFQuery *postQuery=[PFQuery queryWithClassName:@"Post"];
    [postQuery whereKey:@"objectId" equalTo:self.post.objectId];
    [postQuery includeKey:@"author"];
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Error reloading post %@", error.description);
        }
        else
        {
            NSLog(@"Success reloading post");
            self.post=[objects firstObject];
            [self loadPostDetails];
        }
    }];
}

- (IBAction)didTapLike:(id)sender {

    int likeValue = [self.post.likeCount intValue];
    if(!self.likeButton.selected)
        self.post.likeCount = [NSNumber numberWithInt:likeValue + 1];
    else
        self.post.likeCount = [NSNumber numberWithInt:likeValue - 1];

    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            if(!self.likeButton.selected)
            {
                self.likeButton.selected=YES;
                self.likeButton.tintColor=[UIColor redColor];
            }
            else
            {
                self.likeButton.selected=NO;
                self.likeButton.tintColor=[UIColor blackColor];
            }
        }
        else{
            NSLog(@"Error liking post: %@", error.localizedDescription);
        }
    }];
    [self refreshData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"commentSegue"])
    {
        CommentsViewController *commentVC= (CommentsViewController*)segue.destinationViewController;
        commentVC.post=self.post;
    }
    else if([segue.identifier isEqualToString:@"profileSegue"])
    {
        ProfileViewController *profileVC= (ProfileViewController*)segue.destinationViewController;
        profileVC.user=self.post.author;
    }
}

@end
