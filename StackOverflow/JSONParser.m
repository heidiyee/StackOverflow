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

//@property int viewCount;
//@property NSDate *dateCreated;
//@property NSString *questionId;
//@property NSString *questionLink;
//@property BOOL *questionIsAnswered;
//@property Owner *owner;

@implementation JSONParser

+ (NSMutableArray *)questionsArrayFromData:(NSData *)data {
    
    NSMutableArray *result = [[NSMutableArray<Question *> alloc] init];
    
    NSDictionary *rootObject = (NSDictionary *) data;
    
    if (rootObject) {
        NSMutableArray *items = rootObject[@"items"];
        if (items) {
            for (NSDictionary *item in items) {
                Owner *owner;
                NSDictionary *ownerDictionary = item[@"owner"];
                if (ownerDictionary) {
                    NSString *displayName = ownerDictionary[@"display_name"];
                    NSString *profileURL = ownerDictionary[@"profile_image"];
                    NSString *linkURL = ownerDictionary[@"link"];
                    int userId = (int) ownerDictionary[@"user_id"];
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
    
    return nil;
}

@end
