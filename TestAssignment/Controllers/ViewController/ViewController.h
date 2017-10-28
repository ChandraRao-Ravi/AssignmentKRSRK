//
//  ViewController.h
//  TestAssignment
//
//  Created by Chandra Rao on 26/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UILabel *lblTerms;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIView *viewDismiss;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

- (IBAction)btnSubmitClicked:(id)sender;
- (IBAction)btnAgreeTerms:(id)sender;
- (IBAction)btnDoneClicked:(id)sender;

@end

