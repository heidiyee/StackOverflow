//
//  SOSearchQuestion.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "SOAPIServiceSearchQuestion.h"
#import "AFNetworking.h"
#import "JSONParser.h"

NSString const *kSearchBaseURL = @"https://api.stackexchange.com/2.2/search?";

@implementation SOAPIServiceSearchQuestion

+ (void)searchQuestionWithTerm:(NSString *)searchTerm pageNumber:(int)pageNumber withCompletion:(kNSArrayCompletionHandler)completion {
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@page=%d&intitle=%@&site=stackoverflow", kSearchBaseURL,pageNumber, searchTerm];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSData *data = (NSData*)responseObject;
        result = [JSONParser questionsArrayFromData:data];
        completion(result,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
