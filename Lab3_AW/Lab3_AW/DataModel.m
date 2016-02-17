//
//  DataModel.m
//  Lab3_AW
//
//  Created by Anthony Wittemann on 2/17/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "DataModel.h"

//class extension
@interface DataModel ()

// private properties
@property (strong, nonatomic) NSArray *courses;

@end



@implementation DataModel

//class methods

+ (instancetype) sharedModel {
    static DataModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstName = @"Unknown";
        self.lastName = @"Unknown";
        self.number = [[NSNumber alloc] initWithInt:0];
        self.num = 0.0;
        self.unum = 1;
        
        self.courses = [[NSArray alloc] initWithObjects: @"ITP 342", @"EE 364", @"EE 101", @"ARTH 121", nil];
        self.courses = [NSArray arrayWithObjects: @"ITP 342", @"EE 364", @"EE 101", @"ARTH 121", nil];
        
        //TODO initialize data from h file
    }
    return self;
}

- (NSUInteger) getNumCourses{
    return [self.courses count];
}

- (NSString *) getCourseAtIndex:(NSUInteger) index{
    return self.courses[index];
}

@end
