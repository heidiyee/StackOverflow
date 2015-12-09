//
//  Owner.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "Owner.h"

@implementation Owner

-(id)initWithUserId:(int)userId profileURL:(NSURL *)profileURL displayName:(NSString *)displayName linkURL:(NSString *)linkURL {
    
    if (self = [super init])
    {
        // Initializselation code here
        [self setDisplayName:displayName];
        [self setProfileURL:profileURL];
        [self setLinkURL:linkURL];
        [self setUserId:userId];
        
    }
    return self;
}

@end
