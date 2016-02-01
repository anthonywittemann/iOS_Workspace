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

- (IBAction)soccerButtonTouched:(id)sender {
}
- (IBAction)footballButtonTouched:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
