//
//  JSONParser.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Completions.h"

@interface JSONParser : NSObject

+(NSMutableArray *)questionsArrayFromData:(NSData *)data;

@end
