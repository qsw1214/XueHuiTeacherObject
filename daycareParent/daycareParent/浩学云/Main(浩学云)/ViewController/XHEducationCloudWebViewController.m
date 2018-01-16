//
//  XHEducationCloudWebViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/26.
//  Copyright © 2017年 XueHui. All rights reserved.
//




#import "XHEducationCloudWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "Pingpp.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface XHEducationCloudWebViewController () <WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate,AMapLocationManagerDelegate,NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) NSData *charge;
@property (nonatomic, copy) WVJBResponseCallback callBackResult;
@property (nonatomic,strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation XHEducationCloudWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self clearWebCache];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 2)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

-(void)dealloc
{
    NSLog(@"观察者销毁了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.webView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackResult:) name:@"callBack" object:nil];
        
    }
}

//-(void)setEducationCloudObject:(XHEducationCloudFrame*)objet;
//{
//    switch (objet.model.modelType)
//    {
//        case XHEducationCloudCellVideoTpe:
//        {
//            //NSString *webUrl=[objet.model.redirectUrl encoding];
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:objet.model.redirectUrl]]];
//            [self registBridge:_webView];
//        }
//            break;
//        case XHEducationCloudCellExaminationQuestionsTpe:
//        {
//             NSString *webUrl=[objet.model.redirectUrl encoding];
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
//            [self registBridge:_webView];
//        }
//            break;
//        default:
//            break;
//    }
//    
//}


-(void)setWebViewUrl:(NSString*)url
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self registBridge:_webView];
}


#pragma mark - Getter / Setter
-(UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView sizeToFit];
        _webView.scalesPageToFit=YES;
    }
    return _webView;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

-(void)registBridge:(UIWebView *)webView
{
    if (_bridge)
    {
        return;
        
    }
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    //注册定位，等待JS调取
    [_bridge registerHandler:@"usLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self startLocation:responseCallback];
    }];
    //注册ping++，购买商品调起支付
    [_bridge registerHandler:@"getPay" handler:^(id data, WVJBResponseCallback responseCallback) {
        _charge = data;
        //        _callBackResult = nil;
        _callBackResult = responseCallback;
        [self regiseterPay:responseCallback];
    }];
    
}
- (void)startLocation:(WVJBResponseCallback)responseCallback
{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //    [AMapServices sharedServices].apiKey = @"2c7804fec1be502acdb64d97a7afa387";
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    // 带逆地理（返回坐标和地址信息）
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"获取位置信息失败,请检查你的定位服务是否打开!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        if (regeocode)
        {
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.POIName];
            NSDictionary *dict =@{@"lng":@(location.coordinate.longitude),@"lat":@(location.coordinate.latitude),@"address":address};
            responseCallback(dict);
        }
    }];
    
}
//调起ping++支付
- (void)regiseterPay:(WVJBResponseCallback)responseCallback
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_charge options:NSJSONWritingPrettyPrinted error:nil];
    NSString* data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [Pingpp createPayment:data
           viewController:self
             appURLScheme:@"wxedbbf780e30b9bb5"
           withCompletion:^(NSString *result, PingppError *error)
     {
         if (error == nil) {
             NSLog(@"PingppError is nil");
         } else {
             NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
         }
         responseCallback(result);
     }];
}
- (void)callBackResult:(NSNotification *)result
{
    NSString *objects = [result object];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:objects,@"result", nil];
    if (_callBackResult == nil) {
        // [XHShowHUD showNOHud:@"应用信息异常"];
        return;
    }
    _callBackResult(dic);
    if ([objects isEqualToString:@"success"]) {
        [XHShowHUD showNOHud:@"支付成功"];
        [self.webView goBack];
        return;
    }
    if ([objects isEqualToString:@"cancel"]) {
        [XHShowHUD showNOHud:@"支付取消"];
        return;
    }
    else  {
        [XHShowHUD showNOHud:@"支付失败"];
        return;
    }
    
}

-(void)letfItemAction:(BaseNavigationControlItem *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)clearWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes
        
        = [NSSet setWithArray:@[
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                //WKWebsiteDataTypeLocalStorage,
                                
                                //WKWebsiteDataTypeCookies,
                                
                                //WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSError *errors;
        
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [XHShowHUD showNOHud:@"加载失败！"];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
     [XHShowHUD showNOHud:@"加载失败！"];
}
@end
