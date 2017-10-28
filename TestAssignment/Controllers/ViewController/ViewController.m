//
//  ViewController.m
//  TestAssignment
//
//  Created by Chandra Rao on 26/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setHidden:YES];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtDate setInputView:datePicker];
    
    [self.txtDate setInputAccessoryView:self.viewDismiss];
    [self.txtName setInputAccessoryView:self.viewDismiss];
    [self.txtAddress setInputAccessoryView:self.viewDismiss];
    
    [self.btnAgree setSelected:NO];
    [self.btnAgree setBackgroundColor:[UIColor redColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)btnSubmitClicked:(id)sender {
    
    if ([self checkForBlanks:self.txtName]) {
        ShowAlertControllerWithOkOption(@"Alert!", @"Please enter Name.", @"Ok", self);
    } else if([self checkForBlanks:self.txtDate]){
        ShowAlertControllerWithOkOption(@"Alert!", @"Please enter Date.", @"Ok", self);
    } else if([self checkForBlanks:self.txtAddress]){
        ShowAlertControllerWithOkOption(@"Alert!", @"Please enter Address.", @"Ok", self);
    } else if(!self.btnAgree.isSelected){
        ShowAlertControllerWithOkOption(@"Alert!", @"Please Agree to terms and conditions.", @"Ok", self);
    } else {
        
        if ([UtilityClass isConnectedToInternet]) {
            ListViewController *listviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
            [self.navigationController pushViewController:listviewController animated:YES];
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"You are not conected to the internet!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSArray *arrList = [CoreDataGlobalClass getListingSavedFromJson];
                if ([arrList isKindOfClass:[NSArray class]] && arrList.count > 0) {
                    ListViewController *listviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                    listviewController.arrTableData = [arrList mutableCopy];
                    [self.navigationController pushViewController:listviewController animated:YES];
                } else {
                    ShowAlertControllerWithOkOption(@"Alert!", @"Sorry! No data available.", @"Ok", self);
                }
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
    }
    
}

- (IBAction)btnAgreeTerms:(id)sender {
    
    if (self.btnAgree.isSelected) {
        [self.btnAgree setSelected:NO];
        [self.btnAgree setBackgroundColor:[UIColor redColor]];
    } else {
        [self.btnAgree setSelected:YES];
        [self.btnAgree setBackgroundColor:[UIColor greenColor]];
    }
    
}

- (IBAction)btnDoneClicked:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - UItextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Other Methods

-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtDate.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.txtDate.text = [NSString stringWithFormat:@"%@",dateString];
}

-(BOOL)checkForBlanks:(UITextField *)textfield{
    NSString *rawString = [textfield text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
