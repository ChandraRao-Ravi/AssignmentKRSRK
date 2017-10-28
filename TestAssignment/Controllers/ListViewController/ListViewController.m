//
//  ListViewController.m
//  TestAssignment
//
//  Created by Chandra Rao on 27/10/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activityIndicator startAnimating];
    self.tblList.estimatedRowHeight = 117.0f;
    [self callWebService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Webservice Methods

- (void)callWebService {
    
    if ([UtilityClass isConnectedToInternet]) {
        [[APIHelperClass sharedSingleton] callGetApiWithMethod:@"photos" successHandler:^(NSDictionary *dictData) {
            
            if ([[dictData valueForKey:@"ListItems"] isKindOfClass:[NSArray class]] && [[dictData valueForKey:@"ListItems"] count] > 0) {
                self.arrTableData = [[NSMutableArray alloc]init];
                self.arrTableData = [[dictData valueForKey:@"ListItems"] mutableCopy];
                [self.tblList reloadData];
                
                [self performSelector:@selector(saveData) withObject:nil afterDelay:2.0];
                
            }
            [self.activityIndicator stopAnimating];
            
        } failureHandler:^(NSString *strMessage) {
            AppLog(strMessage);
            [self.activityIndicator stopAnimating];
        }];
    } else {
        [self.tblList reloadData];
        [self.activityIndicator stopAnimating];
    }
    
}

#pragma mark - Other Methods

- (void)saveData {
    [CoreDataGlobalClass saveListFromJson:self.arrTableData];
}

#pragma mark - UItableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.arrTableData.count > 0) {
        return self.arrTableData.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"ListViewCell";
    
    NSDictionary *dictListItem = [self.arrTableData objectAtIndex:indexPath.row];
    
    ListViewCell *cell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblTitle.text = [dictListItem objectForKey:@"title"];
    
    if (![dictListItem isKindOfClass:[NSNull class]]) {
        if (![[dictListItem objectForKey:@"url"] isKindOfClass:[NSNull class]]) {
            NSString *strImageURL = [NSString stringWithFormat:@"%@",[dictListItem objectForKey:@"url"]];
            [cell.imgViewBig sd_setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageRefreshCached];
        } else {
            cell.imgViewBig.image = [UIImage imageNamed:@"placeHolder"];
        }
    }
    
    if (![dictListItem isKindOfClass:[NSNull class]]) {
        if (![[dictListItem objectForKey:@"thumbnailUrl"] isKindOfClass:[NSNull class]]) {
            NSString *strImageURL = [NSString stringWithFormat:@"%@",[dictListItem objectForKey:@"thumbnailUrl"]];
            [cell.imgViewSmall sd_setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageRefreshCached];
        } else {
            cell.imgViewSmall.image = [UIImage imageNamed:@"placeHolder"];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
