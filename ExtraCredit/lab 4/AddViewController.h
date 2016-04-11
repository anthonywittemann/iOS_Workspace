//
//  AddViewController.h
//  lab 4
//
//  Created by Anthony Wittemann on 3/16/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddQuestionCompletionHandler)(NSString* textViewString, NSString* textFieldString);

@interface AddViewController : UIViewController

@property (nonatomic, copy) AddQuestionCompletionHandler completion;
@property (nonatomic, strong) NSString* labelString;
@property (strong, nonatomic) NSString* textFieldPlaceHolder;

@end
