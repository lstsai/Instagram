//
//  ProfileViewController.h
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PostGridCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

-(void) configureLayout;
-(void) refreshData;
-(void) didTapProfilePic;
-(void) loadProfileImage;

@end

NS_ASSUME_NONNULL_END
