//
//  Question.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Question : NSObject

@property int viewCount;
@property NSDate *dateCreated;
@property NSString *questionId;
@property NSString *questionLink;
@property BOOL *questionIsAnswered;
@property Owner *owner;
@property NSString *title;

-(id)initWithViewCount:(int)viewCount dateCreated:(NSDate *)dateCreated questionId:(NSString *)questionId questionLink:(NSString *)questionLink questionIsAnswered:(BOOL *)questionIsAnswered owner:(Owner *)owner title:(NSString *)title;

@end
