//
//  UserCell.m
//  Instagram
//
//  Created by laurentsai on 7/9/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void) loadProfileCell:(PFUser*) user{
    self.profileImage.image=nil;
    self.profileImage.layer.masksToBounds=YES;
    self.profileImage.layer.cornerRadius=self.profileImage.bounds.size.width/2;
    if(user[@"profilePicture"])
    {
        self.profileImage.file=user[@"profilePicture"];
        [self.profileImage loadInBackground];
    }
    self.usernameLabel.text=user.username;
    self.bioLabel.text=user[@"bio"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
