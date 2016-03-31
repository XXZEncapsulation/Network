//
//  Network.h
//  NetDemo
//
//  Created by Jiayu_Zachary on 15/11/16.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol NetworkDeleagte <NSObject>

@required
/*!监听网络,  >0 有网络, 否则无网络*/
//或者直接用通知
- (void)netChanged:(NetworkStatus)status;

@end

@interface Network : NSObject

+ (instancetype)net:(id)obj;

@property (nonatomic, weak) id<NetworkDeleagte>delegate;

/*!返回网络类型*/
- (NetworkStatus)netType;

@end
