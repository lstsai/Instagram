//
//  PostCell.m
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void) loadData{
    self.usernameLabel.text=self.post.author.username;
    self.postCaption.text=self.post.caption;
    self.timeLabel.text=[[self.post.createdAt shortTimeAgoSinceNow] stringByAppendingString:@" ago"];
    self.likeCount.text= [NSString stringWithFormat:@"%@", self.post.likeCount];
    self.commentCount.text= [NSString stringWithFormat:@"%@", self.post.commentCount];
    self.postImage.image=nil;
    self.postImage.file = self.post.image;//load the image using the PFFile
    [self.postImage loadInBackground];
    
    if(self.post.author[@"profilePicture"]){
        self.profileImageView.file = self.post.author[@"profilePicture"];
        [self.profileImageView loadInBackground];
    }
    
    self.profileImageView.layer.masksToBounds=YES;
    self.profileImageView.layer.cornerRadius=self.profileImageView.bounds.size.width/2;
    self.profileImageView.layer.borderWidth=1;
    self.profileImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    UIGestureRecognizer *profileTapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImageView addGestureRecognizer:profileTapGesture];
    
}
- (IBAction)didTapLike:(id)sender {

    int likeValue = [self.post.likeCount intValue];
    if(!self.likeButton.selected)
    {
        self.post.likeCount = [NSNumber numberWithInt:likeValue + 1];
        self.likeButton.selected=YES;
        self.likeButton.tintColor=[UIColor redColor];
    }
    else
    {
        self.post.likeCount = [NSNumber numberWithInt:likeValue - 1];
        self.likeButton.selected=NO;
        self.likeButton.tintColor=[UIColor blackColor];
    }
    [self.post saveInBackground];
    [self.delegate tapLikeButton];
}
- (IBAction)didTapComment:(id)sender {
    [self.delegate didTapComment:self.post];
}
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{

    [self.delegate didTapUser:self.post.author];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
