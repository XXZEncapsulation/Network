//
//  Network.m
//  NetDemo
//
//  Created by Jiayu_Zachary on 15/11/16.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "Network.h"

@implementation Network {
    Reachability *_baiduReach;
}

+ (instancetype)net:(id)obj {
    static Network *_netWork = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _netWork = [[Network alloc] init];
    });
    
    _netWork.delegate = obj;
    
    return _netWork;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initReachability];
    }
    return self;
}

//初始化网络
- (void)initReachability {
    _baiduReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [_baiduReach startNotifier];
    
    //注册监听网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

//返回网络类型
- (NetworkStatus)netType {
    //网络状态
    NetworkStatus status = _baiduReach.currentReachabilityStatus;
    
    switch (status) {
        case NotReachable:
            //无网络
            break;
        case ReachableViaWiFi:
            //WIFI
            break;
        case ReachableViaWWAN:
            //蜂窝
            break;
            
        default:
            break;
    }
    return status;
}

//监听网络的变化
-(void)reachabilityChanged:(NSNotification*)note {
    Reachability * reach = [note object];
    NSInteger status = reach.currentReachabilityStatus;
    
    if([reach isReachable]){//有网络
        status = 1;
//        NSLog(@"来网了..");
    }else{//无网络
        status = 0;
//        NSLog(@"网走了..");
    }
    
    if ([_delegate respondsToSelector:@selector(netChanged:)]) {
        [_delegate netChanged:status];
    }
}

@end
