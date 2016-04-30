//
//  FlashcardsModel.h
//  lab 4
//
//  Created by Anthony Wittemann on 3/16/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kQuestionKey = @"question";
static NSString * const kAnswerKey = @"answer";

@interface FlashcardsModel : NSObject

// public methods
+ (instancetype) sharedModel;
- (NSDictionary *) randomFlashcard;
- (NSDictionary *) currentFlashcard;
- (NSUInteger) getCurrentIndex;
- (NSUInteger) numberOfFlashcards;
- (NSUInteger) numberOfFavorites;
- (NSDictionary *) flashcardAtIndex: (NSUInteger) index;
- (NSDictionary *) favoriteAtIndex: (NSUInteger) index;
- (void) removeFlashcardAtIndex: (NSUInteger) index;
- (void) removeFavoriteAtIndex: (NSUInteger) index;

- (void) insertFlashcard: (NSDictionary *) flashcard;
- (void) insertFavorite:(NSDictionary *)favoriteFlashcard;

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer;

- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index;

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer
                 atIndex: (NSUInteger) index;
- (NSDictionary *) nextFlashcard;
- (NSDictionary *) prevFlashcard;


@end
