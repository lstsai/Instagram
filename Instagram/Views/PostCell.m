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
    self.postImage.image=nil;
    self.postImage.file = self.post[@"image"];//load the image using the PFFile
    [self.postImage loadInBackground];
    
    self.profileImageView.layer.masksToBounds=YES;
    self.profileImageView.layer.cornerRadius=self.profileImageView.bounds.size.width/2;
    self.profileImageView.layer.borderWidth=1;
    self.profileImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
