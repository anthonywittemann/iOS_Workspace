//
//  TransactionModel.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "TransactionModel.h"
//#import <Firebase/Firebase.h>
static NSString *const kTransactionElementsPList = @"TransactionElements.list";

@interface TransactionModel ()

//properties for model

//TODO LONG
//@property BOOL timeIsAgreedUpon;
//@property BOOL locationIsAgreedUpon;
//@property BOOL dollarAmountIsAgreedUpon;

@property (nonatomic) BOOL isSeller; //TODO LONG generate login key so no need to ask

@property (strong, nonatomic) NSString* buyerDateAndTime;
@property (strong, nonatomic) NSString* sellerDateAndTime;
@property (strong, nonatomic) NSString* agreedUponDateAndTime;

@property (strong, nonatomic) NSString* transactionMemo; //TODO LONG handle cases where there is both a buyer and sell
@property (strong, nonatomic) NSString* transactionAmount;

@property (strong, nonatomic) NSString* locationName; //TODO LONG handle cases where there is both a buyer and sell
@property (strong, nonatomic) NSString* locationAddress;
@property (strong, nonatomic) NSString* currentLocationName; //TODO LONG handle cases where there is both a buyer and sell
@property (strong, nonatomic) NSString* currentLocationAddress;


//@property (nonatomic) Firebase *transactionElementsRef;

//properties to store data locally
@property (strong, nonatomic) NSMutableArray *transactionElements;
@property (strong, nonatomic) NSString *filePath;


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
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _filePath = [documentsDirectory stringByAppendingPathComponent:kTransactionElementsPList];
        
        _transactionElements = [NSMutableArray arrayWithContentsOfFile:_filePath];
        
        if(self.transactionElements == nil){
            
            //initialize properties
            //TODO - long
//            _timeIsAgreedUpon = FALSE;
//            _locationIsAgreedUpon = FALSE;
//            _dollarAmountIsAgreedUpon = FALSE;
            
            _isSeller = TRUE;
            
            _buyerDateAndTime = @"No time selected";
            _sellerDateAndTime = @"No time selected";
            _agreedUponDateAndTime = @"No time agreed upon";
            
            _transactionMemo = @"No Memo";
            _transactionAmount = @"No Amount Yet";
            
            _locationName = @"No Location Selected";
            _locationAddress = @"No Location Selected";
            _currentLocationName = @"IDK where you are";
            _currentLocationAddress = @"IDK where you are";
            
            
            //bools stored as NSNumber because local storage only stores objects, not primatives
            _transactionElements = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithBool:_isSeller], _buyerDateAndTime, _sellerDateAndTime, _agreedUponDateAndTime, _transactionMemo, _transactionAmount, _locationName, _locationAddress, _currentLocationName, _currentLocationAddress, nil];
            
            NSLog(@"````````````````````no data found`````````````````````````");
        
        //------------------------FIREBASE-----------------------------------
//        // Create a reference to a Firebase database URL
//        Firebase* myRootRef = [[Firebase alloc] initWithUrl:@"https://radiant-torch-5845.firebaseIO.com"];
//        _transactionElementsRef = [myRootRef childByAppendingPath: @"transactionElements"];
//        
//        // Read data and react to changes
//        [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//            NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
//        }];
        
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
         
         
         //TODO modify these guys in the setters
         Firebase *alanRef = [usersRef childByAppendingPath: @"alanisawesome"];
         [alanRef setValue: alanisawesome];
         
         Firebase *hopperRef = [usersRef childByAppendingPath: @"gracehop"];
         [hopperRef setValue: gracehop];
         
         */
        
        //    // Write data to Firebase - TODO WHERE TO PUT THIS??
        //    [myRootRef setValue:@"Do you have data? You'll love Firebase."];
        } else{
            NSLog(@"````````````````````initializing transaction elements from file`````````````````````````");
            //TODO - load the saved properties into the UIElements
            _isSeller = TRUE;
            
            _buyerDateAndTime = @"No time selected";
            _sellerDateAndTime = @"No time selected";
            _agreedUponDateAndTime = @"No time agreed upon";
            
            _transactionMemo = @"No Memo";
            _transactionAmount = @"No Amount Yet";
            
            _locationName = @"No Location Selected";
            _locationAddress = @"No Location Selected";
            _currentLocationName = @"IDK where you are";
            _currentLocationAddress = @"IDK where you are";
        }
        
    }
    return self;
}

//getters
//-(Firebase *) getFirebaseRef{
//    return _transactionElementsRef;
//}

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
    //Firebase *sellerDateAndTimeRef = [transactionElementsRef childByAppendingPath: @"sellerDateAndTime"];
    //NSDictionary *sDAT = @{
    //  @"sellerDateAndTime": sellerDateAndTime,
    //};
    //[sellerDateAndTimeRef updateChildValues: sellerDateAndTime];
    [self save];
}
-(void) setBuyerDateAndTime:(NSString *)buyerDateAndTime{
    _buyerDateAndTime = buyerDateAndTime;
    //Firebase *buyerDateAndTimeRef = [transactionElementsRef childByAppendingPath: @"buyerDateAndTime"];
    //NSDictionary *sDAT = @{
    //  @"buyerDateAndTime": buyerDateAndTime,
    //};
    //[buyerDateAndTimeRef updateChildValues: buyerDateAndTime];
    [self save];
}
-(void) setAgreedUponDateAndTime:(NSString *)agreedUponDateAndTime{
    _agreedUponDateAndTime = agreedUponDateAndTime;
    //Firebase *agreedUponDateAndTimeRef = [transactionElementsRef childByAppendingPath: @"agreedUponDateAndTime"];
    //NSDictionary *sDAT = @{
    //  @"agreedUponDateAndTime": agreedUponDateAndTime,
    //};
    //[agreedUponDateAndTimeRef updateChildValues: agreedUponDateAndTime];
    [self save];
}

-(void) setIsSeller: (BOOL) seller{
    _isSeller = seller;
    //Firebase *isSellerRef = [transactionElementsRef childByAppendingPath: @"isSeller"];
    //NSDictionary *sDAT = @{
    //  @"isSeller": seller,
    //};
    //[isSellerRef updateChildValues: isSeller];
    [self save];
}

- (void) setTransactionMemo: (NSString *) newTransactionMemo{
    _transactionMemo = newTransactionMemo;
    //Firebase *transactionMemoRef = [transactionElementsRef childByAppendingPath: @"transactionMemo"];
    //NSDictionary *sDAT = @{
    //  @"transactionMemo": newTransactionMemo,
    //};
    //[transactionMemoRef updateChildValues: transactionMemo];
    [self save];
    
}
- (void) setTheTransactionAmount:(NSString *) transactionAmnt{
    
    NSLog(@"Entered setTransactionAmt");
    self.transactionAmount = transactionAmnt;
    //Firebase *transactionAmountRef = [transactionElementsRef childByAppendingPath: @"transactionAmount"];
    //NSDictionary *sDAT = @{
    //  @"transactionAmount": transactionAmnt,
    //};
    //[transactionAmountRef updateChildValues: transactionAmount];
    [self save];
}

-(void) setLocationName:(NSString *) newLocationName{
    _locationName = newLocationName;
    //Firebase *locationNameRef = [transactionElementsRef childByAppendingPath: @"locationName"];
    //NSDictionary *sDAT = @{
    //  @"locationName": newLocationName,
    //};
    //[locationNameRef updateChildValues: locationName];
    [self save];
}
-(void) setLocationAddress:(NSString *) newLocationAddress{
    _locationAddress = newLocationAddress;
    //Firebase *locationAddressRef = [transactionElementsRef childByAppendingPath: @"locationAddress"];
    //NSDictionary *sDAT = @{
    //  @"locationAddress": newLocationAddress,
    //};
    //[locationAddressRef updateChildValues: locationAddress];
    [self save];
}
-(void) setCurrentLocationName:(NSString *) newCurrentLocationName{
    _locationName = newCurrentLocationName;
    //Firebase *currentLocationNameRef = [transactionElementsRef childByAppendingPath: @"currentLocationName"];
    //NSDictionary *sDAT = @{
    //  @"currentLocationName": newcurrentLocationName,
    //};
    //[currentLocationNameRef updateChildValues: currentLocationName];
    [self save];
}
-(void) setCurrentLocationAddress:(NSString *) newCurrentLocationAddress{
    _locationAddress = newCurrentLocationAddress;
    //Firebase *currentLocationAddressRef = [transactionElementsRef childByAppendingPath: @"currentLocationAddress"];
    //NSDictionary *sDAT = @{
    //  @"currentLocationAddress": newcurrentLocationAddress,
    //};
    //[currentLocationAddressRef updateChildValues: currentLocationAddress];
    [self save];
}
    
- (void) save {
    [self.transactionElements writeToFile:self.filePath atomically:YES];
}

@end
