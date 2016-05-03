//
//  ViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 TODO - figure out where to put this writing data
 
 // Create a reference to a Firebase database URL
 Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://radiant-torch-5845.firebaseIO.com"];
 // Write data to Firebase
 [myRootRef setValue:@"Do you have data? You'll love Firebase."];
 
 
 
 TODO - figure out where to put this reading data
 
 // Read data and react to changes
 [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
 NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
 }];
 
 */

@end
