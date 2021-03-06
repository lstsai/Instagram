//
//  Comment.m
//  Instagram
//
//  Created by laurentsai on 7/8/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@dynamic commentID;
@dynamic author;
@dynamic commentText;
@dynamic createdAt;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}
+ (void) postComment:( NSString * _Nullable )comment forPost:(Post*) post withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    //create post with given info
    Comment *newComment= [Comment new];
    newComment.commentText= comment;
    newComment.author=[PFUser currentUser];
    newComment.post= post;
    [newComment saveInBackgroundWithBlock:completion];
}

@end
