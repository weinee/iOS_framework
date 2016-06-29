//
//  QRCodeGenerator.h
//  HongTu
//
//  Created by liucong on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeGenerator : NSObject
- (UIImage *)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRString:(NSString *)qrString;
@end
