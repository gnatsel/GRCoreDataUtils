//
//  User.h
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 28/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSSet *receivedMessages;
@property (nonatomic, retain) NSSet *sentMessages;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addReceivedMessagesObject:(Message *)value;
- (void)removeReceivedMessagesObject:(Message *)value;
- (void)addReceivedMessages:(NSSet *)values;
- (void)removeReceivedMessages:(NSSet *)values;

- (void)addSentMessagesObject:(Message *)value;
- (void)removeSentMessagesObject:(Message *)value;
- (void)addSentMessages:(NSSet *)values;
- (void)removeSentMessages:(NSSet *)values;

@end
