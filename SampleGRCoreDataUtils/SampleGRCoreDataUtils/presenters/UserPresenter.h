//
//  UserPresenter.h
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "Presenter.h"
@class User;
@interface UserPresenter : Presenter

@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfMessagesReceivedLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfMessagesSentLabel;

@property (nonatomic, weak) IBOutlet UITextField *lastnameTextField;
@property (nonatomic, weak) IBOutlet UITextField *firstnameTextField;


-(void)configureWithUser:(User *)user;

@end
