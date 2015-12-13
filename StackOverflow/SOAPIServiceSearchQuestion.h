//
//  SOSearchQuestion.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Completions.h"


typedef enum {
    Activity,
    Votes,
    Creation,
    Relevance
} Sort ;

typedef enum {
    Desc,
    Asc
} Order;

@interface SOAPIServiceSearchQuestion : NSObject

+ (void)searchQuestionWithTerm:(NSString *)searchTerm pageNumber:(int)pageNumber withCompletion:(kNSArrayCompletionHandler)completion;
+ (void)getUserWithCompletion:(kOwnerCompletionHandler)completion;

@end
