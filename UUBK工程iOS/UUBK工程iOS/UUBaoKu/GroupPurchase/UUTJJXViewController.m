//
//  UUTJJXViewController.m
//  UUBaoKu
//
//  Created by dev2 on 2017/5/16.
//  Copyright © 2017年 loongcrown. All rights reserved.
//

#import "UUTJJXViewController.h"
#import <WebKit/WebKit.h>
#import "UUMyShareViewController.h"
#import "UULuckGroupDetailViewController.h"
#import "UUBQDetailViewController.h"
#import "UUGroupGoodsDetailViewController.h"
#import "UUShopProductDetailsViewController.h"
@interface UUTJJXViewController ()<
WKUIDelegate,
WKNavigationDelegate,
WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *webView;



@end

@implementation UUTJJXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 8.9, 15)];
    
    [leftBtn setImage:[UIImage imageNamed:@"白条返回"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem=leftItem ;
    [self setUpWebView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
//    NSString *urlStr = @"http://g2.uubaoku.com/Tuan/UUbaokuTeam/1?isapp=1";
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    self.view.backgroundColor = BACKGROUNG_COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UURED}];
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpWebView{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];
    NSString *urlStr = @"http://g2.uubaoku.com/Tuan/UUbaokuTeam/1?isapp=1";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    WKUserContentController *userCC = config.userContentController;
    [userCC addScriptMessageHandler:self name:@"back"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%@",webView.URL.absoluteString);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL];
    NSArray *components = [urlStr componentsSeparatedByString:@"|"];
    NSLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    NSLog(@"method:===%@",method);
    if ([method rangeOfString:@"EarnIntegral"].location != NSNotFound ) {
        //
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController pushViewController:[UUMyShareViewController new] animated:YES];
        //        return;
    }if ([method rangeOfString:@"EarnIntegral"].location != NSNotFound ) {
        //
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController pushViewController:[UUMyShareViewController new] animated:YES];
        //        return;
    }else if ([urlStr rangeOfString:@"pubtuan"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
        UULuckGroupDetailViewController *luckDetail = [UULuckGroupDetailViewController new];
        luckDetail.isPutuan = 1;
        luckDetail.paraStr = method;
        [self.navigationController pushViewController:luckDetail animated:YES];
    }else if ([urlStr rangeOfString:@"pdetail"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
        UULuckGroupDetailViewController *luckDetail = [UULuckGroupDetailViewController new];
        luckDetail.isPutuan = 0;
        luckDetail.paraStr = method;
        [self.navigationController pushViewController:luckDetail animated:YES];
    }else if ([urlStr rangeOfString:@"detail"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
        UUBQDetailViewController *BQDetail = [UUBQDetailViewController new];
        BQDetail.TeamID = method;
        [self.navigationController pushViewController:BQDetail animated:YES];
    }else if ([urlStr rangeOfString:@"Product/Info"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
        UUShopProductDetailsViewController *shoppingDetail = [UUShopProductDetailsViewController new];
        shoppingDetail.GoodsID = method;
        [self.navigationController pushViewController:shoppingDetail animated:YES];
    }else if ([urlStr componentsSeparatedByString:@".com"].count>1&&[[urlStr componentsSeparatedByString:@".com"][1] rangeOfString:@"/team/pay/"].location != NSNotFound){
        decisionHandler(WKNavigationActionPolicyCancel);
        [self transferParamWithUrl:[urlStr componentsSeparatedByString:@".com"][1]];
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

- (void)transferParamWithUrl:(NSString *)url{
    NSDictionary *dict = @{@"Url":url};
    [NetworkTools postReqeustWithParams:dict UrlString:@"http://api.uubaoku.com/Goods/TransferParam" successBlock:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 000000) {
            UUGroupGoodsDetailViewController *goodsDetail = [UUGroupGoodsDetailViewController new];
            goodsDetail.isSelectedGroup = [responseObject[@"data"][@"Type"]integerValue];
            goodsDetail.SKUID = responseObject[@"data"][@"SKUID"];
            [self.navigationController pushViewController:goodsDetail animated:YES];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
