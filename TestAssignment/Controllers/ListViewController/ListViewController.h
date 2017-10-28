//
//  ListViewController.h
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHelperClass.h"
#import "UtilityClass.h"
#import "ListViewCell.h"
#import "CoreDataGlobalClass.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ListViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblList;
@property (strong, nonatomic) NSMutableArray *arrTableData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
