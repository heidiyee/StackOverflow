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
#import "QuartzCore/QuartzCore.h"
#import "ProfileVC.h"

CGFloat const kBurgerButtonWidth = 50;
CGFloat const kburgerButtonHeight = 50;
NSTimeInterval const ktimeToSlideMenuOpen = 0.2;
CGFloat const kBurgerSlideOpenRange = 2.0;
CGFloat const kburgerOpenScreenMultiplier = 3.0;


@interface ContainerVC () <UITableViewDelegate>

@property (strong, nonatomic) BurgerMenuVC *burgerMenuVC;
@property (strong, nonatomic) SearchQuestionsVC *searchQuestionsVC;
@property (strong, nonatomic) MyQuestionsVC *myQuestionsVC;
@property (strong, nonatomic) ProfileVC *profileVC;
@property (strong, nonatomic) UIViewController *mainContentVC;
@property (strong, nonatomic) NSArray *viewControllerArray;
@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation ContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllVC];
    [self setupBurgerButton];
    [self setupPanGesture];
}

- (void)setupAllVC {
    [self setupBurgerMenu];
    [self setupMainVC];
    [self setupOtherVC];
    
    self.viewControllerArray = @[self.searchQuestionsVC, self.myQuestionsVC, self.profileVC];
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
    self.searchQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsVC"];
    self.mainContentVC = self.searchQuestionsVC;
    [self.parentViewController addChildViewController:self.mainContentVC];
    
    self.mainContentVC.view.frame = self.view.frame;
    [self.view addSubview:self.mainContentVC.view];
    
    [self.mainContentVC didMoveToParentViewController:self];
}

- (void)setupOtherVC {
    self.myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
    self.profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
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
        self.mainContentVC.view.center = CGPointMake(self.view.center.x * kBurgerSlideOpenRange, self.view.center.y);
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


-(void)switchToViewController:(UIViewController *)viewController{
    [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        
        self.mainContentVC.view.frame = CGRectMake(self.view.frame.size.width,self.mainContentVC.view.frame.origin.y,self.mainContentVC.view.frame.size.width, self.mainContentVC.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        CGRect oldFrame = self.mainContentVC.view.frame;
        [self.mainContentVC willMoveToParentViewController:nil];
        [self.mainContentVC.view removeFromSuperview];
        [self.mainContentVC removeFromParentViewController];
        
        self.mainContentVC = viewController;
        [self addChildViewController:viewController];
        viewController.view.frame = oldFrame;
        [self.view addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];

        [self.burgerButton removeFromSuperview];
        [viewController.view addSubview:self.burgerButton];
        viewController.view.alpha = 1.0;
        
        [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
            viewController.view.center = self.view.center;
        } completion:^(BOOL finished) {
            self.burgerButton.userInteractionEnabled = true;
            self.view.alpha = 1.0;
            [self setupPanGesture];
        }];
    }];
}

#pragma mark - Pan Gesture Setup
- (void)setupPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainVCPanned:)];
    [self.mainContentVC.view addGestureRecognizer:pan];
    self.panGesture = pan;
}

- (void)mainVCPanned:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.mainContentVC.view];
    CGPoint translation = [sender translationInView:self.mainContentVC.view];
//    NSLog(@"%@", NSStringFromCGPoint(velocity));
//    NSLog(@"translation: %@", NSStringFromCGPoint(translation));
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (velocity.x > 0) {
            self.mainContentVC.view.center = CGPointMake(self.mainContentVC.view.center.x + translation.x, self.mainContentVC.view.center.y);
            [sender setTranslation:CGPointZero inView:self.mainContentVC.view];
        }
        
        if (velocity.x < 0) {
            self.mainContentVC.view.center = CGPointMake(self.mainContentVC.view.center.x + translation.x, self.mainContentVC.view.center.y);
            [sender setTranslation:CGPointZero inView:self.mainContentVC.view];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.mainContentVC.view.frame.origin.x > self.mainContentVC.view.frame.size.width / kburgerOpenScreenMultiplier) {
            NSLog(@"user is opening menu");
            
            [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
                self.mainContentVC.view.center = CGPointMake(self.view.center.x * kBurgerSlideOpenRange, self.mainContentVC.view.center.y);
                self.mainContentVC.view.alpha = 0.5;
                [self showCenterViewWithShadow:YES withOffset:-2];
            
            } completion:^(BOOL finished) {
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
                [self.mainContentVC.view addGestureRecognizer:tap];
                self.burgerButton.userInteractionEnabled = false;
                
            }];
        } else {
            [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
                self.mainContentVC.view.center = CGPointMake(self.view.center.x, self.mainContentVC.view.center.y);
            } completion:^(BOOL finished) {
                self.mainContentVC.view.alpha = 1.0;
            }];
        }
    }
}

- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value) {
        [_mainContentVC.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_mainContentVC.view.layer setShadowOpacity:0.8];
        [_mainContentVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    } else {
        [_mainContentVC.view.layer setCornerRadius:0.0f];
        [_mainContentVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected Menu Item:%ld",(long)indexPath.row);
    
    UIViewController *viewController = self.viewControllerArray[indexPath.row];
    if (![viewController isEqual:self.mainContentVC]) {
        [self switchToViewController:viewController];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mainContentVC.view.frame.size.width, 55.0)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *menu = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, self.mainContentVC.view.frame.size.width, 45)];
    menu.text = [[NSString alloc]initWithFormat:@"Menu"];
    //menu.textColor = [UIColor whiteColor];
    [view addSubview:menu];
    
    return view;
}


@end
