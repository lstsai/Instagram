//
//  CommentCell.h
//  Instagram
//
//  Created by laurentsai on 7/8/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "DateTools.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@protocol CommentCellDelegate
- (void)didTapUser: (PFUser *)user;
@end

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) id<CommentCellDelegate> delegate;
@property (nonatomic, weak) PFUser *author;

- (void) loadComment:(Comment*) comment;
-(void) didTapUserProfile:(UITapGestureRecognizer*) sender;
@end

NS_ASSUME_NONNULL_END
