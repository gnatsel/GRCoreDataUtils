//
//  UserDAO.m
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "UserDAO.h"
#import "User.h"
@implementation UserDAO

+(void)deleteUser:(User *)user{
    [GRCoreDataUtils deleteManagedObject:user];
}


+(User *)userUpdatedWithDictionary:(NSDictionary *)dictionary{
    NSArray *keyPathsArray = @[@"firstname",@"lastname",@"userId"];
    return (User *)[UserDAO userUpdatedWithKeyPaths:keyPathsArray
                                     withDictionary:dictionary
                                dictionaryKeyPaths:keyPathsArray];
}

+(User *)userUpdatedWithKeyPaths:(NSArray *)keyPathsArray
                  withDictionary:(NSDictionary *)dictionary
              dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray{
    return (User *)[UserDAO managedObjectForEntityClass:[User class]
                                                predicateFormat:[NSString stringWithFormat:@"userId = '%@'",dictionary[@"userId"]]
                                          managedObjectKeyPaths:keyPathsArray
                                                 withDictionary:dictionary
                                            dictionaryKeyPaths:dictionaryKeyPathsArray];
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
