//
//  FlashcardsTest.m
//  lab4_AW
//
//  Created by Anthony Wittemann on 3/9/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlashcardsModel.h"

@interface FlashcardsTest : XCTestCase

@property (strong, nonatomic) FlashcardsModel *model;

@end

@implementation FlashcardsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.model = [[FlashcardsModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // local variables
    NSUInteger num;
    
    // test init
    num = 5; // I know that the init creates 5 questions
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    
}


- (void) testInsertFlashcardAtIndex {
    // local variables
    NSUInteger num;
    NSUInteger index;
    NSDictionary *flashcard, *addedFlashcard;
    
    num = [self.model numberOfFlashcards];
    index = num;
    
    // Insert flashcard
    flashcard = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Who's doing the testing?", kQuestionKey,
             @"Anthony Wittemann", kAnswerKey, nil];
    [self.model insertFlashcard: flashcard atIndex: index];
    num = num + 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    addedFlashcard = [self.model flashcardAtIndex:index];
    XCTAssertEqualObjects(flashcard, addedFlashcard);
}

- (void) testRemoveFlashcardAtIndex {
    // local variables
    NSUInteger num;
    NSUInteger index;
    
    num = [self.model numberOfFlashcards];
    index = num - 1;
    
    // Remove flashcard
    [self.model removeFlashcardAtIndex: index];
    num = num - 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
}


- (void)testInsertFlashcard {
    // local variables
    NSUInteger num;
    NSUInteger index;
    NSDictionary *flashcard, *addedFlashcard;
    
    num = [self.model numberOfFlashcards];
    index = num;
    
    // Insert flashcard
    flashcard = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"Who's doing the testing?", kQuestionKey,
                 @"Anthony Wittemann", kAnswerKey, nil];
    [self.model insertFlashcard: flashcard];
    num = num + 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    addedFlashcard = [self.model flashcardAtIndex:index];
    XCTAssertEqualObjects(flashcard, addedFlashcard);
}

- (void)testInsertFlashcardAnswer {
    //TODO How should we test this? - test for object equality...
    
    // local variables
    NSUInteger num;
    NSUInteger index;
    NSString * question;
    NSString * ans;
    NSDictionary *flashcard, *addedFlashcardAnswer;
    
    num = [self.model numberOfFlashcards];
    index = num;
    
    // Insert flashcard
    
    question = @"Who's doing the testing?";
    ans = @"Anthony Wittemann";
    flashcard = [NSDictionary dictionaryWithObjectsAndKeys:
                 question, kQuestionKey,
                 ans, kAnswerKey, nil];
    [self.model insertFlashcard: question answer:ans];
    num = num + 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    addedFlashcardAnswer = [self.model flashcardAtIndex:index];
    XCTAssertEqualObjects(flashcard, addedFlashcardAnswer);
}

- (void)testInsertFlashcardAnswerAtIndex {
    // local variables
    NSUInteger num;
    NSUInteger index;
    NSString * question;
    NSString * ans;
    NSDictionary *flashcard, *addedFlashcardAnswer;
    
    num = [self.model numberOfFlashcards];
    index = num - 1;
    
    // Insert flashcard
    
    question = @"Who's doing the testing?";
    ans = @"Anthony Wittemann";
    flashcard = [NSDictionary dictionaryWithObjectsAndKeys:
                 question, kQuestionKey,
                 ans, kAnswerKey, nil];
    [self.model insertFlashcard: question answer:ans atIndex: index];
    num = num + 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    addedFlashcardAnswer = [self.model flashcardAtIndex:index];
    XCTAssertEqualObjects(flashcard, addedFlashcardAnswer);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
