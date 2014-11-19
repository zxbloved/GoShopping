//
//  GOTool.m
//  GoShopping
//
//  Created by stevenzxb on 14/11/18.
//  Copyright (c) 2014年 MAN. All rights reserved.
//

#import "GOTool.h"

@implementation GOTool


+ (id) requestDatatWithContentsOfURL:(NSString*)url{              ///一开始获得的字符串先不转码，按特定的字段才转码
    
    id obj = nil;
    
    @try {
        NSLog(@"%@",url);
        NSString *res = [GOTool stringWithContentsOfURL:url];
        NSLog(@"res= %@",res);
        SBJsonParser *parser=[[SBJsonParser alloc]init];  ///add by Hydra 2013/06/03
        NSError *error=nil;
        obj=[parser objectWithString:res error:&error];
        if(error!=nil)
        {
            NSLog(@"%@",error);
        }
        if(obj!=nil)
        {
            obj=[GOTool EncodingSpecifiedData:obj];
        }
        NSLog(@"%@",obj);
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSDictionary *dicResult=(NSDictionary*)obj;
    if(dicResult!=nil)
    {
        
    }
    
    return obj;
}

+(id)EncodingSpecifiedData:(id)object
{
    NSMutableDictionary *dic=(NSMutableDictionary*)object;
    NSString *errmsg=[dic objectForKey:@"errmsg"];              ///错误信息
    if(errmsg!=nil && ![errmsg isEqualToString:@""])
    {
        errmsg=[errmsg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dic setObject:errmsg forKey:@"errmsg"];
    }
    id obj=(id)dic;
    return obj;
}

+ (NSString*) stringWithContentsOfURL:(NSString*)url{       /////
    
    return [GOTool stringWithContentsOfURL:url timeoutInterval:6 usedEncoding:NSUTF8StringEncoding error:NULL];
}

+ (NSString*) stringWithContentsOfURL:(NSString*)url timeoutInterval:(NSTimeInterval)intval usedEncoding:(NSStringEncoding)enc error:(NSError**)err{
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:intval];
    [request addValue:[GOTool userAgentString] forHTTPHeaderField:@"User-Agent"];
    [request addValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
	NSURLResponse *response = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:err];
	NSString *str = [[NSString alloc] initWithData:data encoding:enc];
	
	if (str == nil) {
		str = @"";
	}
	
	return str;
}

+ (NSString*) userAgentString{
    
    static NSString *s=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIDevice *dev = [UIDevice currentDevice];
        NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
        NSString *name = [dic objectForKey:@"CFBundleName"];
        if (name == nil) {
            name = @"";
        }
        NSString *version = [dic objectForKey:@"CFBundleVersion"];
        if (version == nil) {
            version = @"";
        }
        
        s = [NSString stringWithFormat:@"(%@;%@) (%@;%@;%@)", name, version, dev.model, dev.systemName, dev.systemVersion];
        
    });
    
    return s;
}


@end
