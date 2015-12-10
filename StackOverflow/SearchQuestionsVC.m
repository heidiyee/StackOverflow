//
//  SearchQuestionsVC.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/7/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "SearchQuestionsVC.h"
#import "SOAPIServiceSearchQuestion.h"
#import "Question.h"
#import "CustomTableViewCell.h"

NSString const *kRegexPattern = @" ";

@interface SearchQuestionsVC () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchQuestions;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSString *urlString;


@end

@implementation SearchQuestionsVC

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchQuestions.delegate = self;
    [self setupTableView];

}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 75;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *cell = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"CustomTableViewCell"];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text) {
        
        NSString *encodedStringURL = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSLog(@"%@", encodedStringURL);
        
        [SOAPIServiceSearchQuestion searchQuestionWithTerm:encodedStringURL pageNumber:1 withCompletion:^(NSArray * _Nullable data, NSError * _Nullable error) {
            if (error != nil) {
                self.dataSource = data;
            }
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];
     cell.question = self.dataSource[indexPath.row];
    
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 75;
//}


@end
