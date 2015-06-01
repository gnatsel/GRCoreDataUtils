//
//  UserPresenter.m
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "UserPresenter.h"
#import "User.h"
@implementation UserPresenter
-(void)configureWithUser:(User *)user{
    [self configureFullNameLabelWithUser:user];
    [self configureNumberOfMessagesReceivedLabelWithUser:user];
    [self configureNumberOfMessagesSentLabelWithUser:user];
    [self configureFirstnameTextFieldWithUser:user];
    [self configureLastnameTextFieldWithUser:user];
}


-(void)configureFullNameLabelWithUser:(User *)user{
    if(_fullnameLabel){
        NSString *fullnameString = @"";
        if(user.firstname && user.lastname){
            fullnameString = [NSString stringWithFormat:@"%@ %@", user.firstname, user.lastname];
        }
        else if(user.firstname && !user.lastname){
            fullnameString = user.firstname;
        }
        else if(!user.firstname && user.lastname){
            fullnameString = user.lastname;
        }
        _fullnameLabel.text = fullnameString;
    }
}

-(void)configureNumberOfMessagesReceivedLabelWithUser:(User *)user{
    if(_numberOfMessagesReceivedLabel){
        _numberOfMessagesReceivedLabel.text = [NSString stringWithFormat:@"%d",(int)user.receivedMessages.count];
    }
}

-(void)configureNumberOfMessagesSentLabelWithUser:(User *)user{
    if(_numberOfMessagesSentLabel){
        _numberOfMessagesSentLabel.text = [NSString stringWithFormat:@"%d",(int)user.sentMessages.count];
    }
}


-(void)configureFirstnameTextFieldWithUser:(User *)user{
    if(_firstnameTextField){
        self.firstnameTextField.text = user.firstname;
    }
}

-(void)configureLastnameTextFieldWithUser:(User *)user{
    if(_lastnameTextField){
        self.lastnameTextField.text = user.lastname;


    }
}
@end
