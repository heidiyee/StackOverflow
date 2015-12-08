//
//  MenuVC.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/7/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ContainerVC.h"
#import "BurgerMenuVC.h"
#import "SearchQuestionsVC.h"
#import "MyQuestionsVC.h"

CGFloat const kBurgerButtonWidth = 50;
CGFloat const kburgerButtonHeight = 50;
NSTimeInterval const ktimeToSlideMenuOpen = 0.2;

@interface ContainerVC () <UITableViewDelegate>

@property (strong, nonatomic) BurgerMenuVC *burgerMenuVC;
@property (strong, nonatomic) SearchQuestionsVC *mainContentVC;
@property (strong, nonatomic) MyQuestionsVC *myQuestionsVC;
@property (strong, nonatomic) NSArray *viewControllerArray;
@property (strong, nonatomic) UIButton *burgerButton;

@end

@implementation ContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllVC];
    [self setupBurgerButton];
}

- (void)setupAllVC {
    [self setupBurgerMenu];
    [self setupMainVC];
    [self setupOtherVC];
    
    self.viewControllerArray = @[self.mainContentVC, self.myQuestionsVC];
}

- (void)setupBurgerMenu {
    self.burgerMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BurgerMenuVC"];
    self.burgerMenuVC.tableView.delegate = self;
    [self.parentViewController addChildViewController:self.burgerMenuVC];
    
    self.burgerMenuVC.view.frame = self.view.frame;
    [self.view addSubview:self.burgerMenuVC.view];
    
    [self.burgerMenuVC didMoveToParentViewController:self];
}

- (void)setupMainVC {
    self.mainContentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsVC"];
    [self.parentViewController addChildViewController:self.mainContentVC];
    
    self.mainContentVC.view.frame = self.view.frame;
    [self.view addSubview:self.mainContentVC.view];
    
    [self.mainContentVC didMoveToParentViewController:self];
}

- (void)setupOtherVC {
    self.myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsVC"];
}

- (void)setupBurgerButton {
    self.burgerButton = [[UIButton alloc]initWithFrame:(CGRectMake(0, 10, kBurgerButtonWidth, kburgerButtonHeight))];
    [self.burgerButton setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    [self.mainContentVC.view addSubview:self.burgerButton];
    [self.burgerButton addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)burgerButtonPressed:(UIButton *)sender {
    NSLog(@"button pressed");
    [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        self.mainContentVC.view.center = CGPointMake(self.view.center.x * 2.0, self.view.center.y);
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.mainContentVC.view addGestureRecognizer:tap];
        sender.userInteractionEnabled = false;
    }];
}

- (void)tapToCloseMenu:(UIButton *)sender {
    [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        self.mainContentVC.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    } completion:^(BOOL finished) {
        self.burgerButton.userInteractionEnabled = true;
    }];
}



@end
