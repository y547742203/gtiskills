//
//  Common.h
//  LF
//
//  Created by Tang yuhua on 15/4/24.
//  Copyright (c) 2015年 Laifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomIOSAlertView.h"
//#import "LabelTextfieldCell.h"
//#import "ButtonTextfieldTableViewCell.h"
#import "AFNetworking.h"

//#import "DataStore.h"
#define GreenColor [UIColor colorWithRed:35/255.0 green:150/255.0 blue:56/255.0 alpha:1]

@interface Common : NSObject

+ (instancetype)shared;

-(void)showAlert :(NSString *) title;
- (NSString *)md5:(NSString *)str;
- (void) alert:(NSString *) title;

@end

