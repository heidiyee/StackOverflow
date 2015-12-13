//
//  OAuthVC.m
//  StackOverflow
//
//  Created by Heidi Yee on 12/7/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "OAuthVC.h"

@import WebKit;

NSString const *kClientId = @"6107";
NSString const *kBaseURL = @"https://stackexchange.com/oauth/dialog?";
NSString const *kRedirectURL = @"https://stackexchange.com/oauth/login_success";


@interface OAuthVC () <WKNavigationDelegate>

@property(strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

- (void)setupWebView {
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    
    NSString *urlString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@", kBaseURL,kClientId, kRedirectURL];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURLRequest *request = navigationAction.request;
    NSURL *requestURL = request.URL;
    
    if([requestURL.description containsString:@"access_token"]){
        NSArray *urlComponents = [[requestURL description] componentsSeparatedByString:@"="];
        NSArray *accessTokenComponents = [[urlComponents[1] description] componentsSeparatedByString:@"&"] ;
        NSString *accessToken = accessTokenComponents.firstObject;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:accessToken forKey:@"accessToken"];
        [userDefaults synchronize];
        
        if (self.completion) {
            self.completion();
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
