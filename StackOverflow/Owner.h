//
//  Owner.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Owner : NSObject

@property int userId;
@property NSString *profileURL;
@property NSString *displayName;
@property NSString *linkURL;

-(id)initWithUserId:(int)userId profileURL:(NSString *)profileURL displayName:(NSString *)displayName linkURL:(NSString *)linkURL;

@end
