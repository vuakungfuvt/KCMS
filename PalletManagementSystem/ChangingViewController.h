//
//  ChangingViewController.h
//  PalletManagementSystem
//
//  Created by Giang Tran Hoang on 8/19/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_Original_Scan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Original_Tag_Pallet;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Original_Tag_Serial1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Original_Tag_Serial2;
@property (weak, nonatomic) IBOutlet UIButton *btn_Confirm_Changing;

@property (weak, nonatomic) IBOutlet UIButton *btn_New_Scan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_New_Tag_Pallet;
@property (weak, nonatomic) IBOutlet UILabel *lbl_New_Tag_Serial1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_New_Tag_Serial2;
@property (weak, nonatomic) IBOutlet UIButton *btn_Scan_Device;

@end
