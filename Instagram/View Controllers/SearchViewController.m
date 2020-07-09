//
//  SearchViewController.m
//  Instagram
//
//  Created by laurentsai on 7/9/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.searchBar.delegate=self;
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(![searchText isEqualToString:@""])
    {
        PFQuery *userQuery= [PFQuery queryWithClassName:@"_User"];
        //get username matches ignore case
        [userQuery whereKey:@"username" matchesRegex:searchText modifiers:@"i"];
        [userQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if(error)
            {
                NSLog(@"Error getting users %@", error.description);
            }
            else{
                NSLog(@"Success getting users %@", objects);
                self.users=objects;
                [self.tableView reloadData];
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserCell *userCell= [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    [userCell loadProfileCell:self.users[indexPath.row]];
    return userCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}
@end
