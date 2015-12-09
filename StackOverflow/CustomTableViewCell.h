//
//  TableViewCell.h
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "Owner.h"

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ownerImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) Question *question;


@end
