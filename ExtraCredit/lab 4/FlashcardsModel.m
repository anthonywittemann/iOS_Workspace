//
//  FlashcardsModel.m
//  lab 4
//
//  Created by Anthony Wittemann on 3/16/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "FlashcardsModel.h"
static NSString *const kFlashcardsPList = @"Flashcards.list";

@interface FlashcardsModel()

@property (strong, nonatomic) NSMutableArray *flashcards;
@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSString *filePath;

@end

@implementation FlashcardsModel

+(instancetype) sharedModel{
    static FlashcardsModel *_sharedModel = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _filePath = [documentsDirectory stringByAppendingPathComponent:kFlashcardsPList];
        
        _flashcards = [NSMutableArray arrayWithContentsOfFile:_filePath];
        
        if(!self.flashcards){

            //initialize properties
            NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Who is a god?", kQuestionKey, @"Not Kanye ;)", kAnswerKey, nil];
            
            NSDictionary *flashcard2 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who tells Kanye what to do?", kQuestionKey, @"The voices inside his head, placed there by Anthony", kAnswerKey, nil];
            
            NSDictionary *flashcard3 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who ain't even cool no more?", kQuestionKey, @"Taylor Swift, yeah that coke head country girl", kAnswerKey, nil];
            
            NSDictionary *flashcard4 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who doesn't care about black people?", kQuestionKey, @"George Bush", kAnswerKey, nil];
            
            NSDictionary *flashcard5 = [NSDictionary dictionaryWithObjectsAndKeys: @"Who really did 9-11?", kQuestionKey, @"George Bush", kAnswerKey, nil];
        
            _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
            
            _currentIndex = 0;
        }
    }
    return self;
}

-(NSUInteger) numberOfFlashcards{
//    NSLog(@"the num of cards direct is: %li", (long)[self.flashcards count]);
    return [self.flashcards count];
}

- (NSDictionary *) currentFlashcard{
    NSDictionary *flashcard = [self.flashcards objectAtIndex: self.currentIndex];
    return flashcard;
}

- (NSDictionary *) randomFlashcard {
    
    NSUInteger index = arc4random_uniform((int)[self numberOfFlashcards] );
    self.currentIndex = index;
    return self.flashcards[index];
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index {
    if(index >= self.flashcards.count){
        index = 0;
    }
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index {
    // check index
    NSUInteger zero = 0;

    if(index >= self.flashcards.count || index < zero){
        return;
    }
    
    [self.flashcards removeObjectAtIndex: index];
    [self save];
}


- (void) insertFlashcard:(NSDictionary *)flashcard {

    [self.flashcards addObject: flashcard];
    [self save];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               question, kQuestionKey, answer, kAnswerKey, nil];
    [self insertFlashcard: flashcardDict ];
}
    
- (void) insertFlashcard: (NSDictionary *) flashcard
                atIndex: (NSUInteger) index{
    //check index
    if (index > 0 && index <= [self numberOfFlashcards]) {
        [self.flashcards insertObject:flashcard atIndex: index];
    }
}

- (void) insertFlashcard: (NSString *) question answer: (NSString *) answer atIndex: (NSUInteger) index{
    
    NSDictionary *flashDict = [NSDictionary dictionaryWithObjectsAndKeys: question, kQuestionKey, answer, kAnswerKey, nil];
    
    //check index
    if (index > 0 && index <= [self numberOfFlashcards]) {
        [self.flashcards insertObject:flashDict atIndex: index];
    }
    
}

- (NSDictionary *) nextFlashcard{
    if(self.currentIndex == [self numberOfFlashcards] - 1){
        self.currentIndex = 0;
    } else{
        self.currentIndex += 1;
    }
    NSDictionary *nextFlash = self.flashcards[self.currentIndex];
    return nextFlash;
}

- (NSDictionary *) prevFlashcard{
    if(self.currentIndex == 0){
        self.currentIndex = [self numberOfFlashcards] - 1;
    } else{
        self.currentIndex -= 1;
    }
    NSDictionary *prevFlash = self.flashcards[self.currentIndex];
    return prevFlash;
}

- (void) save {
    [self.flashcards writeToFile:self.filePath atomically:YES];
}

@end
