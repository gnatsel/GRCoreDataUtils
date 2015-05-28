//
//  UserDAO.h
//  SampleGRCoreDataUtils
//
//  Created by Olivier Lestang [DAN-PARIS] on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//
#
#import "GRCoreDataUtils+AppDelegate.h"

@class User;
@interface UserDAO : GRCoreDataUtils
+(void)deleteUser:(User *)user;
+(User *)userUpdatedWithDictionary:(NSDictionary *)dictionary;
+(NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
@end
