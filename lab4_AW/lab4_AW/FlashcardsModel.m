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
        
        
    }
    return self;
}

- (NSDictionary *) randomFlashcard
{
    NSUInteger index = random() % [self numberOfFlashcards];
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
   //TODO
}

- (NSDictionary *) prevFlashcard
{
    //TODO
}


@end
