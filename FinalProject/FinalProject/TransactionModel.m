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

@property (nonatomic) NSString* transactionMemo; //TODO LONG handle cases where there is both a buyer and sell
@property (nonatomic) NSString* transactionAmount;

@property (nonatomic) NSString* locationName; //TODO LONG handle cases where there is both a buyer and sell
@property (nonatomic) NSString* locationAddress;
@property (nonatomic) NSString* currentLocationName; //TODO LONG handle cases where there is both a buyer and sell
@property (nonatomic) NSString* currentLocationAddress;




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

- (NSString *) getTransactionMemo{
    return _transactionMemo;
}
-(NSString *) getTransactionAmount{
    return _transactionAmount;
}

-(NSString *) getLocationName{
    return _locationName;
}
-(NSString *) getLocationAddress{
    return _locationAddress;
}

-(NSString *) getCurrentLocationName{
    return _currentLocationName;
}
-(NSString *) getCurrentLocationAddress{
    return _currentLocationAddress;
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
    _transactionMemo = newTransactionMemo;
}
-(void) setTransactionAmount:(NSString *) transactionAmnt{
    self.transactionAmount = transactionAmnt;
}

-(void) setLocationName:(NSString *) newLocationName{
    _locationName = newLocationName;
}
-(void) setLocationAddress:(NSString *) newLocationAddress{
    _locationAddress = newLocationAddress;
}
-(void) setCurrentLocationName:(NSString *) newCurrentLocationName{
    _locationName = newCurrentLocationName;
}
-(void) setCurrentLocationAddress:(NSString *) newCurrentLocationAddress{
    _locationAddress = newCurrentLocationAddress;
}

@end
