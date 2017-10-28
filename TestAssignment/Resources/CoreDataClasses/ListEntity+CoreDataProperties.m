//
//  ListEntity+CoreDataProperties.m
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//
//

#import "ListEntity+CoreDataProperties.h"

@implementation ListEntity (CoreDataProperties)

+ (NSFetchRequest<ListEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ListEntity"];
}

@dynamic title;
@dynamic url;
@dynamic thumbnailUrl;
@dynamic id;
@dynamic albumId;

@end
