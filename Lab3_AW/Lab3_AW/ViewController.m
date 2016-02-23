//
//  ViewController.m
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/8/16.
//  ****************USING 3 late days**********************
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//
//

#import "ViewController.h"
#import "DataModel.h"

@interface ViewController ()
@property (strong, nonatomic) DataModel *model;


//TODO add IBOutlets for lebels, control objects
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalForTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWithTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;


@property (weak, nonatomic) IBOutlet UIButton *clearAllButton;
@property (weak, nonatomic) IBOutlet UIStepper *splitStepper;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UISwitch *tipIncludesTaxSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taxPercentageSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NEEDED TO ACCESS PUBLIC PROPERTIES AND METHODS IN MODEL
    //self.model = [[DataModel alloc] init];
    self.model = [DataModel sharedModel]; // for singleton design pattern
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
    float bill = self.billTextField.text.floatValue;
    //update textFields
    [self updateValuesWithBill:bill tRate:self.model.taxRate TIC:self.model.tipIncludesTax tp:self.model.tipPercentage sm:self.model.splitNum];
}


/************* ADDED IBActions ****************/

- (IBAction)segmentedControlTax:(id)sender {
    float tr = 0.075;
    switch ([sender selectedSegmentIndex]) {
        case 0: //7.5
            tr = 0.075;
            break;
        case 1: //8.0
            tr = 0.080;
            break;
        case 2: //8.5
            tr = 0.085;
            break;
        case 3: //9.0
            tr = 0.090;
            break;
        case 4: //9.5
            tr = 0.095;
            break;
        default:
            break;
    }
    //update text fields
    [self updateValuesWithBill:self.model.bill tRate:tr TIC:self.model.tipIncludesTax tp:self.model.tipPercentage sm:self.model.splitNum];
}

- (IBAction)switchFlippedTipIncludesTax:(id)sender {
    bool tipIncludesTax = self.switchOutlet.isOn;
    [self updateValuesWithBill:self.model.bill tRate:self.model.taxRate TIC:tipIncludesTax tp:self.model.tipPercentage sm:self.model.splitNum];
}

- (IBAction)sliderModifiedTip:(id)sender {
    //TODO
    float sliderVal = self.sliderOutlet.value / 100.0;
    [self updateValuesWithBill:self.model.bill tRate:self.model.taxRate TIC:self.model.tipIncludesTax tp:sliderVal sm:self.model.splitNum];
}

- (IBAction)stepperIncrementedSplitBill:(id)sender {
    int stepperVal = (int)self.stepperOutlet.value;
    [self updateValuesWithBill:self.model.bill tRate:self.model.taxRate TIC:self.model.tipIncludesTax tp:self.model.tipPercentage sm:stepperVal];
    
}

- (IBAction)clearAllPressed:(id)sender {
    //Helper method Actionsheet, UIAlertController
    [self bringUpAlertController];
}


- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
    float bill = self.billTextField.text.floatValue;
    //update textFields
    [self updateValuesWithBill:bill tRate:self.model.taxRate TIC:self.model.tipIncludesTax tp:self.model.tipPercentage sm:self.model.splitNum];
}

- (void) touchesBegan: (NSSet *)touches
            withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.billTextField isFirstResponder] &&
        [touch view] != self.billTextField) {
        [self.billTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction) backgroundTouched:(id)sender {
    [self.billTextField resignFirstResponder];
    float bill = self.billTextField.text.floatValue;
    //update textFields
    [self updateValuesWithBill:bill tRate:self.model.taxRate TIC:self.model.tipIncludesTax tp:self.model.tipPercentage sm:self.model.splitNum];
}


/************* Helper Methods ****************/



- (void) clearAllValues{
    //clear all values and update labels
    [self updateValuesWithBill:0.0 tRate:0.075 TIC:false tp:0.20 sm:1];
    
    //reset controller values
    [self.sliderOutlet setValue: 0.20 animated: YES];
    [self.stepperOutlet setValue: 1];
    [self.textFieldOutlet setText: @"" ];
    [self.switchOutlet setOn: NO animated: YES];
    [self.segmentedControlOutlet setSelectedSegmentIndex: 0];
    self.billTextField.text = @"";
}

- (void) updateValuesWithBill: (float) bill
                        tRate: (float) taxRate
                          TIC:(bool) tipInclTax
                           tp:(float) tipPerc
                           sm: (uint) splitNum{
    self.model.bill = bill;
    self.model.taxRate = taxRate;
    self.model.tax = bill * taxRate;
    self.model.tipIncludesTax = tipInclTax;
    if(tipInclTax){
        self.model.totalForTip = (bill + self.model.tax);
    } else{
        self.model.totalForTip = bill;
    }
    self.model.tipPercentage = tipPerc;
    self.model.splitNum = splitNum;
    self.model.tip = self.model.totalForTip * tipPerc;
    self.model.totalWithTip = self.model.bill + self.model.tip + self.model.tax;
    self.model.totalPerPerson = self.model.totalWithTip / splitNum;
    
    //update labels
    [self updateLabels];
}

- (void) updateLabels{
    self.taxLabel.text = [NSString stringWithFormat:@"$%.2lf", self.model.tax];
    self.TotalForTipLabel.text = [NSString stringWithFormat:@"$%.2lf", self.model.totalForTip];
    self.splitNumLabel.text = [NSString stringWithFormat:@"%u", self.model.splitNum];
    self.tipPercentageLabel.text = [NSString stringWithFormat:@"%.0lf%%", self.model.tipPercentage * 100];
    self.tipLabelOutlet.text = [NSString stringWithFormat:@"$%.2lf", self.model.tip];
    self.totalWithTipLabel.text = [NSString stringWithFormat:@"$%.2lf", self.model.totalWithTip];
    self.totalPerPersonLabel.text = [NSString stringWithFormat:@"$%.2lf", self.model.totalPerPerson];
}

- (void) bringUpAlertController{
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Clear all fields"
                                                                              message:@"Are you sure you want to Clear All?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"  style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) { /* code */ }];
    
    UIAlertAction *clearAction = [UIAlertAction
                                  actionWithTitle:@"Clear"  style:UIAlertActionStyleDestructive  handler:^(UIAlertAction *action) { //clear all fields
                                      [self clearAllValues]; }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:clearAction];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
