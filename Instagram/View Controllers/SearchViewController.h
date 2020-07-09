//
//  SearchViewController.h
//  Instagram
//
//  Created by laurentsai on 7/9/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UserCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* users;

@end

NS_ASSUME_NONNULL_END
