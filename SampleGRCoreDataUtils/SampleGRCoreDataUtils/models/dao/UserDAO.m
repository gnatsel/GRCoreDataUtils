//
//  UserDAO.m
//  SampleGRCoreDataUtils
//
//  Created by Olivier Lestang [DAN-PARIS] on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "UserDAO.h"
#import "User.h"
@implementation UserDAO

+(void)deleteUser:(User *)user{
    [GRCoreDataUtils deleteManagedObject:user];
}
+(User *)userUpdatedWithDictionary:(NSDictionary *)dictionary{
    return (User *)[GRCoreDataUtils managedObjectForEntityClass:[User class]
                                        predicateFormat:[NSString stringWithFormat:@"userId = '%@'",dictionary[@"userId"]]
                                   updateWithDictionary:dictionary];
}
+(NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate{
    return [GRCoreDataUtils fetchedResultsControllerForEntityClass:[User class]
                                                          delegate:delegate
            sortDescriptors:@[
                              [[NSSortDescriptor alloc]initWithKey:@"firstname" ascending:YES],
                              [[NSSortDescriptor alloc]initWithKey:@"lastname" ascending:YES]
                              ]];
}

@end
