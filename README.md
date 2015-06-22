GRCoreDataUtils
===============

A simple and easy to use utility class to retrieve (via NSFetchedResultsController), insert, update and delete data using CoreData

How To Use
----------

## GRCoreDataUtils

* I do not recommend using directly the methods from GRCoreDataUtils.
  Use instead the category GRCoreDataUtils+AppDelegate.h contained in SampleGRCoreDaUtils project and extends GRCoreDataUtils to a DAO class (see UserDAO.h in SampleGRCoreDataUtils) *

### Entity used for sample code
 
```objective-c
// User.h
@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * userId;
@end

...

// UserDAO.h
#import "GRCoreDataUtils+AppDelegate.h"

@class User;
@interface UserDAO : GRCoreDataUtils

+(void)deleteUser:(User *)user;
+(User *)userUpdatedWithDictionary:(NSDictionary *)dictionary;
+(User *)userUpdatedWithKeyPaths:(NSArray *)keyPathsArray
                  withDictionary:(NSDictionary *)dictionary
             dictionaryKeyPaths:(NSArray *)dictionaryKeyPathsArray;
+(NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
@end

```

### Insert and/or update data

```objective-c

// UserDAO.m
#import "UserDAO.h"

...

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
```

### Delete data
```objective-c
// UserDAO.m
+(void)deleteUser:(User *)user{
    [GRCoreDataUtils deleteManagedObject:user];
}
```

### Get FetchedResultsController

```objective-c
+(NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate{
    return [GRCoreDataUtils fetchedResultsControllerForEntityClass:[User class]
                                                          delegate:delegate
                                                   sortDescriptors:@[
                                                                     [[NSSortDescriptor alloc]initWithKey:@"firstname" ascending:YES],
                                                                     [[NSSortDescriptor alloc]initWithKey:@"lastname" ascending:YES]
                                                                     ]];
}
```

Installation
------------

### Dependencies

This project requires the CoreData framework added to your Xcode project


### Integration

Currently, there are two ways to use GRCoreDataUtils :
- downloading the repository and dragging the h and m files GRCoreDataUtils (and if you want, the category GRCoreDataUtils+AppDelegate)
- adding the repository as a submodule of your project and dragging the same files.

* This project will be available in the future on CocoaPods *

## License
The MIT License (MIT)

Copyright (c) 2015 gnatsel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.