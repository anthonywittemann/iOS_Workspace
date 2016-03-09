//
//  QuotesModel.h
//  Quotes
//
//  Created by Trina Gregory on 9/28/15.
//  Copyright (c) 2015 Trina Gregory. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kQuoteKey = @"quote";
static NSString * const kAuthorKey = @"author";

@interface QuotesModel : NSObject

// public methods
- (NSDictionary *) randomQuote;
- (NSUInteger) numberOfQuotes;
- (NSDictionary *) quoteAtIndex: (NSUInteger) index;
- (void) removeQuoteAtIndex: (NSUInteger) index;
- (void) insertQuote: (NSString *) quote
              author: (NSString *) author;
- (void) insertQuote: (NSDictionary *) quote;
- (void) insertQuote: (NSString *) quote
              author: (NSString *) author
             atIndex: (NSUInteger) index;
- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index;

@end
