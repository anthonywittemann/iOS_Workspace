//
//  ViewController.m
//  lab 4
//
//  Created by Anthony Wittemann on 3/14/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FlashcardsModel.h"

@interface ViewController ()

//private properties
@property (strong, nonatomic) FlashcardsModel *model;
@property (readonly) SystemSoundID fadeInSoundFileID;
@property (readonly) SystemSoundID taDaSoundFileID;
@property (readonly) SystemSoundID toneSoundFileID;


//IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    #if TARGET_IPHONE_SIMULATOR
        NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    #endif
    
    
    
    
    self.model = [FlashcardsModel sharedModel];
    if([self.model numberOfFlashcards] == 0){
        self.questionLabel.text = @"Please create some flashcards!";
    }
    else{
        NSDictionary *flashcard = [self.model randomFlashcard];
        self.questionLabel.text = flashcard[kQuestionKey];
    }

    
    NSString *fadeInFilePath = [[NSBundle mainBundle]
                            pathForResource:@"fadein" ofType:@"wav"];
    
    NSString *taDaFilePath = [[NSBundle mainBundle]
                                pathForResource:@"TaDa" ofType:@"wav"];
    
    NSURL *fadeInURL = [NSURL fileURLWithPath:fadeInFilePath];
    NSURL *taDaURL = [NSURL fileURLWithPath:taDaFilePath];


    AudioServicesCreateSystemSoundID( (__bridge CFURLRef)fadeInURL, &_fadeInSoundFileID);
    AudioServicesCreateSystemSoundID( (__bridge CFURLRef)taDaURL, &_taDaSoundFileID);

    
    // Add tap gestures
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
   
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

}

// Animations
- (void) fadeInQuestion: (NSString *) question {
    self.questionLabel.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
        self.questionLabel.text = question;

    }];
}

- (void) displayFlashcard: (NSString *) question {
    [UIView animateWithDuration:1.0
                     animations:^{
        self.questionLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self fadeInQuestion: question];
    }];
}

- (void) animateFlashcard:(NSString *) question {
    self.questionLabel.text = question;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
    }];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL) animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake){
        
        // Play sound
        AudioServicesPlaySystemSound(self.fadeInSoundFileID);
        
//        [self fadeInQuestion:flashcard[kQuestionKey]];
        if([self.model numberOfFlashcards] > 0){
            NSDictionary *flashcard = [self.model randomFlashcard];
            [self fadeInQuestion:flashcard[kQuestionKey]];
        }
        else {
            [self fadeInQuestion:@"There are no more flashcards."];
        }
//        self.questionLabel.text = flashcard[kQuestionKey];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer{
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInSoundFileID);
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model randomFlashcard];
        [self fadeInQuestion:flashcard[kQuestionKey]];
        
        [self checkIfInFavorites:[self.model currentFlashcard]];
    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }
}

- (void) swipeRightRecognized: (UISwipeGestureRecognizer *) recognizer{
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInSoundFileID);
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model prevFlashcard];
        [self fadeInQuestion:flashcard[kQuestionKey]];
        
        [self checkIfInFavorites:[self.model currentFlashcard]];
    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }

}

- (void) swipeLeftRecognized: (UISwipeGestureRecognizer *) recognizer{
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInSoundFileID);
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model nextFlashcard];
        
        [self fadeInQuestion:flashcard[kQuestionKey]];
        
        [self checkIfInFavorites:[self.model currentFlashcard]];
    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
//    self.questionLabel.text = flashcard[kAnswerKey];
    
    self.questionLabel.alpha = 0;
    AudioServicesPlaySystemSound(self.taDaSoundFileID);

    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
        if([self.model numberOfFlashcards] > 0){
            NSDictionary *flashcard = [self.model currentFlashcard];
            [self animateFlashcard:flashcard[kAnswerKey]];
        }
        else {
            [self animateFlashcard:@"Please add more flashcards."];
        }
        
    }];
}

- (IBAction)starButtonPressed:(id)sender {
    [self checkIfInFavorites:[self.model currentFlashcard]];
}

- (void) checkIfInFavorites: (NSDictionary *) currentFlashcard{
    BOOL isInFavorites = false;
    //TODO loop and check if in favorites - NOT BY COMPARING OBJECTS - CREATE FAVORITES ARRAY TO COMPARE TO CURRENT FLASHCARDINDEX
//    for(int i = 0; i < [self.model numberOfFlashcards]; i++){
//        if(currentFlashcard == [self.model flashcardAtIndex:i]){
//            isInFavorites = true;
//            break;
//        }
//    }
    
    
    if(isInFavorites){
        //flashcard is removed from favorites
        [self.model removeFavoriteAtIndex:[self.model getCurrentIndex]];
        
        //change the button to show it was removed from favorites
        [self.starButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    } else{
        //flashcard is added as a favorite.
        [self.model insertFavorite:currentFlashcard];
        
        //change the button to show it was added to favorites
        [self.starButton setImage:[UIImage imageNamed:@"starFilled.png"] forState:UIControlStateNormal];
    }
    
}

@end
