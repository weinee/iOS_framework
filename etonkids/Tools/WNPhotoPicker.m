//
//  WNPhotoPicker.m
//  HongTu
//
//  Created by weineeL on 16/6/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "WNPhotoPicker.h"
#import "VPImageCropperViewController.h"
@interface WNPhotoPicker ()<VPImageCropperDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, weak) UIViewController *rootController;

@end

@implementation WNPhotoPicker

- (instancetype)initWithController:(UIViewController *)controller andDelegate:(id <WNPhotoPickerDelegate>)delegate
{
	self = [super init];
	if (self) {
		self.rootController = controller;
		self.delegate = delegate;
	}
	return self;
}


#pragma mark camera utility
- (BOOL) isCameraAvailable{
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
	return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
	return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
	return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
	return [UIImagePickerController isSourceTypeAvailable:
					UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
	return [self
					cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
	return [self
					cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
	__block BOOL result = NO;
	if ([paramMediaType length] == 0) {
		return NO;
	}
	NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
	[availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
		NSString *mediaType = (NSString *)obj;
		if ([mediaType isEqualToString:paramMediaType]){
			result = YES;
			*stop= YES;
		}
	}];
	return result;
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
	[cropperViewController dismissViewControllerAnimated:NO completion:^{
		// 调用代理
		if (self.delegate && [self.delegate respondsToSelector:@selector(wnphotoPicker:didCropFinished:)]) {
			[self.delegate wnphotoPicker:self didCropFinished:editedImage];
		}
	}];
}

-(void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
	[cropperViewController dismissViewControllerAnimated:YES completion:^{
		
	}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//显示裁剪界面
	[picker dismissViewControllerAnimated:NO  completion:^() {
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
		
		UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
		portraitImg = [self imageByScalingToMaxSize:portraitImg];
		// 裁剪
		CGRect cropFrame = CGRectMake(0, 64.0f, kScreenWidth, kScreenWidth);
		VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:cropFrame limitScaleRatio:3.0];
		imgEditorVC.delegate = self;
		[self.rootController presentViewController:imgEditorVC animated:YES completion:^{
			[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
			// Nothing
		}];
	}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:^(){
		[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
	}];
}

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
	if (sourceImage.size.width < kScreenWidth) return sourceImage;
	CGFloat btWidth = 0.0f;
	CGFloat btHeight = 0.0f;
	if (sourceImage.size.width > sourceImage.size.height) {
		btHeight = kScreenWidth;
		btWidth = sourceImage.size.width * (kScreenWidth / sourceImage.size.height);
	} else {
		btWidth = kScreenWidth;
		btHeight = sourceImage.size.height * (kScreenWidth / sourceImage.size.width);
	}
	CGSize targetSize = CGSizeMake(btWidth, btHeight);
	return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
			{
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor; // scale to fit height
		else
			scaleFactor = heightFactor; // scale to fit width
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		if (widthFactor > heightFactor)
    {
	thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
		else
			if (widthFactor < heightFactor)
					{
				thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
					}
			}
	UIGraphicsBeginImageContext(targetSize); // this will crop
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	if(newImage == nil) DDLogWarn(@"could not scale image");
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	return newImage;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (buttonIndex) {
		case 0:
			[self takePicture];
			break;
		case 1:
			[self choosePicture];
			break;
		default:
			break;
	}
}

-(void)takePicture{
	if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
		UIImagePickerController *controller = [[UIImagePickerController alloc] init];
		controller.sourceType = UIImagePickerControllerSourceTypeCamera;
		
		if ([self isRearCameraAvailable]) {
			controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
		}
		NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
		[mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
		controller.mediaTypes = mediaTypes;
		controller.delegate = self;
		[self.rootController presentViewController:controller
											 animated:YES
										 completion:^(void){
											 NSLog(@"Picker View Controller is presented");
										 }];
	}
}

-(void)choosePicture{
	// 从相册中选取
	if ([self isPhotoLibraryAvailable]) {
		UIImagePickerController *controller = [[UIImagePickerController alloc] init];
		controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
		[mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
		controller.mediaTypes = mediaTypes;
		controller.delegate = self;
		[self.rootController presentViewController:controller
											 animated:YES
										 completion:^(void){
											 NSLog(@"Picker View Controller is presented");
										 }];
	}
}

#pragma mark export method
-(void)showAction{
	UIActionSheet *actionSheet =  [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相册", nil];
	[actionSheet showInView:self.rootController.view];
}

@end
