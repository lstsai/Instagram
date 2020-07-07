//
//  DetailViewController.h
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN
@import Parse;

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post *post;

-(void) loadPostDetails;
@end

NS_ASSUME_NONNULL_END
