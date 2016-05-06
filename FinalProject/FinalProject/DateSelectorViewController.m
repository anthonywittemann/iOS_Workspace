//
//  DateSelectorViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/3/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "DateSelectorViewController.h"
#import "TransactionModel.h"

@interface DateSelectorViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (strong,nonatomic) TransactionModel *model;

@end

@implementation DateSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [TransactionModel sharedModel];
    // Do any additional setup after loading the view.
    
    [self.myDatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    if(self.selectedDateLabel.text != nil){
        if(self.model.isIsSeller){
            self.selectedDateLabel.text = self.model.getSellerDateAndTime;
        } else{
            self.selectedDateLabel.text = self.model.getBuyerDateAndTime;
        }
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.selectedDateLabel.text = strDate;
    
    if([self.model isIsSeller]){ //seller
        [self.model setSellerDateAndTime:strDate];
    } else{ //buyer
        [self.model setBuyerDateAndTime:strDate];
    }
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //update model
    if([self.model isIsSeller]){ //seller
        [self.model setSellerDateAndTime:self.selectedDateLabel.text];
    } else{ //buyer
        [self.model setBuyerDateAndTime:self.selectedDateLabel.text];
    }
}


@end
