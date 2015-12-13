//
//  ProfileVC.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/10/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ProfileVC.h"
#import "Owner.h"
#import "SOAPIServiceSearchQuestion.h"

@interface ProfileVC ()

@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) Owner *owner;

@end

@implementation ProfileVC

- (void)setOwner:(Owner *)owner{
    _owner = owner;
    
    self.ownerNameLabel.text = owner.displayName;
    if (owner.profileURL) {
        dispatch_queue_t downloadQ = dispatch_queue_create("downloadQ", NULL);
        dispatch_async(downloadQ, ^{
            
            NSData *data = [NSData dataWithContentsOfURL:owner.profileURL options: NSDataReadingUncached error:nil];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ownerImageView.image = image;
            });
            
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupOwner];
}

- (void)setupOwner {
    [SOAPIServiceSearchQuestion getUserWithCompletion:^(Owner * _Nullable owner, NSError * _Nullable error) {
        if (error == nil) {
            self.owner = owner;
        }
    }];
}



@end
