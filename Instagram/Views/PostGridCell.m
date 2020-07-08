//
//  PostGridCell.m
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "PostGridCell.h"

@implementation PostGridCell
-(void) loadData{
    self.postImage.image=nil;
    self.postImage.file= self.post.image;
    [self.postImage loadInBackground];
}

@end
