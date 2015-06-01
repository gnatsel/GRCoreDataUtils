//
//  EditUserViewController.m
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "EditUserViewController.h"
#import "User.h"
#import "UserPresenter.h"
@interface EditUserViewController ()
@property (weak, nonatomic) IBOutlet UserPresenter *userPresenter;

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if(_currentUser){
        self.title = @"Edit user";
        [_userPresenter configureWithUser:_currentUser];
    }
    else{
        self.title = @"Create User";
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (IBAction)validateAction:(id)sender {
    if(_currentUser){
        [UserDAO updateManagedObject:_currentUser withDictionary:@{
                                                                   @"firstname":_userPresenter.firstnameTextField.text,
                                                                   @"lastname":_userPresenter.lastnameTextField.text
                                                                   }];
    }
    else{
        [UserDAO userUpdatedWithDictionary:@{
                                             @"userId":_currentUser?_currentUser.userId:[[NSUUID UUID]UUIDString],
                                             @"firstname":_userPresenter.firstnameTextField.text,
                                             @"lastname":_userPresenter.lastnameTextField.text
                                             }];
    }
    [UserDAO saveDatabase];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
