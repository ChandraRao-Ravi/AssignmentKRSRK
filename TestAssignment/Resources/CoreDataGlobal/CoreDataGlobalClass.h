//
//  CoreDataGlobalClass.h
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface CoreDataGlobalClass : NSObject

+ (void)saveListFromJson:(NSArray*)aryList;
+ (NSArray *)getListingSavedFromJson;

@end
