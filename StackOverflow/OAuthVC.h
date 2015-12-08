//
//  OAuthVC.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/7/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OAuthWebViewControllerCompletion)();

@interface OAuthVC : UIViewController

@property (copy, nonatomic) OAuthWebViewControllerCompletion completion;

@end
