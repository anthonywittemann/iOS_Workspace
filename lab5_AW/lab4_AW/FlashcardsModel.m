//
//  FlashcardsModel.m
//  lab4_AW
//
//  Created by Anthony Wittemann on 3/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "FlashcardsModel.h"

@interface FlashcardsModel ()

//private properties
@property (strong, nonatomic) NSMutableArray *flashcards;
@property (readwrite, assign) NSUInteger currentIndex;

@end



@implementation FlashcardsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //initialize properties
        NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Who is a god?", kQuestionKey, @"Not Kanye ;)", kAnswerKey, nil];
        
        NSDictionary *flashcard2 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who tells Kanye what to do?", kQuestionKey, @"The voices inside his head, placed there by Anthony", kAnswerKey, nil];
        
        NSDictionary *flashcard3 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who ain't even cool no more?", kQuestionKey, @"Taylor Swift, yeah that coke head country girl", kAnswerKey, nil];
        
        NSDictionary *flashcard4 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who doesn't care about black people?", kQuestionKey, @"George Bush", kAnswerKey, nil];
        
        NSDictionary *flashcard5 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who really did 9-11?", kQuestionKey, @"George Bush", kAnswerKey, nil];
        
        
        _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
        _currentIndex = 0;
        
    }
    return self;
}

+ (instancetype) sharedModel {
    static FlashcardsModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}


- (NSDictionary *) randomFlashcard
{
    NSUInteger index = arc4random_uniform( (int)[self numberOfFlashcards] );
    self.currentIndex = index;
    return self.flashcards[index];
}

- (NSUInteger) numberOfFlashcards
{
    return [self.flashcards count];
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index
{
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index
{
    //check index
    if (index > 0 && index < [self numberOfFlashcards]) {
        [self.flashcards removeObjectAtIndex: index];
    }
}

- (void) insertFlashcard: (NSDictionary *) flashcard
{
    [self.flashcards addObject: flashcard];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer
{
    NSDictionary *flashDict = [NSDictionary dictionaryWithObjectsAndKeys: question, kQuestionKey, answer, kAnswerKey, nil];
    [self.flashcards addObject: flashDict];
}

- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index
{
    //check index
    if (index > 0 && index <= [self numberOfFlashcards]) {
        [self.flashcards insertObject:flashcard atIndex: index];
    }
}

- (void) insertFlashcard: (NSString *) flashcard
                  answer: (NSString *) author atIndex: (NSUInteger) index
{
    NSDictionary *flashDict = [NSDictionary dictionaryWithObjectsAndKeys: flashcard, kQuestionKey, author, kAnswerKey, nil];
    
    //check index
    if (index > 0 && index <= [self numberOfFlashcards]) {
        [self.flashcards insertObject:flashDict atIndex: index];
    }
    
}

- (NSDictionary *) nextFlashcard
{
    if(self.currentIndex == [self numberOfFlashcards] - 1){
        self.currentIndex = 0;
    } else{
        self.currentIndex += 1;
    }
    NSDictionary *nextFlash = self.flashcards[self.currentIndex];
    return nextFlash;
}

- (NSDictionary *) prevFlashcard
{
    if(self.currentIndex == 0){
        self.currentIndex = [self numberOfFlashcards] - 1;
    } else{
        self.currentIndex -= 1;
    }
    NSDictionary *prevFlash = self.flashcards[self.currentIndex];
    return prevFlash;
}


@end
