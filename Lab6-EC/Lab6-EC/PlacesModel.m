//
//  PlacesModel.m
//  Lab6-EC
//
//  Created by Anthony Wittemann on 4/27/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "PlacesModel.h"
static NSString *const kPlacesPList = @"placesPropertyList.plist";

@interface PlacesModel()

//private properties
@property (strong, nonatomic) NSMutableArray *places;

@end



@implementation PlacesModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //initialize properties from plist
        //search for plist in a bundle
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"species_names" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        _places = [NSMutableArray arrayWithArray:[dict objectForKey:@"Root"]];
        
        if(!self.places){
            
            _places = NULL;
        }
            

    }
    return self;
}


@end
