//
//  ViewController.m
//  TestView
//
//  Created by zhz on 22/11/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ystaticweb.eryufm.cn/ypp-helps/detail.html?id=50"]];
    [webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
