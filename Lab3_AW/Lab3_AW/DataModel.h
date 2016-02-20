//
//  DataModel.h
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/17/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

//public properties

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSNumber *number;

@property float num;
@property NSUInteger unum;

@property float bill;
@property float taxRate;
@property float tax;
@property bool tipIncludesTax;
@property float totalForTip;
@property float tipPercentage;
@property int splitNum;
@property float tip;
@property float totalWithTip;
@property float totalPerPerson;



//public methods
- (NSUInteger) getNumCourses;
- (NSString *) getCourseAtIndex: (NSUInteger) index;
+ (instancetype) sharedModel;



@end
