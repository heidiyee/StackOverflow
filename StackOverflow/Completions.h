//
//  Header.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

@import UIKit;

typedef void (^kNSDataCompletionHandler)(NSData * _Nullable data , NSError  * _Nullable  error);

typedef void (^kNSDictionaryCompletionHandler)(NSDictionary * _Nullable data , NSError  * _Nullable  error);

typedef void (^kNSArrayCompletionHandler)(NSArray * _Nullable data , NSError  * _Nullable  error);

typedef void (^kNSImageCompletionHandler)(UIImage * _Nullable data , NSError  * _Nullable  error);
