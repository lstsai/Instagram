//
//  PostCell.h
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "DateTools.h"

@import Parse;
NS_ASSUME_NONNULL_BEGIN
@class PostCell;

@protocol PostCellDelegate
- (void)didTapUser: (PFUser *)user;
@end
@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (nonatomic, strong) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (nonatomic, weak) id<PostCellDelegate> delegate;

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender;
- (void) loadData;
@end

NS_ASSUME_NONNULL_END
