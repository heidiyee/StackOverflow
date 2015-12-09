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

@interface SearchQuestionsVC () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchQuestions;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SearchQuestionsVC

-  (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchQuestions.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text) {
        [SOAPIServiceSearchQuestion searchQuestionWithTerm:searchBar.text pageNumber:1 withCompletion:^(NSArray * _Nullable data, NSError * _Nullable error) {
            self.dataSource = data;
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Question *question = self.dataSource[indexPath.row];
    cell.textLabel.text = question.title;
    
    return cell;
}


@end
