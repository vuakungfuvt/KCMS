//
//  ReceivingViewController.h
//  PalletManagementSystem
//
//  Created by Giang Tran Hoang on 8/19/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_number_Fail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Fail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_number_Success;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Success;
@property (weak, nonatomic) IBOutlet UITableView *tbl_Receiving;
@property (weak, nonatomic) IBOutlet UIButton *btn_Device_Scan;

@end
