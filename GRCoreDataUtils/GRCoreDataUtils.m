//
//  GRCoreDataUtils.m
//  GRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "GRCoreDataUtils.h"
@implementation GRCoreDataUtils


+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [GRCoreDataUtils managedObjectForEntityName:entityName
                                        predicateFormat:predicateFormat
                                   updateWithDictionary:nil
                                 inManagedObjectContext:managedObjectContext];
}


+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [GRCoreDataUtils managedObjectForEntityClass:entityClass
                                        predicateFormat:predicateFormat
                                   updateWithDictionary:nil
                                 inManagedObjectContext:managedObjectContext];
}


+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                           updateWithDictionary:(NSDictionary *)dictionary
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [GRCoreDataUtils managedObjectForEntityName:NSStringFromClass(entityClass)
                                       predicateFormat:predicateFormat
                                  updateWithDictionary:dictionary
                                inManagedObjectContext:managedObjectContext];
}

+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                          updateWithDictionary:(NSDictionary *)dictionary
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSManagedObject *managedObject = nil;
    BOOL shouldInstantiateNewManagedObject = YES;
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
                DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
        }
        
    }
    
    
    if(shouldInstantiateNewManagedObject){
        managedObject = [GRCoreDataUtils instantiateManagedObjectWithEntityDescription:entityDescription
                                                                withDictionary:dictionary
                                                        inManagedObjectContext:managedObjectContext];
    }
    return managedObject;
}


+(NSManagedObject *)instantiateManagedObjectWithEntityDescription:(NSEntityDescription *)entityDescription
                                           withDictionary:(NSDictionary *)dictionary
                                   inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    [GRCoreDataUtils updateManagedObject:managedObject withDictionary:dictionary];
    return managedObject;
}

+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                 withDictionary:(NSDictionary *)dictionary
                           dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSManagedObject *managedObject = [GRCoreDataUtils managedObjectForEntityName:entityName
                                                                 predicateFormat:predicateFormat
                                                          inManagedObjectContext:managedObjectContext];
    NSUInteger dictionaryKeyPathsArrayCount = dictionaryKeyPathsArray.count;
    for(NSUInteger dictionaryKeyPathsArrayIndex = 0 ; dictionaryKeyPathsArrayIndex < dictionaryKeyPathsArrayCount ; dictionaryKeyPathsArrayIndex++){
        @try{
            id managedObjectKeyPath = managedObjectKeyPathsArray[dictionaryKeyPathsArrayIndex];
            id dictionaryKey = dictionaryKeyPathsArray[dictionaryKeyPathsArrayIndex];
            [managedObject setValue:[dictionary valueForKeyPath:dictionaryKey]
                         forKeyPath:managedObjectKeyPath];
        }
        @catch(NSException *e){
            DLog(@"Unresolved error %@, %@", e, [e userInfo]);
        }
        
    }
    return managedObject;
    
}

+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                               predicateFormat:(NSString *)predicateFormat
                         managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                withDictionary:(NSDictionary *)dictionary
                          dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [GRCoreDataUtils managedObjectForEntityName:NSStringFromClass(entityClass)
                                       predicateFormat:predicateFormat
                                 managedObjectKeyPaths:managedObjectKeyPathsArray
                                        withDictionary:dictionary
                                  dictionaryKeyPaths:dictionaryKeyPathsArray
                                inManagedObjectContext:managedObjectContext];
}


+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass
                              predicateFormat:(NSString *)predicateFormat
                       inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    return [GRCoreDataUtils managedObjectsArrayForEntityName:NSStringFromClass(entityClass) predicateFormat:predicateFormat inManagedObjectContext:managedObjectContext];
}



+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName
                             predicateFormat:(NSString *)predicateFormat
                      inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *request= [[NSFetchRequest alloc] initWithEntityName:entityName];
    if(predicateFormat){
        [request setPredicate:[NSPredicate predicateWithFormat:predicateFormat]];
    }
    NSError *error = nil;
    NSArray *managedObjectsArray = [managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return managedObjectsArray;
}



+(void)updateManagedObject:(NSManagedObject *)managedObject
            withDictionary:(NSDictionary *)dictionary{
    if(dictionary){
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [managedObject setValue:(obj == [NSNull null])?nil:obj forKeyPath:key];
        }];
    }
}




+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectsArray
                       forEntityClass:(Class)entityClass
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectsArray
                                   forEntityName:NSStringFromClass(entityClass)
                                 predicateFormat:predicateFormat
                          inManagedObjectContext:managedObjectContext];
}
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectsArray
                        forEntityName:(NSString *)entityName
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    //Fetch all managed objects satisfying "predicateFormat" and delete the ones not in "managedObjectsArray"
    //Should be rewrote
    NSArray *allmanagedObjectsArray = [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:predicateFormat inManagedObjectContext:managedObjectContext];
    for(NSManagedObject *managedObject in allmanagedObjectsArray){
        if(![managedObjectsArray containsObject:managedObject]){
            @try {
                BOOL shouldDeleteManagedObject = YES;
                for(NSManagedObject *newManagedObject in managedObjectsArray){
                    if([newManagedObject.objectID isEqual:managedObject.objectID]){
                        shouldDeleteManagedObject = NO;
                        break;
                    }
                }
                if(shouldDeleteManagedObject)
                    [managedObjectContext deleteObject:[managedObjectContext objectWithID:managedObject.objectID]];
            }
            @catch (NSException *e) {
                DLog(@"Unresolved error %@, %@", e, [e userInfo]);
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
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
    }
}



+(void)deleteManagedObjectsForEntityClass:(Class )entityClass
                   inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    [GRCoreDataUtils deleteManagedObjectsForEntityName:NSStringFromClass(entityClass) inManagedObjectContext:managedObjectContext];
}
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName
                  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSArray *allmanagedObjectsArray = [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:nil inManagedObjectContext:managedObjectContext];
    for(NSManagedObject *managedObject in allmanagedObjectsArray){
        @try {
            [managedObjectContext deleteObject:managedObject];
        }
        @catch (NSException *exception) {
            DLog(@"%@",exception);
        }
        @finally {
            
        }
    }
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
            DLog(@"%@",error);
    }
    @catch (NSException *exception) {
        DLog(@"Exception : %@",exception);
    }
    @finally {
        
    }
    return fetchedResultsController;
    
}

+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
   return [GRCoreDataUtils fetchedResultsControllerForEntityName:NSStringFromClass(entityClass)
                                                        delegate:delegate
                                                 predicateFormat:predicateFormat
                                                 sortDescriptors:sortDescriptors
                                            managedObjectContext:managedObjectContext];
    
}

@end