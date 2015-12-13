//
//  TableViewCell.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/8/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

-(void)setQuestion:(Question *)question {
    self.titleLabel.text = question.title;
    self.ownerNameLabel.text = question.owner.displayName;
    
    dispatch_queue_t downloadQ = dispatch_queue_create("downloadQ", NULL);
    dispatch_async(downloadQ, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:question.owner.profileURL options: NSDataReadingUncached error:nil];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ownerImage.image = image;
        });
        
    });

//    
//    dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
//    dispatch_sync(imageQueue, ^{
//        NSError *error;
//        NSData *data = [NSData dataWithContentsOfURL:question.owner.profileURL options: NSDataReadingUncached error:&error];
//        UIImage *userImage = [[UIImage alloc] initWithData:data];
//        self.ownerImage.image = userImage;
//    });
    
//    NSLog(@"done");
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
