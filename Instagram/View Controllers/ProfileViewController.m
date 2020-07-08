//
//  ProfileViewController.m
//  Instagram
//
//  Created by laurentsai on 7/7/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "ProfileViewController.h"
#import "DetailViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    if(self.user==nil)
        self.user=PFUser.currentUser;

    [self configureLayout];
    [self refreshData];
    [self.collectionView reloadData];
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"appear");
    if(self.user.username!= PFUser.currentUser.username)
    {
        self.logoutButton.titleLabel.text=@"";
        self.logoutButton.userInteractionEnabled=NO;
    }
    else{
        self.logoutButton.titleLabel.text=@"Logout";
        self.logoutButton.userInteractionEnabled=YES;
    }
    [self refreshData];

}
-(void) configureLayout{
    
    int minMargins=1;
    UICollectionViewFlowLayout *layout= (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;//cast to supress warning
    layout.minimumInteritemSpacing=minMargins;
    layout.minimumLineSpacing=minMargins;
    
    CGFloat postersPerLine=3;
    CGFloat itemWidth=(self.collectionView.frame.size.width-layout.minimumInteritemSpacing*(postersPerLine-1)-2*minMargins)/postersPerLine;
    //scale it to be the size you want per line,take into account interitem spacing and the margins of screen
    
    layout.itemSize=CGSizeMake(itemWidth, itemWidth);
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostGridCell *postGC= [collectionView dequeueReusableCellWithReuseIdentifier:@"PostGridCell" forIndexPath:indexPath];
    postGC.post= self.posts[indexPath.item];
    [postGC loadData];
    return postGC;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}
- (void) refreshData{
    PFQuery *profileQuery= [PFQuery queryWithClassName:@"Post"];
    [profileQuery includeKey:@"author"];
    [profileQuery whereKey:@"author" equalTo:self.user];
    
    [profileQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(error)
            NSLog(@"Error Loading profile: %@", error.localizedDescription);
        else{
            self.posts=objects;
            self.usernameLabel.text=self.user.username;
            self.postCount.text=[NSString stringWithFormat:@"%lu", self.posts.count];
            NSLog(@"Sucess loading profile, %@", self.usernameLabel.text );
        }
        [self.collectionView reloadData];
    }];
}
- (IBAction)didTapLogout:(id)sender {
    NSLog(@"logout");
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error)
            NSLog(@"Error Logging out: %@", error.description);
        else
            NSLog(@"Success Logging out");
    }];
    //go back to login
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"porfileDetailsSegue"])
    {
        DetailViewController *deetVC= segue.destinationViewController;
        UICollectionViewCell *tappedCell= (UICollectionViewCell *) sender;
        NSIndexPath *indexPath= [self.collectionView indexPathForCell:tappedCell];
        Post *tappedPost= self.posts[indexPath.item];
        deetVC.post= tappedPost;
    }
}

@end
