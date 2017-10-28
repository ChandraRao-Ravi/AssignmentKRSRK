//
//  ListViewCell.h
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBig;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSmall;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
