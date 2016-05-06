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
    _transactionMemoTV.delegate=self; //YES, I'm getting a warning, but it to get rid of the keyboard for the TextView when enter is pressed
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

//--------------------------- METHODS TO GET RID OF THE GOD DAMN KEYBOARD ---------------------
- (IBAction)moneyAmountTFEditingDidEnd:(id)sender {
    [self updateAmount:self.moneyAmountTF.text.floatValue];
}

- (IBAction) backgroundTouched:(id)sender {
    [self.moneyAmountTF resignFirstResponder];
    [self.view endEditing:YES];
    [self updateAmount:self.moneyAmountTF.text.floatValue];
}

-(IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
    [self.view endEditing:YES];
    [self updateAmount:self.moneyAmountTF.text.floatValue];
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}



//TODO - HAVING PROBLEMS DISMISSING KEYBOARD AND UPDATING VALUE
-(void) updateAmount:(float) rawAmount{
    //TODO LONG - sanitize input
    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:rawAmount]];
//    
//    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [numberFormatter setUsesGroupingSeparator:NO];
//    [numberFormatter setMaximumFractionDigits:2];
//    [numberFormatter setMinimumFractionDigits:0];
//    [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
    
    //update label
    self.moneyAmountLabel.text = [NSString stringWithFormat:@"$%.2f", rawAmount];
    
    //update model -- TODO some sort of dangling pointer error
    //[self.model setTransactionAmount:[NSString stringWithFormat:@"$%.2f", rawAmount]];
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
