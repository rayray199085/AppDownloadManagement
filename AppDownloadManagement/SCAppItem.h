//
//  SCAppItem.h
//  AppDownloadManagement
//
//  Created by Stephen Cao on 12/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCAppItem : NSObject
@property(nonatomic,copy)NSString* size;
@property(nonatomic,copy)NSString* download;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* icon;
@property(nonatomic,assign,getter = isDisable)BOOL disable;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)appItemWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
