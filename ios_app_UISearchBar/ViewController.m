//
//  ViewController.m
//  ios_app_UISearchBar
//
//  Created by kris on 15/9/19.
//  Copyright (c) 2015年 kris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UISearchBar * _searchBar;
    NSArray* _tableData;
    NSArray*  _searchData;
    BOOL _isSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isSearch = NO;
    _tableData = @[@"小甲乖乖",@"小乙乖乖",@"小乙乖2乖",@"小乙乖3乖",@"小乙乖4乖",@"小乙乖5乖",@"da乙乖乖",@"大乙乖乖2"];
    self.table.delegate =self;
    self.table.dataSource=self;
    _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.table.bounds.size.width,44 )];
    _searchBar.placeholder = @"请输入字符";
    _searchBar.showsCancelButton = YES;
    self.table.tableHeaderView = _searchBar;
    _searchBar.delegate = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isSearch){
        return _searchData.count;
    }else{
        return _tableData.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId=@"cellId";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger rowNo = indexPath.row;
    
    if (_isSearch) {
        cell.textLabel.text = _searchData[rowNo];
    }
    else
    {
        cell.textLabel.text = _tableData[rowNo];
    }
    return cell;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isSearch = NO;
    [self.table reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //执行搜索
    [self filterBySubstring:searchBar.text];
    //放弃作为第一响应者，关闭键盘
    [searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterBySubstring:searchText];
    
}
//自定义方法
//-(void) filterBySubstring:(NSString*) subStr
//{
//    _isSearch = YES;
//    //定义搜索谓词                                           SELF CONTAINS[c]
//    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELE CONTAINS[c] %@",subStr];
//    //使用谓词过滤NSArray
//    _searchData = [_tableData filteredArrayUsingPredicate:pred];
//    [self.table reloadData];
//}
- (void) filterBySubstring:(NSString*) subStr
{
    // 设置为搜索状态
    _isSearch = YES;
    // 定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"SELF CONTAINS[c] %@" , subStr];
    // 使用谓词过滤NSArray
    _searchData = [_tableData filteredArrayUsingPredicate:pred];
    // 让表格控件重新加载数据
    [self.table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
