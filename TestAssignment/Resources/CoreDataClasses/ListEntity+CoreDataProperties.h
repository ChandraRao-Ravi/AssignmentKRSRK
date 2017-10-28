//
//  ListEntity+CoreDataProperties.h
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//
//

#import "ListEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListEntity (CoreDataProperties)

+ (NSFetchRequest<ListEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *thumbnailUrl;
@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *albumId;

@end

NS_ASSUME_NONNULL_END
