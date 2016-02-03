//
//  ViewController.h
//  Lab2_AW
//
//  Created by Anthony Wittemann on 1/25/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)footballButtonChosen:(id)sender{
    NSUInteger nameLength = self.nameTextField.text.length;
    
    if(nameLength > 0){
        self.messageLabel.text = @"%@, good choice", self.nameTextField.text;
    } else{
        self.messageLabel.text = @"Whoever you are, good choice";
    }
}

- (IBAction)soccerButtonChosen:(id)sender{
    NSUInteger nameLength = self.nameTextField.text.length;
    
    if(nameLength > 0){
        self.messageLabel.text = @"%@, you made the wrong choice", self.nameTextField.text;
    } else{
        self.messageLabel.text = @"Whoever you are, you made the wrong choice";
    }
}

@property (weak, nonatomic) IBOutlet UILabel *messageLabelOutlet{

}

@property (weak, nonatomic) IBOutlet UITextField *textFieldOutlet{

}

@end

