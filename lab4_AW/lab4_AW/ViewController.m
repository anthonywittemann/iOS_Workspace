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

//TODO GESTURE RECOGNIZERS to display a random flashcard if the view is tapped
//and handle swiping left and right

/* TODO
 Add the shake motion to the View Controller:
 – Add the proper motion-handling method. If the motion detected is a shake
 motion, then call a method to get a random flashcard and display it. • Add animations to the View Controller:
 – Use Animations to have the flashcard label animate. Have the old flashcard fade out and then have a new question or answer fade in. You may also make other changes to the label. You may have to make some helper methods.
 • Add audio to the View Controller:
 – Set up the AVAudioPlayer in the viewDidLoad method.
 Page 2 of 3
 – Add code to the tap and swipe gesture methods to play the sound file.
 – Add code to play the sound when the device is shaked.
 */

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
