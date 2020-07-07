//
//  Post.m
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic createdAt;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}
+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    //create post with given info
    Post *newPost= [Post new];
    newPost.image= [self getPFFileFromImage:image];
    newPost.caption=caption;
    newPost.author=[PFUser currentUser];
    newPost.likeCount=@(0);
    newPost.commentCount=@(0);
    
    [newPost saveInBackgroundWithBlock:completion];
}
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if(image)//no image
    {
        NSData *imageData = UIImagePNGRepresentation(image);
        if(imageData)
            return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    }
    
    return nil;//if image data or image is nil
}

@end
