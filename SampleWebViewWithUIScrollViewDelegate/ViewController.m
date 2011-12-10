//
//  ViewController.m
//  SampleWebViewWithUIScrollViewDelegate
//
//  Created by Masaru Sakai on 11/12/10.
//  Copyright (c) 2011年 Masaru Sakai. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize webView = _webView;
@synthesize subScrollView = _subScrollView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)dealloc
{
    self.subScrollView.delegate = nil;
    self.webView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIWebView内のUIScrollViewを取得
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        for (UIView *subview in [self.webView subviews]) {
            if ([[subview.class description] isEqualToString:@"UIScrollView"]) {
                self.subScrollView = (UIScrollView *)subview;
            }
        }
    }else {
        self.subScrollView = (UIScrollView *)[self.webView scrollView];
    }
    
    // UIScrollViewのDelegateにselfを設定
    self.subScrollView.delegate = self;
    
    // ページ読み込み
    NSURL *url = [NSURL URLWithString:@"http://www.google.co.jp/news/i?hl=ja&source=mog&gl=jp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)viewDidUnload
{
    self.subScrollView.delegate = nil;
    self.subScrollView = nil;
    self.webView.delegate = nil;
    self.webView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSLog(@"%s", __func__);
    return YES;
}

- (void) webViewDidStartLoad: (UIWebView *) view {
	NSLog(@"%s", __func__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)view {
	NSLog(@"%s", __func__);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	NSLog(@"%s", __func__);
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	NSLog(@"%s", __func__);
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	NSLog(@"%s", __func__);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	NSLog(@"%s", __func__);
    NSLog(@"contentOffset : %@", NSStringFromCGPoint(self.subScrollView.contentOffset));
}

// iOS4.xでは下記メソッドでuiwebviewの同一名のメソッド利用しなければ拡大縮小ができない (iOS5.xではあっても無くてもよい)
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	NSLog(@"%s", __func__);
    return [self.webView viewForZoomingInScrollView:scrollView];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
	NSLog(@"%s", __func__);
    [self.webView scrollViewWillBeginZooming:scrollView withView:view];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	NSLog(@"%s", __func__);
    [self.webView scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	NSLog(@"%s", __func__);
    [self.webView scrollViewDidZoom:scrollView];
}

@end
