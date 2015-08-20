//
//  WashingViewController.h
//  PalletManagementSystem
//
//  Created by Giang Tran Hoang on 8/19/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WashingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_ScanWashing;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Tag_Serial1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Tag_Pallet;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Tag_Serial2;
@property (weak, nonatomic) IBOutlet UIButton *btn_Confirm_Washing;
@property (weak, nonatomic) IBOutlet UIButton *btn_Device;

@end
