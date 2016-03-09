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

- (void) logArray {
    NSDictionary *question;
    
    for (NSUInteger i=0; i < [self.model numberOfFlashcards]; i++) {
        question = [self.model flashcardAtIndex: i];
        
        //        NSLog (@"Quote: %@ Author: %@", [quote objectForKey: kQuoteKey],
        //               [quote objectForKey: kAuthorKey]);
        
        NSLog(@"Question: %@ Answer: %@", question[kQuestionKey],
              question[kAnswerKey] );
    }
    NSLog(@" ");
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


- (void) testInsert {
    // local variables
    NSUInteger num;
    NSUInteger index;
    NSDictionary *flashcard, *addedFlashcard;
    
    num = [self.model numberOfFlashcards];
    index = 0;
    
    // Insert quote
    flashcard = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Who's doing the testing?", kQuestionKey,
             @"Anthony Wittemann", kAnswerKey, nil];
    [self.model insertFlashcard: flashcard atIndex: index];
    num = num + 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    addedFlashcard = [self.model flashcardAtIndex:index];
    XCTAssertEqualObjects(flashcard, addedFlashcard);
}

- (void) testRemove {
    // local variables
    NSUInteger num;
    NSUInteger index;
    
    num = [self.model numberOfFlashcards];
    index = 0;
    
    // Remove quote
    [self.model removeFlashcardAtIndex: index];
    num = num - 1;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
