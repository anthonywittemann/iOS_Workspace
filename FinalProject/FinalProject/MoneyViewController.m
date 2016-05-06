//
//  MoneyViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/3/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "MoneyViewController.h"
#import "TransactionModel.h"

@interface MoneyViewController () <UITextViewDelegate,UITextFieldDelegate>
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
    _transactionMemoTV.delegate = self; //YES, I'm getting a warning, but it to get rid of the keyboard for the TextView when enter is pressed
    _moneyAmountTF.delegate = self;
    
    //load data from model into UI ELEMENTS
    _transactionMemoTV.text = [self.model getTransactionMemo];
    _moneyAmountTF.text = [self.model getTransactionAmount];
    _moneyAmountTF.text = [self.model getTransactionAmount];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reviewButtonClicked:(id)sender {
    //[self updateAmount:self.moneyAmountTF.text.doubleValue]; TODO - UNCOMMENT when fixed problem with TF
    [self.model setTransactionMemo:self.transactionMemoTV.text];
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
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


// used to get rid of keyboard when Done/Enter is pressed
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}


-(void) updateAmount:(float) rawAmount{
    //TODO LONG - sanitize input
    
    //update label
    self.moneyAmountLabel.text = [NSString stringWithFormat:@"$%.2f", rawAmount];
    NSLog(@"updateAmt Called");
    
    //update model
    NSString *str = [NSString stringWithFormat:@"$%.2f", rawAmount];

    [self.model setTheTransactionAmount:str];
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.model setTransactionMemo:textView.text];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //update the model
    [self.model setTheTransactionAmount:self.moneyAmountTF.text];
    [self.model setTransactionMemo:self.transactionMemoTV.text];
}


@end
