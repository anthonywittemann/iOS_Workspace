//
//  LocationSelectorViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/2/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "LocationSelectorViewController.h"
#import "TransactionModel.h"
#import <Firebase/Firebase.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;

@interface LocationSelectorViewController ()
// Instantiate a pair of UILabels in Interface Builder
//needed for google maps API
<CLLocationManagerDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//@property (weak, nonatomic) IBOutlet UILabel *currentNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *currentAddressLabel;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//for UI not on google maps
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLocNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLocAddressLabel;


@property (strong,nonatomic) TransactionModel *model;
@end

@implementation LocationSelectorViewController

GMSPlacesClient *_placesClient;
GMSPlacePicker *_placePicker;

//GMSMapView *mapView_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [TransactionModel sharedModel];
    
    [[self mapView] setShowsUserLocation:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [[self locationManager] setDelegate:self];
    
    // we have to setup the location manager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    
    _placesClient = [[GMSPlacesClient alloc] init];
    self.locationNameLabel.text = self.model.getLocationName;
    self.locationAddressLabel.text = self.model.getLocationAddress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    _currentLocNameLabel.text = [NSString stringWithFormat:@"%.6f",
                              location.coordinate.latitude];
    _currentLocAddressLabel.text = [NSString stringWithFormat:@"%.6f",
                                 location.coordinate.longitude];
    
//    NSLog([NSString stringWithFormat:@"%.6f",
//          location.coordinate.latitude]);
//    NSLog([NSString stringWithFormat:@"%.6f",
//           location.coordinate.longitude]);

}

// to get current location - TODO NOT WORKING
// Add a UIButton in Interface Builder to call this function
- (IBAction)getCurrentPlace:(UIButton *)sender {
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        self.currentLocNameLabel.text = @"No current place";
        self.currentLocAddressLabel.text = @"";
        
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                self.currentLocNameLabel.text = place.name;
                self.currentLocAddressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
                                          componentsJoinedByString:@"\n"];
            }
        }
        [self.model setCurrentLocationName:self.currentLocNameLabel.text];
        [self.model setCurrentLocationAddress:self.currentLocAddressLabel.text];
        NSLog(@"Name: %@", self.currentLocNameLabel.text);
        NSLog(@"Address: %@", self.currentLocAddressLabel.text);
        NSLog(@"^v^v^v^v^v^v^v^v^v^ -- GOT CURRENT LOCATION FROM GOOGLE MAPS -- v^v^v^v^v^v^v^v^v^v^v");
    }];
}


// Add a UIButton in Interface Builder to call this function
- (IBAction)pickPlace:(UIButton *)sender {
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(34.0224, -118.2851);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            self.locationNameLabel.text = place.name;
            self.locationAddressLabel.text = [[place.formattedAddress
                                       componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
        } else {
            self.locationNameLabel.text = @"No place selected";
            self.locationAddressLabel.text = @"";
        }
        
        [self.model setLocationName:self.locationNameLabel.text];
        [self.model setLocationAddress:self.locationAddressLabel.text];

        NSLog(@"Name: %@", self.locationNameLabel.text);
        NSLog(@"Address: %@", self.locationAddressLabel.text);
        NSLog(@"------------------ PLACE PICKED -----------------------"); // TODO - data not being returned or displayed
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
