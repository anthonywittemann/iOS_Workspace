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

//public methods
- (NSUInteger) getNumCourses;
- (NSString *) getCourseAtIndex: (NSUInteger) index;
+ (instancetype) sharedModel;

//TODO add properties for variables such as tip, tax, total etc.


@end
