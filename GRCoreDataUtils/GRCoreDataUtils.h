//
//  GRCoreDataUtils.h
//  GRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif
@interface GRCoreDataUtils : NSObject

/**
 * Fetch or Create an NSManagedObject fulfilling the given predicate
 *
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
 *
 * @return an NSManagedObject fulfilling the given predicate
 */
+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Fetch or Create an NSManagedObject fulfilling the given predicate
 *
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate to fulfill
 * @param dictionary            The dictionary that will update the NSManagedObject fetched before returning it
 * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
 *
 * @return an NSManagedObject fulfilling the predicate and updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                          updateWithDictionary:(NSDictionary *)dictionary
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
/**
 * Fetch or Create an NSManagedObject fulfilling the given predicate
 *
 * @param entityClass           The class of the entity to fetch
 * @param predicateFormat       The predicate to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
 *
 * @return an NSManagedObject fulfilling the given predicate
 */
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Fetch or Create an NSManagedObject fulfilling the given predicate
 *
 * @param entityClass           The class of the entity to fetch
 * @param predicateFormat       The predicate to fulfill
 * @param dictionary            The dictionary that will update the NSManagedObject fetched before returning it
 * @param managedObjectContext  The NSManagedObjectContext where the fetch is performed
 *
 * @return an NSManagedObject fulfilling the given predicate and updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                           updateWithDictionary:(NSDictionary *)dictionary
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Instantiate an NSManagedObject corresponding to the entity description in the NSManagedObjectContext and update it with a dictionary
 *
 * @param entityDescription     The entity description used to instantiate the NSManagedObject
 * @param dictionary            The dictionary that will update the NSManagedObject created before returning it
 * @param managedObjectContext  The NSManagedObjectContext where the instantiation is performed
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)instantiateManagedObjectWithEntityDescription:(NSEntityDescription *)entityDescription
                                           withDictionary:(NSDictionary *)dictionary
                                   inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/**
 * Fetch or create an NSManagedObject corresponding to the entity name. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityName                    The name of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
 * @param managedObjectContext          The NSManagedObjectContext where the fetch or instantiation is performed
 *
 * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
 *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityName:(NSString *)entityName
                               predicateFormat:(NSString *)predicateFormat
                         managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                withDictionary:(NSDictionary *)dictionary
                          dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray
                        inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Fetch or create an NSManagedObject corresponding to the entity class. This method handles errors if the key paths or the keys in the given dictionary are not found
 *
 * @param entityClass                   The class of the entity to fetch
 * @param predicateFormat               The predicate to fulfill
 * @param managedObjectKeyPathsArray    The array of keypaths to update in the NSManagedObject
 * @param dictionary                    The dictionary that will update the NSManagedObject before returning it
 * @param dictionaryKeyPathsArray       The array of keypaths to find in the dictionary
 * @param managedObjectContext          The NSManagedObjectContext where the fetch or instantiation is performed
 *
 * @note    managedObjectKeyPathsArray and dictionaryKeyPathsArray should have the same size
 *          each keypath of the NSManagedObject in managedObjectKeyPathsArray will be updated with the same index of the value from dictionaryKeyPathsArray
 *
 * @return an instantiated NSManagedObject updated with the given dictionary
 */
+(NSManagedObject *)managedObjectForEntityClass:(Class)entityClass
                                predicateFormat:(NSString *)predicateFormat
                          managedObjectKeyPaths:(NSArray *)managedObjectKeyPathsArray
                                 withDictionary:(NSDictionary *)dictionary
                           dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray
                         inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/**
 * Fetch all NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
 *
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where the instantiation is performed
 *
 * @return an NSArray of NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
 */
+(NSArray *)managedObjectsArrayForEntityClass:(Class)entityClass
                              predicateFormat:(NSString *)predicateFormat
                       inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/**
 * Fetch all NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
 *
 * @param entityClass            The class of the entity to fetch
 * @param predicateFormat        The predicate to fulfill
 * @param managedObjectContext   The NSManagedObjectContext where the instantiation is performed
 *
 * @return an NSArray of NSManagedObjects fulfilling the predicate from the given NSManagedObjectContext
 */
+(NSArray *)managedObjectsArrayForEntityName:(NSString *)entityName
                             predicateFormat:(NSString *)predicateFormat
                      inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;



/**
 * Update an NSManagedObject with the given dictionary
 *
 * @param managedObject     The NSManagedObject to update
 * @param dictionary        The dictionary that will update the NSManagedObject
 */
+(void)updateManagedObject:(NSManagedObject *)managedObject withDictionary:(NSDictionary *)dictionary;

/**
 * Delete all NSManagedObjects from the given class and fulfilling the given predicate and not present in managedObjectsArray
 *
 * @param managedObjectsArray   The array of NSManagedObjects to keep
 * @param entityClass           The class of the entity to fetch
 * @param predicateFormat       The predicate format to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectsArray
                        forEntityClass:(Class)entityClass
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Delete all NSManagedObjects from the given name and fulfilling the given predicate and not present in managedObjectsArray
 *
 * @param managedObjectsArray   The array of NSManagedObjects to keep
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate format to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 */
+(void)deleteManagedObjectsNotInArray:(NSArray *)managedObjectsArray
                        forEntityName:(NSString *)entityName
                      predicateFormat:(NSString *)predicateFormat
               inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
/**
 * Delete all NSManagedObjects from the given class and fulfilling the given predicate and not present in managedObjectsArray
 *
 * @param managedObjectsArray   The array of NSManagedObjects to keep
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate format to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 */
+(void)deleteManagedObjectsForEntityClass:(Class )entityClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Delete all NSManagedObjects from the given name and fulfilling the given predicate and not present in managedObjectsArray
 *
 * @param managedObjectsArray   The array of NSManagedObjects to keep
 * @param entityName            The name of the entity to fetch
 * @param predicateFormat       The predicate format to fulfill
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 */
+(void)deleteManagedObjectsForEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given name
 *
 * @param entityName            The name of the entity to fetch
 * @param delegate              The delegate of the NSFetchedResultsController
 * @param predicateFormat       The predicate format to fulfill
 * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 *
 * @return an NSFetchedResultsController for the given managedObjectContext
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entityName
                                                            delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                     predicateFormat:(NSString *)predicateFormat
                                                     sortDescriptors:(NSArray *)sortDescriptors
                                                  sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath
                                                managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 * Instantiate and return an NSFetchedResultsController for an entity with the given class
 *
 * @param entityClass           The class of the entity to fetch
 * @param delegate              The delegate of the NSFetchedResultsController
 * @param predicateFormat       The predicate format to fulfill
 * @param sortDescriptors       The array of descriptors for the NSFetchedResultsController
 * @param sectionNameKeyPath    The sectionNameKeyPath of the NSFetchedResultsController
 * @param managedObjectContext  The NSManagedObjectContext where NSManagedObjects are deleted
 *
 * @return an NSFetchedResultsController for the given managedObjectContext
 */
+(NSFetchedResultsController *)fetchedResultsControllerForEntityClass:(Class)entityClass
                                                             delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                                      predicateFormat:(NSString *)predicateFormat
                                                      sortDescriptors:(NSArray *)sortDescriptors
                                                   sectionNameKeyPath:(NSString *)sectionsectionNameKeyPath
                                                 managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
