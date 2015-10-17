//
//  Common.m
//  LF
//
//  Created by Tang yuhua on 15/4/24.
//  Copyright (c) 2015年 Laifu. All rights reserved.
//

#import "Common.h"

#import "UIImageView+WebCache.h"
//#import "LabelTextfieldCell.h"
//#import "ButtonTextfieldTableViewCell.h"
#import "AFNetworking.h"

#import <CommonCrypto/CommonDigest.h>

@implementation Common


+ (instancetype)shared
{
    static Common *shared;
    
    // Do I need to create a sharedStore?
    if (!shared) {
        shared = [[self alloc] initPrivate];
    }
    
    return shared;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];

    return nil;
}


#pragma mark --md5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

# pragma mark -- 警告选项
-(void)showAlert :(NSString *) title
{
    NSLog(@"显示警告");
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:title
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    [av show];
}


UIAlertView *baseAlert;
- (void) alert:(NSString *) title{
    baseAlert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [baseAlert show];
    
    // Create and add the activity indicator
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);
    [aiv startAnimating];
    [baseAlert addSubview:aiv];
    // Auto dismiss after 3 seconds
    [self performSelector:@selector(performDismiss) withObject:nil afterDelay:1.5f];
}


- (void) performDismiss
{
    [baseAlert dismissWithClickedButtonIndex:0 animated:NO];
}






@end
