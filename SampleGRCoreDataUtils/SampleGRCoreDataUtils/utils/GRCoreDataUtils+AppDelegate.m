//
//  GRCoreDataUtils+AppDelegate.m
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "GRCoreDataUtils+AppDelegate.h"
#import "AppDelegate.h"

@implementation GRCoreDataUtils (AppDelegate)

+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                withDictionary:(NSDictionary *)dictionary
                           dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return [GRCoreDataUtils managedObjectForEntityName:entityName
                                       predicateFormat:predicateFormat
                                 managedObjectKeyPaths:managedObjectKeyPathsArray
                                        withDictionary:dictionary
                                   dictionaryKeyPaths:dictionaryKeyPathsArray
                                inManagedObjectContext:appDelegate.managedObjectContext];
    
}


+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                          managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                 withDictionary:(NSDictionary *)dictionary
                            dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray{
    
    return [GRCoreDataUtils managedObjectForEntityName:NSStringFromClass(entityClass)
                                       predicateFormat:predicateFormat
                                 managedObjectKeyPaths:managedObjectKeyPathsArray
                                        withDictionary:dictionary
                                   dictionaryKeyPaths:dictionaryKeyPathsArray];
}


+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                          updatedWithDictionary:(NSDictionary *)dictionary{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return [GRCoreDataUtils managedObjectForEntityClass:entityClass
                                        predicateFormat:predicateFormat
                                   updateWithDictionary:dictionary
                                 inManagedObjectContext:appDelegate.managedObjectContext];
}




+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         updatedWithDictionary:(NSDictionary *)dictionary{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return [GRCoreDataUtils managedObjectForEntityName:entityName
                                        predicateFormat:predicateFormat
                                   updateWithDictionary:dictionary
                                 inManagedObjectContext:appDelegate.managedObjectContext];
}

+(NSManagedObject *)instantiateManagedObjectForEntityClass:(Class)entityClass
                                            withDictionary:(NSDictionary *)dictionary{
    return [GRCoreDataUtils instantiateManagedObjectForEntityName:NSStringFromClass(entityClass) withDictionary:dictionary];
}

+(NSManagedObject *)instantiateManagedObjectForEntityName:(NSString *)entityName
                                           withDictionary:(NSDictionary *)dictionary{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:appDelegate.managedObjectContext];
    return [GRCoreDataUtils instantiateManagedObjectWithEntityDescription:entityDescription
                                                   withDictionary:dictionary
                                           inManagedObjectContext:appDelegate.managedObjectContext];
}



+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass{
    return [GRCoreDataUtils managedObjectsArrayForEntityName:NSStringFromClass(entityClass)];
}
+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass  predicateFormat:(NSString *)predicateFormat{
    return [GRCoreDataUtils managedObjectsArrayForEntityName:NSStringFromClass(entityClass) predicateFormat:predicateFormat];
}
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName{
    return [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:nil];
}

+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName predicateFormat:(NSString *)predicateFormat{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return [GRCoreDataUtils managedObjectsArrayForEntityName:entityName predicateFormat:predicateFormat inManagedObjectContext:appDelegate.managedObjectContext];
}



+(void)deleteManagedObject:(NSManagedObject *)managedObject{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    @try {
        [appDelegate.managedObjectContext deleteObject:managedObject];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}
+(void)deleteManagedObjectsForEntityClass:(Class )entityClass{
    [GRCoreDataUtils deleteManagedObjectsForEntityName:NSStringFromClass(entityClass)];
}
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [GRCoreDataUtils deleteManagedObjectsForEntityName:entityName inManagedObjectContext:appDelegate.managedObjectContext];
    
}

+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass{
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectArray forEntityName:NSStringFromClass(entityClass)];
}
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName{
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectArray forEntityName:entityName predicateFormat:nil];
}
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass predicateFormat:(NSString *)predicateFormat{
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectArray forEntityName:NSStringFromClass(entityClass) predicateFormat:predicateFormat];
}

+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName predicateFormat:(NSString *)predicateFormat{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    [GRCoreDataUtils deleteManagedObjectsNotInArray:managedObjectArray
                                      forEntityName:entityName
                                    predicateFormat:predicateFormat
                             inManagedObjectContext:appDelegate.managedObjectContext];
}


+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectClass:(Class)entityClass notInArray:(NSArray *)managedObjectArray{
    [GRCoreDataUtils setValue:value forKeyPath:keyPath forManagedObjectNamed:NSStringFromClass(entityClass) notInArray:managedObjectArray];
}
+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectNamed:(NSString *)entityName notInArray:(NSArray *)managedObjectArray{
    
    //Performances must be improved
    NSArray *allManagedObjectArray = [GRCoreDataUtils managedObjectsArrayForEntityName:entityName];
    for(NSManagedObject *managedObject in allManagedObjectArray){
        if(![managedObjectArray containsObject:managedObject]){
            [managedObject setValue:value forKeyPath:keyPath];
        }
    }
}



+(void)saveDatabase{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate saveContext];
}








+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      sortDescriptors:(NSArray *)sortDescriptors{
    return [self fetchedResultsControllerForEntityClass:entityClass
                                               delegate:delegate
                                        predicateFormat:nil
                                        sortDescriptors:sortDescriptors];
}
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     sortDescriptors:(NSArray *)sortDescriptors{
    return [self fetchedResultsControllerForEntityName:entityName
                                              delegate:delegate
                                       predicateFormat:nil
                                       sortDescriptors:sortDescriptors];
}



+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      predicateFormat:(NSString *)predicateFormat
                                                      sortDescriptors:(NSArray *)sortDescriptors{
    return [GRCoreDataUtils fetchedResultsControllerForEntityName:NSStringFromClass(entityClass)
                                                         delegate:delegate
                                                  predicateFormat:predicateFormat
                                                  sortDescriptors:(NSArray *)sortDescriptors];
}
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return [GRCoreDataUtils fetchedResultsControllerForEntityName:entityName delegate:delegate predicateFormat:predicateFormat sortDescriptors:sortDescriptors managedObjectContext:appDelegate.managedObjectContext];
    
}

@end
