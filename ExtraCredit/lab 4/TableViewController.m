//
//  TableViewController.m
//  lab 4
//
//  Created by Anthony Wittemann on 3/16/16.
//  Copyright © 2016 Anthony Wittemann. All rights reserved.
//

#import "TableViewController.h"
#import "FlashcardsModel.h"
#import "AddViewController.h"


@interface TableViewController ()
//@property (strong,nonatomic) QuotesModel *model;
@property (strong,nonatomic) FlashcardsModel *model;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [FlashcardsModel sharedModel];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfFlashcards];
}



- (UITableViewCell *)tableView: (UITableView *) tableView
         cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"QuestionTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *flashcard = [self.model flashcardAtIndex:indexPath.row];
//
    cell.textLabel.text = [flashcard objectForKey: kQuestionKey];
    cell.detailTextLabel.text = [flashcard objectForKey: kAnswerKey];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model removeFlashcardAtIndex:indexPath.row];
        // Delete the row from the tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath]
            withRowAnimation:UITableViewRowAnimationFade];
        
    
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (IBAction)addQuote:(id)sender {
    [self performSegueWithIdentifier:@"addSegue" sender:sender];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
    if([segue.identifier isEqual:@"addSegue"]){
        
        AddViewController* addVC = [segue destinationViewController];

        
        addVC.labelString = @"Please enter a Question";
        addVC.textFieldPlaceHolder = @"Answer";
        
        
        [addVC setCompletion:^(NSString* textViewString, NSString* textFieldString){
            
            if(textViewString != nil){
                [self.model insertFlashcard:textViewString answer:textFieldString];
                [self.tableView reloadData];
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}


@end
