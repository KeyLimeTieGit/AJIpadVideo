//
//  VideoPlayerViewController.m
//  iPadVideoTest
//
//  Created by Sameer Siddiqui on 10/13/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "VideoTableViewCell.h"
#import "RealVideoViewController.h"


@interface VideoPlayerViewController () < UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"logo-1"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = (VideoTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell layoutSubviews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RealVideoViewController *vc = [RealVideoViewController create];
    [self presentViewController:vc animated:YES completion:nil];
    
}



@end
