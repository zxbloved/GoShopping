//
//  GOTool.h
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"


@interface GOTool : NSObject

+ (id) requestDatatWithContentsOfURL:(NSString*)url;

+ (NSString*) stringWithContentsOfURL:(NSString*)url;

+(id)EncodingSpecifiedData:(id)object;

+ (NSString*) stringWithContentsOfURL:(NSString*)url timeoutInterval:(NSTimeInterval)intval usedEncoding:(NSStringEncoding)enc error:(NSError**)err;

+ (NSString*) userAgentString;

@end
