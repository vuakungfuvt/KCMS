//
//  PackagingViewController.h
//  PalletManagementSystem
//
//  Created by Giang Tran Hoang on 8/19/15.
//  Copyright (c) 2015 Giang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackagingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_Pallet_List;
@property (weak, nonatomic) IBOutlet UITextField *txf_search_Pallet;
@property (weak, nonatomic) IBOutlet UITableView *tbl_List_Barcode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Packaging;
@property (weak, nonatomic) IBOutlet UIButton *btn_Scan_Barcode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Barcode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Pallet_Tag1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Pallet_Tag2;
@property (weak, nonatomic) IBOutlet UIButton *btn_Confirm_Packaging;

@property (weak, nonatomic) IBOutlet UIButton *btn_Scan_Device;
@property (weak, nonatomic) IBOutlet UIButton *btn_Pallet_IC;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sankyu_Barcode;
@end
