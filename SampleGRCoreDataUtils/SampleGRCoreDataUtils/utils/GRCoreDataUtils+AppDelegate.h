//
//  GRCoreDataUtils+AppDelegate.h
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import "GRCoreDataUtils.h"

@interface GRCoreDataUtils (AppDelegate)

/**
 * Fetch or create an NSManagedObject corresponding to the entity name. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityName                    The name of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
 *
 * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
 *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
 *          the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                withDictionary:(NSDictionary *)dictionary
                           dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray;

/**
 * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityClass                   The class of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
 *
 * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
 *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
 *          the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                          managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                 withDictionary:(NSDictionary *)dictionary
                            dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray;




/**
 * Fetch or create an NSManagedObject corresponding to the entity name. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityName                    The class of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         updatedWithDictionary:(NSDictionary *)dictionary;

/**
 * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityClass                   The class of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                          updatedWithDictionary:(NSDictionary *)dictionary;

/**
 * Instantiate an NSManagedObject corresponding to the given entity name in the NSManagedObjectContext from AppDelegate and update it with a dictionary
 *
 * @param entityName    The name of the entity to instantiate
 * @param dictionary    The dictionary that will update the NSManagedObject created before returning it
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)instantiateManagedObjectForEntityName:(NSString *)entityName withDictionary:(NSDictionary *)dictionary;

/**
 * Instantiate an NSManagedObject corresponding to the given entity class in the NSManagedObjectContext from AppDelegate and update it with a dictionary
 *
 * @param entityClass   The class of the entity to instantiate
 * @param dictionary    The dictionary that will update the NSManagedObject created before returning it
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)instantiateManagedObjectForEntityClass:(Class)entityClass withDictionary:(NSDictionary *)dictionary;


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

/**
 * Save the context from AppDelegate
 */
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
