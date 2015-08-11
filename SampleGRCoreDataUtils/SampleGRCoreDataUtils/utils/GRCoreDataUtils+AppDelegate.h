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


/**
 * Fetch NSManagedObjects for the given entity class
 *
 * @param entityClass   The class of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSArray of NSManagedObjects for the given entity class
 */
+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass;

/**
 * Fetch NSManagedObjects for the given entity class and predicate
 *
 * @param entityClass       The class of the entity to fetch
 * @param predicateFormat   The predicate of the fetch request
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSArray of NSManagedObjects for the given entity class
 */
+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass  predicateFormat:(NSString *)predicateFormat;

/**
 * Fetch NSManagedObjects for the given entity name
 *
 * @param entityName   The name of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSArray of NSManagedObjects for the given entity name
 */
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName;

/**
 * Fetch NSManagedObjects for the given entity class and predicate
 *
 * @param entityName       The name of the entity to fetch
 * @param predicateFormat   The predicate of the fetch request
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSArray of NSManagedObjects for the given entity name
 */
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName  predicateFormat:(NSString *)predicateFormat;


/**
 * Delete the given managed object
 *
 * @param managedObject   The NSManagedObject to delete
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObject:(NSManagedObject *)managedObject;

/**
 * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class
 *
 * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
 * @param entityClass           The class of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass;

/**
 * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity name
 *
 * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
 * @param entityName            The name of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName;

/**
 * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class and corresponding to the given predicate
 *
 * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
 * @param entityClass           The name of the entity to fetch
 * @param predicateFormat       The predicate used to delete NSManagedObjects
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityClass:(Class)entityClass predicateFormat:(NSString *)predicateFormat;

/**
 * Delete all NSManagedObjects not existing in managedObjectsArray for the given entity class and corresponding to the given predicate
 *
 * @param managedObjectArray    The NSArray of NSManagedObjects to preserve
 * @param entityName           The name of the entity to fetch
 * @param predicateFormat       The predicate used to delete NSManagedObjects
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectArray forEntityName:(NSString *)entityName predicateFormat:(NSString *)predicateFormat;

/**
 * Delete all NSManagedObjects for the given entity class
 *
 * @param entityClass           The name of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsForEntityClass:(Class )entityClass;

/**
 * Delete all NSManagedObjects for the given entity name
 *
 * @param entityName           The name of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName;

/**
 * Set a keyPath value for all NSManagedObjects corresponding to the given entity class not existing in managedObjectArray
 *
 * @param value           The value that will be set for the given keyPath
 * @param keyPath         The keyPath in the NSManagedObjects to update
 * @param entityClass     The class of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectClass:(Class)entityClass notInArray:(NSArray *)managedObjectArray;

/**
 * Set a keyPath value for all NSManagedObjects corresponding to the given entity class not existing in managedObjectArray
 *
 * @param value           The value that will be set for the given keyPath
 * @param keyPath         The keyPath in the NSManagedObjects to update
 * @param entityName           The name of the entity to fetch
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 */
+(void)setValue:(id)value forKeyPath:(NSString *)keyPath forManagedObjectNamed:(NSString *)entityName notInArray:(NSArray *)managedObjectArray;

/**
 * Save the context from AppDelegate
 */
+(void)saveDatabase;


/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given class
 *
 * @param entityClass       The class of the entity to fetch
 * @param delegate          The delegate of the NSFetchedResultsController
 * @param sortDescriptors   The sort descriptors used by the NSFetchedRequest instance of the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSFetchedResultsController
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      sortDescriptors:(NSArray *)sortDescriptors
                                                   sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath;

/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given name
 *
 * @param entityName        The name of the entity to fetch
 * @param delegate          The delegate of the NSFetchedResultsController
 * @param sortDescriptors   The sort descriptors used by the NSFetchedRequest instance of the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an instantiated NSFetchedResultsController
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                  sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath;

/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given class
 *
 * @param entityClass           The class of the entity to fetch
 * @param delegate              The delegate of the NSFetchedResultsController
 * @param predicateFormat       The predicate format to fulfill
 * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSFetchedResultsController for the given managedObjectContext
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      predicateFormat:(NSString *)predicateFormat
                                                      sortDescriptors:(NSArray *)sortDescriptors
                                                   sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath;

/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given name
 *
 * @param entityName            The name of the entity to fetch
 * @param delegate              The delegate of the NSFetchedResultsController
 * @param predicateFormat       The predicate format to fulfill
 * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 *
 * @note    the NSManagedObjectContext used is provided by AppDelegate
 *
 * @return an NSFetchedResultsController for the given managedObjectContext
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                  sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath;
@end
