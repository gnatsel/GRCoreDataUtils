//
//  GRCoreDataUtils+AppDelegate.h
//  SampleGRCoreDataUtils
//
//  Created by Olivier Lestang [DAN-PARIS] on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "GRCoreDataUtils.h"

@interface GRCoreDataUtils (AppDelegate)

+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass predicateFormat:(NSString *)predicateFormat updateWithDictionary:(NSDictionary *)dictionary;
+(NSManagedObject *)instantiateManagedObjectForEntityClass:(Class)entityClass withEntityDescription:(NSEntityDescription *)entityDescription withDictionary:(NSDictionary *)dictionary;
+(NSManagedObject *)instantiateManagedObjectForEntityName:(NSString *)entityName withEntityDescription:(NSEntityDescription *)entityDescription withDictionary:(NSDictionary *)dictionary;


+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass;
+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass  predicateFormat:(NSString *)predicateFormat;
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName;
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName  predicateFormat:(NSString *)predicateFormat;

+(void)deleteManagedObject:(NSManagedObject *)managedObject;
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass;
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName;
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass predicateFormat:(NSString *)predicateFormat;
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName predicateFormat:(NSString *)predicateFormat;
+(void)deleteManagedObjectsForEntityClass:(Class )entityClass;
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName;
+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectClass:(Class)entityClass notInArray:(NSArray *)managedObjectArray;
+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectNamed:(NSString *)entityName notInArray:(NSArray *)managedObjectArray;

+(void)saveDatabase;

+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      sortDescriptors:(NSArray *)sortDescriptors;
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     sortDescriptors:(NSArray *)sortDescriptors;
+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      predicateFormat:(NSString *)predicateFormat
                                                      sortDescriptors:(NSArray *)sortDescriptors;
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors;
@end
