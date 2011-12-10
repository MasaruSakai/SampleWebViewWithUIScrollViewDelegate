//
//  ViewController.h
//  SampleWebViewWithUIScrollViewDelegate
//
//  Created by Masaru Sakai on 11/12/10.
//  Copyright (c) 2011年 Masaru Sakai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>
{
    __unsafe_unretained IBOutlet UIWebView *_webView;
    __unsafe_unretained UIScrollView *_subScrollView;
}
@property (unsafe_unretained, nonatomic) UIWebView *webView;
@property (unsafe_unretained, nonatomic) UIScrollView *subScrollView;
@end
