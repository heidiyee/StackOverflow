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

NSString const *kSearchBaseURL = @"https://api.stackexchange.com/2.2/";
NSString const *kAppKey = @"bqQqQljl0na46Y8DYUQJCQ((";

@implementation SOAPIServiceSearchQuestion

+ (void)searchQuestionWithTerm:(NSString *)searchTerm pageNumber:(int)pageNumber withCompletion:(kNSArrayCompletionHandler)completion {
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@search?", kSearchBaseURL];
    NSString *pageNumberString;

    
    if (pageNumber > 0) {
        pageNumberString = [NSString stringWithFormat:@"%d", pageNumber];
    } else {
        pageNumberString = [NSString stringWithFormat:@"%d", 1];
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:pageNumberString forKey:@"page"];
    [parameters setObject:searchTerm forKey:@"intitle"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:@"write_access" forKey:@"scope"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSOperationQueue *managerOPQueue = manager.operationQueue;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [managerOPQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [managerOPQueue setSuspended:YES];
                UIViewController *topVC = [[UIApplication sharedApplication].windows firstObject].rootViewController;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connection ERROR" message:@"You gots not internetz Bu" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [topVC presentViewController:alert animated:true completion:nil];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSData *data = (NSData*)responseObject;
        result = [JSONParser questionsArrayFromData:data];
        completion(result,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

+ (void)getUserWithCompletion:(kOwnerCompletionHandler)completion {
    NSString *urlString = [NSString stringWithFormat:@"%@me?", kSearchBaseURL];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[defaults stringForKey:@"accessToken"] forKey:@"access_token"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:@"desc" forKey:@"order"];
    [parameters setObject:@"reputation" forKey:@"sort"];
    [parameters setObject:kAppKey forKey:@"key"];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"Got data");
        Owner *owner = [[Owner alloc]init];
        NSData *data = (NSData*)responseObject;
        owner = [JSONParser ownerFromData:data];
        completion(owner,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"failed");
        completion(nil, error);
    }];
}

@end
