//
//  TimelineViewController.h
//  Instagram
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimelineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *posts;
-(void) refreshTimeline;

@end

NS_ASSUME_NONNULL_END
