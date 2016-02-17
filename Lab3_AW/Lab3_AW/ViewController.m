//
//  ViewController.m
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/8/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)segmentedControlTax:(id)sender {
    //TODO
}

- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)switchFlippedTipIncludesTax:(id)sender {
    //TODO
}
- (IBAction)sliderModifiedTip:(id)sender {
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
