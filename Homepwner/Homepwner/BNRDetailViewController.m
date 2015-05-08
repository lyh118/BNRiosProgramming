//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by N3962 on 2015. 4. 23..
//  Copyright (c) 2015년 BigNerdRanch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRDateModifyController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation BNRDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // 날짜를 문자열로 변환
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.imageKey;
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 퍼스트 리스폰더 해제
    [self.view endEditing:YES];
    
    /*
     * 포인터를 가지고 있어서 데이터가 자동으로(?) 바뀌는 건가??
     * 포인터 개념이 없는 언어의 경우 
     *  - 객체를 생성해서 View에 전달
     *  - View에서 전달 받은 객체를 이용해서 처리
     *  - 다시 객체 전달
     */
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 * Chap10.은메달과제
 * - 퍼스트 리스폰더를 해제
 */
/*
- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
*/
/*
 * 키보드 숨기기
 * View를 UIControl 인스턴스로 변경 후
 */
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

/*
 * Chap10.금메달과제
 */
- (IBAction)goDateModifyView:(id)sender
{
    BNRDateModifyController *dateModifyController = [[BNRDateModifyController alloc] init];
    
    dateModifyController.item = self.item;
    
    [self.navigationController pushViewController:dateModifyController animated:YES];
}


- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:self.item.imageKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Chap11.ToolBar Camera Btn
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    /*
     * 카메라가 있는 장치라면 사진을 찍고,
     * 아니면 사진 라이브러리에서 사진을 가져온다
     */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)deleteItemImage:(id)sender
{
    self.imageView.image = nil;
    
    [[BNRImageStore sharedStore] deleteImageForKey:self.item.imageKey];
}

@end
