//
//  UserCell.h
//  Instagram
//
//  Created by laurentsai on 7/9/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

-(void) loadProfileCell:(PFUser*) user;
@end

NS_ASSUME_NONNULL_END
