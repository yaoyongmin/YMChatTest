//
//  JJDecoderViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/12.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <ZBarReaderController.h>

@interface JJDecoderViewController : BaseViewController<AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,AVCaptureMetadataOutputObjectsDelegate,ZBarReaderDelegate>

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, assign) BOOL isScanning;

@property (nonatomic,copy)void(^ScanResult)(NSString*result,BOOL isSucceed);/**< 返回扫码结果*/
//初始化函数
-(id)initWithBlock:(void(^)(NSString*,BOOL))a;


@end
