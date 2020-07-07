//
//  DetailViewController.m
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTools.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPostDetails];
}
-(void) loadPostDetails{
    
    self.captionLabel.text=self.post.caption;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%@", self.post.likeCount];
    self.nameLabel.text= self.post.author.username;
    self.timeLabel.text=[self.post.createdAt shortTimeAgoSinceNow];
    self.postImage.file = self.post.image;//load the image useing the PFFile
    [self.postImage loadInBackground];
    
    self.profilePic.layer.masksToBounds=YES;
    self.profilePic.layer.cornerRadius=self.profilePic.bounds.size.width/2;
    self.profilePic.layer.borderWidth=1;
    self.profilePic.layer.borderColor = [[UIColor lightGrayColor] CGColor];
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
