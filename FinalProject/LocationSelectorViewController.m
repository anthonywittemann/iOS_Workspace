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

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) double cLatitude;
@property (nonatomic) double cLongitude;

//for UI not on google maps
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;


@property (strong,nonatomic) TransactionModel *model;
@end

@implementation LocationSelectorViewController

GMSPlacesClient *_placesClient;
GMSPlacePicker *_placePicker;

//GMSMapView *gmsMapView;

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
    
    _mapView=[[MKMapView alloc] initWithFrame:self.view.frame];
    _mapView.showsUserLocation=TRUE;
    _mapView.delegate=self;
    
//    //------------------- LOAD MAP VIEW OF CURRENT LOCATION --------------------
//    
//    // Create a GMSCameraPosition that tells the map to display the
//    // current location from core location at zoom level 13.
//    
////    while(_cLongitude == 0 && _cLatitude == 0); //wait until we get a location to display map
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_cLatitude
//                                                            longitude:_cLongitude
//                                                                 zoom:14];
//    gmsMapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    gmsMapView.myLocationEnabled = YES;
//    //self.view = gmsMapView;
//    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(_cLatitude, _cLongitude);
//    marker.title = @"You are here";
////    marker.snippet = @"Australia";
//    marker.map = gmsMapView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    _cLatitude = location.coordinate.latitude;
    _cLongitude = location.coordinate.longitude;
    //[gmsMapView animateToLocation:location.coordinate];
    
    
    
}

-(void)mapView:(MKMapView *)mapV didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"map new location: %f %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    _location=userLocation.coordinate;
    
    MKCoordinateRegion region;
    region.center=_location;
    MKCoordinateSpan span;
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    
    [mapV setRegion:region animated:TRUE];
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









// to get current location - TODO NOT WORKING
//// Add a UIButton in Interface Builder to call this function
//- (IBAction)getCurrentPlace:(UIButton *)sender {
//    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
//        if (error != nil) {
//            NSLog(@"Pick Place error %@", [error localizedDescription]);
//            return;
//        }
//
//        self.currentLocNameLabel.text = @"No current place";
//        self.currentLocAddressLabel.text = @"";
//
//        if (placeLikelihoodList != nil) {
//            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
//            if (place != nil) {
//                self.currentLocNameLabel.text = place.name;
//                self.currentLocAddressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
//                                          componentsJoinedByString:@"\n"];
//            }
//        }
//        [self.model setCurrentLocationName:self.currentLocNameLabel.text];
//        [self.model setCurrentLocationAddress:self.currentLocAddressLabel.text];
//        NSLog(@"Name: %@", self.currentLocNameLabel.text);
//        NSLog(@"Address: %@", self.currentLocAddressLabel.text);
//        NSLog(@"^v^v^v^v^v^v^v^v^v^ -- GOT CURRENT LOCATION FROM GOOGLE MAPS -- v^v^v^v^v^v^v^v^v^v^v");
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
