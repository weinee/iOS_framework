//
//  WNPhotoPicker.h
//  HongTu
//
//  Created by weineeL on 16/6/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WNPhotoPicker;

@protocol WNPhotoPickerDelegate <NSObject>

-(void)wnphotoPicker:(WNPhotoPicker *)picker didCropFinished:(UIImage *) image;

@end

@interface WNPhotoPicker : NSObject

@property (nonatomic, weak) id<WNPhotoPickerDelegate> delegate;

-(instancetype)initWithController:(UIViewController *)controller andDelegate:(id)delegate;

/** 开始选择*/
-(void)showAction;

@end
