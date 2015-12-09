//
//  Question.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "Question.h"

@implementation Question

-(id)initWithViewCount:(int)viewCount dateCreated:(NSDate *)dateCreated questionId:(NSString *)questionId questionLink:(NSString *)questionLink questionIsAnswered:(BOOL *)questionIsAnswered owner:(Owner *)owner title:(NSString *)title{
    
    if (self = [super init])
    {
        // Initializselation code here
        [self setViewCount:viewCount];
        [self setDateCreated:dateCreated];
        [self setQuestionId:questionId];
        [self setQuestionLink:questionLink];
        [self setQuestionIsAnswered:questionIsAnswered];
        [self setOwner:owner];
        [self setTitle:title];
        
    }
    return self;
}

@end
