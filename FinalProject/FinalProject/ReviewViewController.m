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

@end
