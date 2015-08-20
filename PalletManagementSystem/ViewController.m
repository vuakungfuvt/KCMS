//
//  ViewController.m
//  PalletManagementSystem
//
//  Created by GiangTran on 8/18/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    // Event when press button Start
- (IBAction)btn_Start_TouchUp_Inside:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuViewController *menuViewCcontroller = (MenuViewController *) [sb instantiateViewControllerWithIdentifier:@"menu"];
    [self.navigationController pushViewController:menuViewCcontroller animated:YES];
}

@end
