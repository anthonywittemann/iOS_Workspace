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
    //TODO update textFields
}


/************* ADDED IBActions ****************/

- (IBAction)segmentedControlTax:(id)sender {
    //TODO
}

- (IBAction)onSegmentValueChanged:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0: //7.5
            
            break;
        case 1: //8.0
            
            break;
        case 2: //8.5
            
            break;
        case 3: //9.0
            
            break;
        case 4: //9.5
            
            break;
        default:
            break;
    }
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
    //clear all fields
    [self clearAllValues];
    
    //Helper method Actionsheet, UIAlertController
    [self bringUpAlertController];
    
    //helper method to clear all (update values)
    //TODO can't figure out how to call a method in DataModel class
    
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


/************* Helper Methods ****************/



- (void) clearAllValues{
    
    //reset controller values
    [self.sliderOutlet setValue: 20 animated: YES];
    [self.stepperOutlet setValue: 1];
    [self.textFieldOutlet setText: @"" ];
    [self.switchOutlet setOn: YES animated: YES];
    [self.segmentedControlOutlet setSelectedSegmentIndex: 0];
}

- (void) bringUpAlertController{
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Clear all fields"
                                                                              message:@"Are you sure you want to Clear All?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"  style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) { /* code */ }];
    
    UIAlertAction *clearAction = [UIAlertAction
                                  actionWithTitle:@"Clear"  style:UIAlertActionStyleDestructive  handler:^(UIAlertAction *action) { /* code */ }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:clearAction];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
