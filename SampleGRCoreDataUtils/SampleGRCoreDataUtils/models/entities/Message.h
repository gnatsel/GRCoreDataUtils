//
//  Message.h
//  SampleGRCoreDataUtils
//
//  Created by Gnatsel Reivilo on 27/05/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * messageId;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) User *receiverUser;
@property (nonatomic, retain) User *senderUser;

@end
