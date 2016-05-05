//
//  TransactionModel.h
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Firebase/Firebase.h>

@interface TransactionModel : NSObject

+(instancetype) sharedModel;

//getters
//-(Firebase *) getFirebaseRef;
- (NSString *) getTransactionMemo;
-(NSString *) getSellerDateAndTime;
-(NSString *) getBuyerDateAndTime;
-(NSString *) getAgreedUponDateAndTime;
-(BOOL) isIsSeller;
-(NSString *) getTransactionAmount;
-(NSString *) getLocationName;
-(NSString *) getLocationAddress;
-(NSString *) getCurrentLocationName;
-(NSString *) getCurrentLocationAddress;

//setters
- (void) setTransactionMemo: (NSString *) newTransactionMemo;
-(void) setSellerDateAndTime:(NSString *)sellerDateAndTime;
-(void) setBuyerDateAndTime:(NSString *)buyerDateAndTime;
-(void) setAgreedUponDateAndTime:(NSString *)agreedUponDateAndTime;
-(void) setIsSeller: (BOOL) seller;
-(void) setTransactionAmount:(NSString *)transactionAmount;
-(void) setLocationName:(NSString *) newLocationName;
-(void) setLocationAddress:(NSString *) newLocationAddress;
-(void) setCurrentLocationName:(NSString *) newCurrentLocationName;
-(void) setCurrentLocationAddress:(NSString *) newCurrentLocationAddress;


@end
