//
//  JSONParser.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "JSONParser.h"
#import "Owner.h"
#import "Question.h"

@implementation JSONParser

+ (NSMutableArray *)questionsArrayFromData:(NSData *)data {
    
    NSMutableArray *result = [[NSMutableArray<Question *> alloc] init];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
       NSDictionary *rootObject = (NSDictionary *) data;
    
    
        if (rootObject) {
            NSMutableArray *items = rootObject[@"items"];
            if (items) {
                for (NSDictionary *item in items) {
                    Owner *owner;
                    NSDictionary *ownerDictionary = item[@"owner"];
                    if (ownerDictionary) {
                        NSString *displayName = ownerDictionary[@"display_name"];
                        NSString *linkURL = ownerDictionary[@"link"];
                        int userId = (int) ownerDictionary[@"user_id"];
                        
                        NSString *urlString = ownerDictionary[@"profile_image"];
                        NSURL *profileURL = [[NSURL alloc]initWithString:urlString];

                        owner = [[Owner alloc]initWithUserId:userId profileURL:profileURL displayName:displayName linkURL:linkURL];
                    }
                    
                    NSString *title = item[@"title"];
                    NSString *questionID = item[@"question_id"];
                    NSString *questionLink = item[@"link"];
                    int viewCount = (int) item[@"view_count"];
                    BOOL isAnswered = (BOOL) item[@"is_answered"];
                    NSDate *dateCreated = item[@"creation_date"];
                    
                    Question *question = [[Question alloc]initWithViewCount:viewCount dateCreated:dateCreated questionId:questionID questionLink:questionLink questionIsAnswered:&isAnswered owner:owner title:title];
                    
                    if (question) {
                        [result addObject:question];
                    }
                }
            }
            
            if (result != nil) {
                return result;
            }
        }
    }
    
    return nil;
}

+ (Owner *)ownerFromData:(NSData *)data {
    
    Owner *result = [[Owner alloc] init];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *rootObject = (NSDictionary *) data;
        
        
        if (rootObject) {
            NSMutableArray *items = rootObject[@"items"];
            if (items) {
                for (NSDictionary *item in items) {
                    
                    NSString *displayName = item[@"display_name"];
                    NSString *linkURL = item[@"link"];
                    int userId = (int) item[@"user_id"];
                    
                    NSString *urlString = item[@"profile_image"];
                    NSURL *profileURL = [[NSURL alloc]initWithString:urlString];
                    NSLog(@"%@", profileURL);
                    
                    result = [[Owner alloc]initWithUserId:userId profileURL:profileURL displayName:displayName linkURL:linkURL];
                    
                }
            }
            
            if (result != nil) {
                return result;
            }
        }
    }
    
    return nil;
}


@end
