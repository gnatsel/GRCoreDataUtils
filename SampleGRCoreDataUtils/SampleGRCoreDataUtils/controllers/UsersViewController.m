//
//  ViewController.m
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "UsersViewController.h"
#import "UserTableViewCell.h"
#import "User.h"
#import "Constants.h"
#import "EditUserViewController.h"

@interface UsersViewController ()
@property (nonatomic,strong) NSFetchedResultsController *usersFetchedResultsController;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _usersFetchedResultsController = [UserDAO fetchedResultsControllerWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _usersFetchedResultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = NSStringFromClass([UserTableViewCell class]);
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.userPresenter configureWithUser:[_usersFetchedResultsController objectAtIndexPath:indexPath]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:EDIT_USER_SEGUE sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual:EDIT_USER_SEGUE]){
        EditUserViewController *editUserViewController = segue.destinationViewController;
        editUserViewController.currentUser =  [_usersFetchedResultsController objectAtIndexPath:_selectedIndexPath];
    }
}



#pragma mark - fetchedResultControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [_tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if(controller == self.usersFetchedResultsController) {
        @try {
            switch(type) {
                case NSFetchedResultsChangeInsert:{
                    [_tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    break;
                }
                case NSFetchedResultsChangeDelete:{
                    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    break;
                }
                case NSFetchedResultsChangeUpdate:{
                    [((UserTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath]).userPresenter configureWithUser:[_usersFetchedResultsController objectAtIndexPath:indexPath]];
 
                    break;
                }
                case NSFetchedResultsChangeMove:{
                    [_tableView moveRowAtIndexPath:indexPath toIndexPath:indexPath];
                    break;
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [UserDAO deleteUser:[_usersFetchedResultsController objectAtIndexPath:indexPath]];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:{
            break;
        }
            
        case NSFetchedResultsChangeDelete:{
            
            break;
        }
        case NSFetchedResultsChangeMove:{
            break;
        }
        case NSFetchedResultsChangeUpdate:{
            break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [_tableView endUpdates];
    if(!self.view.window){
        [_tableView reloadData];
    }
}

@end
