//
//  ViewController.h
//  ios_app_UISearchBar
//
//  Created by kris on 15/9/19.
//  Copyright (c) 2015年 kris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

