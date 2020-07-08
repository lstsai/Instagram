//
//  PostGridCell.h
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface PostGridCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) Post *post;

-(void) loadData;
@end

NS_ASSUME_NONNULL_END
