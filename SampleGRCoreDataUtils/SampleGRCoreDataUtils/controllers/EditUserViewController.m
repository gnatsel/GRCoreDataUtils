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
#import "UIView+Presenter.h"
#import "Presenter.h"

@interface EditUserViewController ()

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if(_currentUser){
        self.title = @"Edit user";
        [self.view.presenter configureWithObject:_currentUser];
    }
    else{
        self.title = @"Create User";
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (IBAction)validateAction:(id)sender {
    NSMutableDictionary *dictionaryEntity = (NSMutableDictionary *)[self.view.presenter dictionaryEntity];
    if(_currentUser){
        [UserDAO updateManagedObject:_currentUser withDictionary:dictionaryEntity];
    }
    else{
        dictionaryEntity[@"userId"] = [[NSUUID UUID]UUIDString];
        [UserDAO userUpdatedWithDictionary:dictionaryEntity];
    }
    [UserDAO saveDatabase];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
