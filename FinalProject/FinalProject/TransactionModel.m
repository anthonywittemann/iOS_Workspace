//
//  TransactionModel.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "TransactionModel.h"

@interface TransactionModel ()

//TODO - properties
//agreedUponLocation TODO - location from coreLocation or GoogleMaps
//buyerCurrentLocation - TODO - location from coreLocation or GoogleMaps
//sellerCurrentLocation - TODO - location from coreLocation or GoogleMaps
//locationIsAgreedUpon - BOOL

//agreedUponDateAndTime - TODO - NSTime?
//buyerDateAndTime - TODO - NSTime?
//sellerDateAndTime - TODO - NSTime?
//timeIsAgreedUpon - BOOL

//dollarAmountIsAgreedUpon - BOOL
//agreedUponDollarAmount - TODO - figure out with Venmo API

//transactionMemo - NSString

//isSeller - BOOL


@property (nonatomic) NSString* tranactionMemo;
@property BOOL timeIsAgreedUpon;
@property BOOL locationIsAgreedUpon;
@property BOOL dollarAmountIsAgreedUpon;
@property BOOL isSeller; //TODO set to true and implement just the seller side first



@end

@implementation TransactionModel

//getters
- (NSString *) tranactionMemo{
    return _tranactionMemo;
}


//setters
- (void) setTransactionMemo: (NSString *) newTransactionMemo{
    _tranactionMemo = newTransactionMemo;
}

@end
