//
//  ViewController.h
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/8/16.
//  ****************USING 3 late days**********************
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldOutlet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlOutlet;
@property (weak, nonatomic) IBOutlet UILabel *taxLabelOutlet;
@property (weak, nonatomic) IBOutlet UISwitch *switchOutlet;
@property (weak, nonatomic) IBOutlet UILabel *totalForTipOutlet;
@property (weak, nonatomic) IBOutlet UISlider *sliderOutlet;
@property (weak, nonatomic) IBOutlet UILabel *splitLabelOutlet;
@property (weak, nonatomic) IBOutlet UIStepper *stepperOutlet;
@property (weak, nonatomic) IBOutlet UILabel *tipLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *totalWithTipLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonLabelOutlet;

- (void) updateValuesWithBill: (float) bill
                        tRate: (float) taxRate
                          TIC:(bool) tipInclTax
                           tp:(float) tipPerc
                           sm: (uint) splitNum;

@end

