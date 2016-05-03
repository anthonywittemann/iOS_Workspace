//
//  MoneyViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/3/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "MoneyViewController.h"
#import "TransactionModel.h"

@interface MoneyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyAmountTF;
@property (weak, nonatomic) IBOutlet UITextView *transactionMemoTV;
@property (weak, nonatomic) IBOutlet UILabel *moneyAmountLabel;
@property (strong,nonatomic) TransactionModel *model;

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model = [TransactionModel sharedModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO LONG - this is a fucking mess
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setUsesGroupingSeparator:NO];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
    double rawAmount = [_moneyAmountTF.text doubleValue];
    
    //update model
    [self.model setTransactionAmount:rawAmount];
     
    //update label
    self.moneyAmountLabel.text = [NSString stringWithFormat:@"%.2f",rawAmount];
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
