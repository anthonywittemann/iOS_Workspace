//
//  ReviewViewController.m
//  FinalProject
//
//  Created by Anthony Wittemann on 5/3/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "ReviewViewController.h"
#import "TransactionModel.h"

@interface ReviewViewController ()
@property (strong,nonatomic) TransactionModel *model;
@property (weak, nonatomic) IBOutlet UILabel *meetingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak, nonatomic) IBOutlet UITextView *transactionMemoTV;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [TransactionModel sharedModel];
    
    //set up the UIElements with data from the model
    if(self.model.isIsSeller){
        self.meetingTimeLabel.text = self.model.getSellerDateAndTime;
    } else{
        self.meetingTimeLabel.text = self.model.getBuyerDateAndTime;
    }
    self.transactionAmountLabel.text = self.model.getTransactionAmount;
    self.transactionMemoTV.text = self.model.getTransactionMemo;
    self.locationNameLabel.text = self.model.getLocationName;
    self.locationAddressLabel.text = self.model.getLocationAddress;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/* - code for map view if I have time
 //
 //    // Create a GMSCameraPosition that tells the map to display the
 //    // coordinate -33.86,151.20 at zoom level 6.
 //    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
 //                                                            longitude:151.20
 //                                                                 zoom:6];
 //    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
 //    mapView_.myLocationEnabled = YES;
 //    self.view = mapView_;
 //
 //    // Creates a marker in the center of the map.
 //    GMSMarker *marker = [[GMSMarker alloc] init];
 //    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
 //    marker.title = @"Sydney";
 //    marker.snippet = @"Australia";
 //    marker.map = mapView_;
 
 */

@end
