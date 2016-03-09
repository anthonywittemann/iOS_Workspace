//
//  ViewController.m
//  lab4_AW
//
//  Created by Anthony Wittemann on 3/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"

@interface ViewController ()

//private properties
@property (strong, nonatomic) FlashcardsModel *model;


//IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.model = [[FlashcardsModel alloc] init];
    NSDictionary *question = [self.model randomFlashcard];
    self.questionLabel.text = question[kQuestionKey];
    self.answerLabel.text = question[kAnswerKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
