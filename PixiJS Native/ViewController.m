//
//  ViewController.m
//  PixiJS Native
//
//  Created by koala on 22/12/2016.
//  Copyright © 2016 dualface. All rights reserved.
//

#import "ViewController.h"
#import "WebKit/WebKit.h"
#import "GCDWebServer/Core/GCDWebServer.h"

#define LOCAL_PORT 29033

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    id basedir = [NSString stringWithFormat:@"%@/src",
                  [[NSBundle mainBundle] resourcePath]];

    GCDWebServer* webServer = [[GCDWebServer alloc] init];
    [webServer addGETHandlerForBasePath:@"/"
                          directoryPath:basedir
                          indexFilename:@"index.html"
                               cacheAge:0
                     allowRangeRequests:YES];
    //DEBUG = 0
    //VERBOSE = 1
    //INFO = 2
    //WARNING = 3
    //ERROR = 4
    [GCDWebServer setLogLevel:0];
    id options = [NSMutableDictionary dictionary];
    [options setObject:[NSNumber numberWithInteger:LOCAL_PORT]
                forKey:GCDWebServerOption_Port];
    [options setObject:[NSNumber numberWithBool:YES]
                forKey:GCDWebServerOption_BindToLocalhost];
    [webServer startWithOptions:options error:nil];

    id urlStr = [NSString stringWithFormat:@"http://127.0.0.1:%d/", LOCAL_PORT];
    id url = [NSURL URLWithString:urlStr];
    id request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
