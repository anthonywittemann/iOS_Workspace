//
//  TransactionModel.h
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionModel : NSObject

+(instancetype) sharedModel;

//getters
- (NSString *) tranactionMemo;
-(NSString *) getSellerDateAndTime;
-(NSString *) getBuyerDateAndTime;
-(NSString *) getAgreedUponDateAndTime;
-(BOOL) isIsSeller;

//setters
- (void) setTransactionMemo: (NSString *) newTransactionMemo;
-(void) setSellerDateAndTime:(NSString *)sellerDateAndTime;
-(void) setBuyerDateAndTime:(NSString *)buyerDateAndTime;
-(void) setAgreedUponDateAndTime:(NSString *)agreedUponDateAndTime;
-(void) setIsSeller: (BOOL) seller;


@end
