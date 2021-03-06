//
//  Comment.h
//  Instagram
//
//  Created by laurentsai on 7/8/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>
    @property (nonatomic, strong) NSString *commentID;
    @property (nonatomic, strong) PFUser *author;
    @property (nonatomic, strong) NSString *commentText;
    @property (nonatomic, strong) NSDate *createdAt;
    @property (nonatomic, strong) Post *post;


+ (void) postComment:( NSString * _Nullable )comment forPost:(Post*) post withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
