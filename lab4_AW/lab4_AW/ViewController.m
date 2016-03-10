//
//  ViewController.m
//  lab4_AW
//
//  Created by Anthony Wittemann on 3/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

//private properties
@property (strong, nonatomic) FlashcardsModel *model;
@property (readonly) SystemSoundID fadeInSoundFileID;
@property (readonly) SystemSoundID taDaSoundFileID;
@property (readonly) SystemSoundID toneSoundFileID;


//IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end



@implementation ViewController

/* TODO
 
 • Add audio to the View Controller:
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
    
    //set up audio file handling
    NSString *fadeInSoundfilePath = [[NSBundle mainBundle] pathForResource:@"fadein" ofType:@"wav"];
    NSURL *fadeInSoundURL = [NSURL fileURLWithPath: fadeInSoundfilePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) fadeInSoundURL, &_fadeInSoundFileID);
    
    NSString *taDaSoundfilePath = [[NSBundle mainBundle] pathForResource:@"TaDa" ofType:@"wav"];
    NSURL *taDaSoundURL = [NSURL fileURLWithPath: taDaSoundfilePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) taDaSoundURL, &_taDaSoundFileID);
    
    NSString *toneSoundfilePath = [[NSBundle mainBundle] pathForResource:@"tone" ofType:@"mp3"];
    NSURL *toneSoundURL = [NSURL fileURLWithPath: toneSoundfilePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) toneSoundURL, &_toneSoundFileID);
    
    
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
    //play sound
    AudioServicesPlaySystemSound(self.fadeInSoundFileID);
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    //change to random card on double tap
    NSDictionary * newFlashcard = [self.model randomFlashcard];
    [self updateFlashcards: newFlashcard];
    //play sound
    AudioServicesPlaySystemSound(self.fadeInSoundFileID);
}

- (void) swipeLeftGestureRecognized: (UITapGestureRecognizer *) recognizer{
    //change to previous card
    NSDictionary * newFlashcard = [self.model prevFlashcard];
    [self updateFlashcards: newFlashcard];
    //play sound
    AudioServicesPlaySystemSound(self.taDaSoundFileID);
}

- (void) swipeRightGestureRecognized: (UITapGestureRecognizer *) recognizer{
    //change to next card
    NSDictionary * newFlashcard = [self.model nextFlashcard];
    [self updateFlashcards: newFlashcard];
    //play sound
    AudioServicesPlaySystemSound(self.taDaSoundFileID);
}

//helper method to update the text in labels
- (void) updateFlashcards: (NSDictionary *) newFlashcard{
    //fade out, fade in with new card
    [self fadeOutAnimateFlashcard: newFlashcard];
    
}

- (void) fadeOutAnimateFlashcard: (NSDictionary *) flashcard{
    [UIView animateWithDuration: 1.0 animations:^{
        //Fade out old text of label
        self.answerLabel.alpha = 0;
        self.questionLabel.alpha = 0;
        }
        completion:^(BOOL finished){
            //Upon completion call fadeOutAnimateFlashcard
            [self fadeInAnimateFlashcard: flashcard];
        }
     ];
}

- (void) fadeInAnimateFlashcard: (NSDictionary *) newFlashcard{
    [UIView animateWithDuration: 1.0 animations:^{
        NSString * answer = newFlashcard[kAnswerKey];
        NSString * question = newFlashcard[kQuestionKey];
        
        self.questionLabel.text = question;
        self.answerLabel.text = answer;
        
        //Fade out old text of label
        self.answerLabel.alpha = 1;
        self.questionLabel.alpha = 1;
    }
     ];
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
        //play sound
        AudioServicesPlaySystemSound(self.toneSoundFileID);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
