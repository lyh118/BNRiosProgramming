//
//  BNRDateModifyController.m
//  Homepwner
//
//  Created by N3962 on 2015. 4. 27..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRDateModifyController.h"
#import "BNRItem.h"

@interface BNRDateModifyController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *modifyDateBtn;

@end

@implementation BNRDateModifyController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.datePicker.date = item.dateCreated;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 퍼스트 리스폰더 해제
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.dateCreated = self.datePicker.date;
}

- (IBAction)setModifiedDate:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
