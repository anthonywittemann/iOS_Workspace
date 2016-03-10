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

/* TODO
 
 • Add animations to the View Controller:
 – Use Animations to have the flashcard label animate. Have the old flashcard fade out and then have a new question or answer fade in. You may also make other changes to the label. You may have to make some helper methods.
 
 • Add audio to the View Controller:
 – Set up the AVAudioPlayer in the viewDidLoad method.
 – Add code to the tap and swipe gesture methods to play the sound file.
 – Add code to play the sound when the device is shaked.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Add Gesture Recognizers
    //single tap
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer: singleTap];
    
    //double tap
    UITapGestureRecognizer *doubleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer: doubleTap];
    
    [singleTap requireGestureRecognizerToFail: doubleTap];
    
    //swipe left
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer: swipeLeft];
    
    //swipe right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: swipeRight];
    
    //initialize data
    self.model = [[FlashcardsModel alloc] init];
    NSDictionary *question = [self.model randomFlashcard];
    self.questionLabel.text = question[kQuestionKey];
    self.answerLabel.text = question[kAnswerKey];
}

/*
 ------------------------------ Tapping and Swiping -------------------------------------
 */

- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer{
    //change to random card on single tap
    NSDictionary * newFlashcard = [self.model randomFlashcard];
    [self updateFlashcards: newFlashcard];
    
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    //change to random card on double tap
    NSDictionary * newFlashcard = [self.model randomFlashcard];
    [self updateFlashcards: newFlashcard];
}

- (void) swipeLeftGestureRecognized: (UITapGestureRecognizer *) recognizer{
    //change to previous card
    NSDictionary * newFlashcard = [self.model prevFlashcard];
    [self updateFlashcards: newFlashcard];
}

- (void) swipeRightGestureRecognized: (UITapGestureRecognizer *) recognizer{
    //change to next card
    NSDictionary * newFlashcard = [self.model nextFlashcard];
    [self updateFlashcards: newFlashcard];
}

//helper method to update the text in labels
- (void) updateFlashcards: (NSDictionary *) newFlashcard{
    NSString * answer = newFlashcard[kAnswerKey];
    NSString * question = newFlashcard[kQuestionKey];
    
    self.questionLabel.text = question;
    self.answerLabel.text = answer;
    
    //TODO add animations here******************************************************
}

/*
 ------------------------------ Shake Motion Detection -------------------------------------
 */
- (BOOL) canBecomeFirstResponder{
    return YES;
}

- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    [self becomeFirstResponder];
}

- (void) motionEnded: (UIEventSubtype) motion withEvent: (UIEvent *) event{
    if(motion == UIEventSubtypeMotionShake){
        //random card
        NSDictionary * newFlashcard = [self.model randomFlashcard];
        [self updateFlashcards: newFlashcard];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
