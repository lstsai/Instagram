//
//  CommentCell.m
//  Instagram
//
//  Created by laurentsai on 7/8/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void) loadComment:(Comment*) comment{
    //NSLog(@"Load comment %@", self.comment);
    self.profileImage.layer.masksToBounds=YES;
    self.profileImage.layer.cornerRadius=self.profileImage.bounds.size.width/2;
    UIGestureRecognizer *profileTapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage setUserInteractionEnabled:YES];
    [self.profileImage addGestureRecognizer:profileTapGesture];
    self.author=comment.author;
    if(comment.author[@"profilePicture"])
    {
        self.profileImage.file=comment.author[@"profilePicture"];
        [self.profileImage loadInBackground];
    }
    self.commentLabel.text=comment.commentText;
    self.timeLabel.text=[comment.createdAt shortTimeAgoSinceNow];
    self.usernameLabel.text=comment.author.username;
    
}

-(void) didTapUserProfile:(UITapGestureRecognizer*) sender{
    [self.delegate didTapUser:self.author];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
