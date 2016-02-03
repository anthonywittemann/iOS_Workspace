//
//  ViewController.m
//  Lab2_AW
//
//  Created by Anthony Wittemann on 1/25/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)dismissKeyboard:(id)sender{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)footballButtonChosen:(id)sender{
    NSUInteger nameLength = self.nameTextField.text.length;
    
    if(nameLength > 0){
        self.messageLabel.text = [NSString stringWithFormat: @"%@, good choice", self.nameTextField.text];
    } else{
        self.messageLabel.text = @"Whoever you are, good choice";
    }
}

- (IBAction)soccerButtonChosen:(id)sender{
    NSUInteger nameLength = self.nameTextField.text.length;
    
    if(nameLength > 0){
        self.messageLabel.text = [NSString stringWithFormat: @"%@, you made the wrong choice", self.nameTextField.text];
    } else{
        self.messageLabel.text = @"Whoever you are, you made the wrong choice";
    }
}

- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
}

- (void) touchesBegan: (NSSet *)touches
            withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.nameTextField isFirstResponder] &&
        [touch view] != self.nameTextField) {
        [self.nameTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction) backgroundTouched:(id)sender {
    [self.nameTextField resignFirstResponder];
}


@end
