//
//  MenuViewController.m
//  PalletManagementSystem
//
//  Created by Giang Tran Hoang on 8/19/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import "MenuViewController.h"
#import "ReceivingViewController.h"
#import "PackagingViewController.h"
#import "WashingViewController.h"
#import "ChangingViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set Title of this Screen
   self.title = @"Menu";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

    // Event when press button Receiving
- (IBAction)btn_Receiving_TouchUp_Inside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReceivingViewController *receivingViewCcontroller = (ReceivingViewController *) [sb instantiateViewControllerWithIdentifier:@"receiving"];
    [self.navigationController pushViewController:receivingViewCcontroller animated:YES];
}

    // Event when press button Packaging
- (IBAction)btn_Packaging_TouchUp_Inside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PackagingViewController *packagingViewCcontroller = (PackagingViewController *) [sb instantiateViewControllerWithIdentifier:@"packaging"];
    [self.navigationController pushViewController:packagingViewCcontroller animated:YES];
}

    // Event when press button Washing
- (IBAction)btn_Washing_TouchUp_Inside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WashingViewController *washingViewCcontroller = (WashingViewController *) [sb instantiateViewControllerWithIdentifier:@"washing"];
    [self.navigationController pushViewController:washingViewCcontroller animated:YES];
}

    // Event when press button Changing
- (IBAction)btn_Changing_TouchUp_Inside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangingViewController *changingViewCcontroller = (ChangingViewController *) [sb instantiateViewControllerWithIdentifier:@"changing"];
    [self.navigationController pushViewController:changingViewCcontroller animated:YES];
}


@end
