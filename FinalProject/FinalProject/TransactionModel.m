//
//  TransactionModel.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "TransactionModel.h"
#import <Firebase/Firebase.h>

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


@property (nonatomic) Firebase *transactionElementsRef;




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

- (instancetype) init{ //TODO!!!!!!!!
    self = [super init];
    if (self) {
        // Create a reference to a Firebase database URL
        Firebase* myRootRef = [[Firebase alloc] initWithUrl:@"https://radiant-torch-5845.firebaseIO.com"];
        _transactionElementsRef = [myRootRef childByAppendingPath: @"transactionElements"];
        
        // Read data and react to changes
        [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        }];
        
        //TODO - if database is empty, write default data to it - replace with my NSDictionaries with transaction data
        /*
         NSDictionary *alanisawesome = @{
            @"full_name" : @"Alan Turing",
            @"date_of_birth": @"June 23, 1912"
         };
         NSDictionary *gracehop = @{
            @"full_name" : @"Grace Hopper",
            @"date_of_birth": @"December 9, 1906"
         };
         
         NSDictionary *transactionElements = @{
            @"alanisawesome": alanisawesome,
            @"gracehop": gracehop
         };
         [transactionElementsRef setValue: transactionElements];
         */
        
        //    // Write data to Firebase - TODO WHERE TO PUT THIS??
        //    [myRootRef setValue:@"Do you have data? You'll love Firebase."];
        
        
    }
    return self;
}

//getters
-(Firebase *) getFirebaseRef{
    return _transactionElementsRef;
}

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


//setters - also update Firebase

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
