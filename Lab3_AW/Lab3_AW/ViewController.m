//
//  ViewController.m
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/8/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
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
}


/************* ADDED IBActions ****************/

- (IBAction)segmentedControlTax:(id)sender {
    //TODO
}

- (IBAction)switchFlippedTipIncludesTax:(id)sender {
    //TODO
}

- (IBAction)sliderModifiedTip:(id)sender {
    //TODO
}

- (IBAction)stepperIncrementedSplitBill:(id)sender {
    //TODO
}

- (IBAction)clearAllPressed:(id)sender {
    //TODO clear all fields with Actionsheet, UIAlertController
}


- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
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
}



@end
