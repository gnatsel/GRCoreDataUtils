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
-(void)configureWithObject:(id)anObject{
    [super configureWithObject:anObject];
    [self configureWithUser:anObject];
}

-(void)configureWithUser:(User *)user{
    [self configureFullNameLabelWithUser:user];
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

-(NSDictionary *)dictionaryEntity{
    NSMutableDictionary *dictionaryEntity = [NSMutableDictionary dictionary];
    if(_firstnameTextField){
        dictionaryEntity[@"firstname"] = self.firstnameTextField.text;
    }
    if(_lastnameTextField){
        dictionaryEntity[@"lastname"] = self.lastnameTextField.text;
    }
    return dictionaryEntity;
}
@end
