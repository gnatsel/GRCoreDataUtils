//
//  GRCoreDataUtils.m
//  GRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "GRCoreDataUtils.h"
@implementation GRCoreDataUtils

+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                           updateWithDictionary:(NSDictionary *)dictionary
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObject *managedObject = nil;
    BOOL shouldInstantiateNewManagedObject = YES;
    NSString *entityName = NSStringFromClass(entityClass);
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    if(predicateFormat){
        NSFetchRequest *request= [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
        
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *managedObjectsArray = [managedObjectContext executeFetchRequest:request error:&error];
        
        if(!error && managedObjectsArray && managedObjectsArray.count > 0){
            managedObject = [managedObjectsArray firstObject];
            shouldInstantiateNewManagedObject = NO;

            [GRCoreDataUtils updateManagedObject:managedObject withDictionary:dictionary];
        }
        else{
            
            if(error){
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
        }

    }
    
    
    if(shouldInstantiateNewManagedObject){
        managedObject = [GRCoreDataUtils instantiateManagedObjectForEntityName:entityName
                                                      withEntityDescription:entityDescription
                                                             withDictionary:dictionary
                                                     inManagedObjectContext:managedObjectContext];
    }
    return managedObject;
}




+(NSManagedObject *)instantiateManagedObjectForEntityName:(NSString *)entityName
                                    withEntityDescription:(NSEntityDescription *)entityDescription
                                           withDictionary:(NSDictionary *)dictionary
                                   inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    [GRCoreDataUtils updateManagedObject:managedObject withDictionary:dictionary];
    return managedObject;
}




+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass  predicateFormat:(NSString *)predicateFormat inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [GRCoreDataUtils managedObjectsArrayForEntityName:NSStringFromClass(entityClass) predicateFormat:predicateFormat inManagedObjectContext:managedObjectContext];
}



+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName  predicateFormat:(NSString *)predicateFormat inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *request= [[NSFetchRequest alloc] initWithEntityName:entityName];
    if(predicateFormat){
        [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat]];
    }
    NSError *error = nil;
    NSArray *managedObjectsArray = [managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return managedObjectsArray;
}



+(void)updateManagedObject:(NSManagedObject *)managedObject withDictionary:(NSDictionary *)dictionary{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [managedObject setValue:obj forKeyPath:key];
    }];
}




+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray
                       forEntityClass:(Class)entityClass
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectArray
                                   forEntityName:NSStringFromClass(entityClass)
                                 predicateFormat:predicateFormat
                          inManagedObjectContext:managedObjectContext];
}
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray
                        forEntityName:(NSString *)entityName
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *allManagedObjectArray = [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:predicateFormat inManagedObjectContext:managedObjectContext];
    for(NSManagedObject *managedObject in allManagedObjectArray){
        if(![managedObjectArray containsObject:managedObject]){
            @try {
                BOOL shouldDeleteManagedObject = YES;
                for(NSManagedObject *newManagedObject in managedObjectArray){
                    if([newManagedObject.objectID isEqual:managedObject.objectID]){
                        shouldDeleteManagedObject = NO;
                    }
                }
                if(shouldDeleteManagedObject)
                    [managedObjectContext deleteObject:[managedObjectContext objectWithID:managedObject.objectID]];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
            @finally {
                
            }
        }
    }
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
    }
}



+(void)deleteManagedObjectsForEntityClass:(Class )entityClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    [GRCoreDataUtils deleteManagedObjectsForEntityName:NSStringFromClass(entityClass) inManagedObjectContext:managedObjectContext];
}
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSArray *allManagedObjectArray = [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:nil inManagedObjectContext:managedObjectContext];
    for(NSManagedObject *managedObject in allManagedObjectArray){
        @try {
            [managedObjectContext deleteObject:managedObject];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
    }
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
    }
}







+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    if(predicateFormat){
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:predicateFormat]];
    }
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    fetchedResultsController.delegate = delegate;
    NSError *error;
    @try {
        [fetchedResultsController performFetch:&error];
        if(error)
            NSLog(@"%@",error);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception : %@",exception);
    }
    @finally {
        
    }
    return fetchedResultsController;
    
}

@end