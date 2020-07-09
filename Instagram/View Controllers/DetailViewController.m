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
    self.timeLabel.text=[self.post.createdAt shortTimeAgoSinceNow];
    self.postImage.file = self.post.image;//load the image useing the PFFile
    [self.postImage loadInBackground];
    
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
}


@end
