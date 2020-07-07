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
    self.likeCount.text= [NSString stringWithFormat:@"%@", self.post.likeCount];
    self.postImage.image=nil;
    self.postImage.file = self.post[@"image"];//load the image using the PFFile
    [self.postImage loadInBackground];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
