//
//  ViewController.m
//  lab 4
//
//  Created by Anthony Wittemann on 3/16/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *QuestionTextView;
@property (weak, nonatomic) IBOutlet UITextField *AnswerTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.QuestionTextView.text = self.labelString;
    self.AnswerTextField.text = self.textFieldPlaceHolder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}


- (void) touchesBegan: (NSSet *) touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if([self.QuestionTextView isFirstResponder] && [touch view] != self.QuestionTextView){
        [self.QuestionTextView resignFirstResponder];
    }
    else if([self.AnswerTextField isFirstResponder] && [touch view] != self.AnswerTextField){
        [self.AnswerTextField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.QuestionTextView becomeFirstResponder];
}


- (IBAction)cancelAddTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if(self.completion){
        self.completion(nil, nil);
    }
    
    self.QuestionTextView = nil;
    self.AnswerTextField = nil;
}

- (IBAction)savedTouched:(id)sender {
    if(self.completion){
        self.completion(self.QuestionTextView.text, self.AnswerTextField.text);

    }
    
    self.QuestionTextView = nil;
    self.AnswerTextField = nil;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
//    if(self.completion){
//        self.completion(self.QuestionTextView.text, self.AnswerTextField.text);
//    }
//    
//    self.QuestionTextView = nil;
//    self.AnswerTextField = nil;
//    
    return YES;
}

- (void) enableSaveButtonForQuestion: (NSString *) questionText textField: (NSString *) answerText {
    if(questionText.length > 0 && answerText.length > 0){
        [self.saveButton setEnabled:YES];
    }
    else{
        [self.saveButton setEnabled:NO];

    }
    
}



- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)textFieldString {
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString: textFieldString];
    
    [self enableSaveButtonForQuestion:self.AnswerTextField.text textField:changedString];
    
    return YES;
}

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)textViewString{
    NSString* changedString = [textView.text stringByReplacingCharactersInRange:range withString:textViewString];
    
    [self enableSaveButtonForQuestion:changedString textField:self.AnswerTextField.text];
    return YES;
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
