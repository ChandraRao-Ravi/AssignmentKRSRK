//
//  CoreDataGlobalClass.m
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import "CoreDataGlobalClass.h"

#define NULL_NIL(_O) _O != [NSNull null] ? _O : nil
#define DICT_GET(_DICT, _KEY) NULL_NIL([_DICT objectForKey:_KEY])

#define NIL_NULL(_O) _O != nil  ? _O : [NSNull null]
#define ENTITY_FETCH(_ENTITY, _KEY) NIL_NULL([_ENTITY valueForKey:_KEY])

@implementation CoreDataGlobalClass

+ (void)saveListFromJson:(NSArray*)aryList
{
    NSManagedObjectContext *context = [[AppDelegate sharedInstance] managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityList = [NSEntityDescription entityForName:@"ListEntity" inManagedObjectContext:context];
    [fetchRequest setEntity:entityList];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSError*error = nil;
    NSArray *result = [[[AppDelegate sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (NSDictionary *dictListItem in aryList)
    {
        BOOL isAlreadyExisted = NO;
        // Create a new managed object
        for (NSManagedObject *listExisted in result)
        {
            if ([[NSString stringWithFormat:@"%d",[DICT_GET(dictListItem, @"id") intValue]] isEqualToString:[listExisted valueForKey:@"id"]])
            {
                isAlreadyExisted = YES;
                [listExisted setValue:[NSString stringWithFormat:@"%d",[DICT_GET(dictListItem, @"albumId") intValue]] forKey:@"albumId"];
                [listExisted setValue:[NSString stringWithFormat:@"%d",[DICT_GET(dictListItem, @"id") intValue]] forKey:@"id"];
                [listExisted setValue:DICT_GET(dictListItem, @"title") forKey:@"title"];
                [listExisted setValue:DICT_GET(dictListItem, @"url") forKey:@"url"];
                [listExisted setValue:DICT_GET(dictListItem, @"thumbnailUrl") forKey:@"thumbnailUrl"];
               
                break;
            }
        }
        
        if (!isAlreadyExisted)
        {
            NSManagedObject *newListItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListEntity" inManagedObjectContext:context];
            [newListItem setValue:[NSString stringWithFormat:@"%d",[DICT_GET(dictListItem, @"albumId") intValue]] forKey:@"albumId"];
            [newListItem setValue:[NSString stringWithFormat:@"%d",[DICT_GET(dictListItem, @"id") intValue]] forKey:@"id"];
            [newListItem setValue:DICT_GET(dictListItem, @"title") forKey:@"title"];
            [newListItem setValue:DICT_GET(dictListItem, @"url") forKey:@"url"];
            [newListItem setValue:DICT_GET(dictListItem, @"thumbnailUrl") forKey:@"thumbnailUrl"];
        }
    }
    
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    } else {
        NSLog(@"Saved");
    }
}

+ (NSArray *)getListingSavedFromJson  {
    NSMutableArray *aryTypes = [[NSMutableArray alloc] init];
    NSManagedObjectContext *context = [[AppDelegate sharedInstance] managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setFetchBatchSize:20];
    NSEntityDescription *entityTypes = [NSEntityDescription entityForName:@"ListEntity" inManagedObjectContext:context];
    [fetchRequest setEntity:entityTypes];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSError*error = nil;
    NSArray *result = [[[AppDelegate sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *objTypes in result) {
        NSMutableDictionary *dictTypes = [[NSMutableDictionary alloc] init];
        [dictTypes setObject:ENTITY_FETCH(objTypes, @"albumId") forKey:@"albumId"];
        [dictTypes setObject:ENTITY_FETCH(objTypes, @"id") forKey:@"id"];
        [dictTypes setObject:ENTITY_FETCH(objTypes, @"title") forKey:@"title"];
        [dictTypes setObject:ENTITY_FETCH(objTypes, @"url") forKey:@"url"];
        [dictTypes setObject:ENTITY_FETCH(objTypes, @"thumbnailUrl") forKey:@"thumbnailUrl"];
        [aryTypes addObject:dictTypes];
    }
    return aryTypes;
}

@end
