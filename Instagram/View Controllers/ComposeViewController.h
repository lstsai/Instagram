//
//  ComposeViewController.h
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "TimelineViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate

- (void)didPost;

@end
@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
