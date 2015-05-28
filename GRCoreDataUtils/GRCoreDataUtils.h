//
//  GRCoreDataUtils.h
//  GRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Riveilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface GRCoreDataUtils : NSObject
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                           updateWithDictionary:(NSDictionary *)dictionary
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(NSManagedObject *)instantiateManagedObjectForEntityName:(NSString *)entityName
                                    withEntityDescription:(NSEntityDescription *)entityDescription
                                           withDictionary:(NSDictionary *)dictionary
                                   inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;



+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass  predicateFormat:(NSString *)predicateFormat inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName  predicateFormat:(NSString *)predicateFormat inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

+(void)updateManagedObject:(NSManagedObject *)managedObject withDictionary:(NSDictionary *)dictionary;

+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray
                        forEntityClass:(Class)entityClass
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray
                        forEntityName:(NSString *)entityName
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

+(void)deleteManagedObjectsForEntityClass:(Class )entityClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
