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
@property (weak, nonatomic) IBOutlet UITextView *transactionMemoTV;
@property (weak, nonatomic) IBOutlet UILabel *moneyAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyAmountTF;
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
- (IBAction)reviewButtonClicked:(id)sender {
    //[self updateAmount:self.moneyAmountTF.text.doubleValue]; TODO - UNCOMMENT when fixed problem with TF
    [self.model setTransactionMemo:self.transactionMemoTV.text];
}

//TODO LONG - this is a fucking mess

- (IBAction)moneyAmountTFEditingDidEnd:(id)sender {
    [self updateAmount:self.moneyAmountTF.text.doubleValue];
}

- (IBAction) backgroundTouched:(id)sender {
    [self.moneyAmountTF resignFirstResponder];
    [self updateAmount:self.moneyAmountTF.text.doubleValue];
}

-(IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
    [self updateAmount:self.moneyAmountTF.text.doubleValue];
}

//TODO - HAVING PROBLEMS DISMISSING KEYBOARD AND UPDATING VALUE
-(void) updateAmount:(double) rawAmount{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setUsesGroupingSeparator:NO];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
    
    //update model
    [self.model setTransactionAmount:[numberFormatter stringFromNumber:[NSNumber numberWithFloat:rawAmount]]];
    
    //update label
    self.moneyAmountLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:rawAmount]];
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.model setTransactionMemo:textView.text];
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
