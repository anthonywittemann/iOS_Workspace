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

//agreedUponDateAndTime - TODO - NSString
//buyerDateAndTime - TODO - NSString
//sellerDateAndTime - TODO - NSString
//timeIsAgreedUpon - BOOL

//dollarAmountIsAgreedUpon - BOOL
//agreedUponDollarAmount - TODO - figure out with Venmo API

//transactionMemo - NSString

//isSeller - BOOL



@property BOOL timeIsAgreedUpon;
@property BOOL locationIsAgreedUpon;
@property BOOL dollarAmountIsAgreedUpon;

@property (nonatomic) BOOL isSeller; //TODO LONG generate login key so no need to ask

@property (nonatomic) NSString* buyerDateAndTime;
@property (nonatomic) NSString* sellerDateAndTime;
@property (nonatomic) NSString* agreedUponDateAndTime;

@property (nonatomic) NSString* tranactionMemo;
@property (nonatomic) double transactionAmount;




@end

@implementation TransactionModel

+(instancetype) sharedModel{
    static TransactionModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

//getters

-(NSString *) getSellerDateAndTime{
    return _sellerDateAndTime;
}
-(NSString *) getBuyerDateAndTime{
    return _buyerDateAndTime;
}
-(NSString *) getAgreedUponDateAndTime{
    return _agreedUponDateAndTime;
}

-(BOOL) isIsSeller{
    return _isSeller;
}

- (NSString *) tranactionMemo{
    return _tranactionMemo;
}
-(double) getTransactionAmount{
    return _transactionAmount;
}


//setters

-(void) setSellerDateAndTime:(NSString *)sellerDateAndTime{
    _sellerDateAndTime = sellerDateAndTime;
}
-(void) setBuyerDateAndTime:(NSString *)buyerDateAndTime{
    _buyerDateAndTime = buyerDateAndTime;
}
-(void) setAgreedUponDateAndTime:(NSString *)agreedUponDateAndTime{
    _agreedUponDateAndTime = agreedUponDateAndTime;
}

-(void) setIsSeller: (BOOL) seller{
    _isSeller = seller;
}

- (void) setTransactionMemo: (NSString *) newTransactionMemo{
    _tranactionMemo = newTransactionMemo;
}
-(void) setTransactionAmount:(double)transactionAmount{
    self.transactionAmount = transactionAmount;
}

@end
