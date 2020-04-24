//
//  ZZYPhotoHelper.m
//  OC_FunctionDemo
//
//  Created by 周智勇 on 16/9/9.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "ZZYPhotoHelper.h"
#import <AVKit/AVKit.h>

@interface ZZYPhotoDelegateHelper: NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) ZZYPhotoHelperBlock selectImageBlock;

@end

@interface ZZYPhotoHelper ()
@property (nonatomic, strong) ZZYPhotoDelegateHelper *helper;

@end

static ZZYPhotoHelper *picker = nil;
@implementation ZZYPhotoHelper


+ (instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[ZZYPhotoHelper alloc] init];
    });
    return picker;
}

- (void)showImageViewSelcteWithResultBlock:(ZZYPhotoHelperBlock)selectImageBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * library = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self creatWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary block:selectImageBlock];
    }];
    UIAlertAction * carmare = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self creatWithSourceType:UIImagePickerControllerSourceTypeCamera block:selectImageBlock];
        }else{
            //            [MBProgressHUD showError:@"相机功能暂不能使用"];
        }
    }];
    [alertController addAction:canleAction];
    [alertController addAction:library];
    [alertController addAction:carmare];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (void)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType block:selectImageBlock{
    picker.helper                  = [[ZZYPhotoDelegateHelper alloc] init];
    picker.delegate                = picker.helper;
    picker.sourceType              = sourceType;
    picker.allowsEditing = NO;//默认是可以修改的
    
    picker.helper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}


- (void)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType ResultBlock:(ZZYPhotoHelperBlock)selectImageBlock{
    picker.helper                  = [[ZZYPhotoDelegateHelper alloc] init];
    picker.delegate                = picker.helper;
    picker.sourceType              = sourceType;
    picker.allowsEditing           = NO;//默认是可以修改的
    //媒体类型多媒体格式（声音和视频）/照片
    picker.mediaTypes              = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    //设置录制的最大时长，默认是10分钟
    picker.videoMaximumDuration    = 10;
    //设置录像的质量
    picker.videoQuality            = UIImagePickerControllerQualityType640x480;
    picker.helper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}


@end


@implementation ZZYPhotoDelegateHelper

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //判断资源是照片还是视频
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *theImage = nil;
        // 判断，图片是否允许修改。默认是可以的
        if ([picker allowsEditing]){
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        if (_selectImageBlock) {
            _selectImageBlock(theImage,(NSString *)kUTTypeImage);
        }
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        
        //文件管理器
        NSFileManager* fm = [NSFileManager defaultManager];
        
        //创建视频的存放路径
        NSString * path = [NSString stringWithFormat:@"%@/tmp/video%.0f.mp4", NSHomeDirectory(), [NSDate timeIntervalSinceReferenceDate] * 1000];
        NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
        
        
        //通过文件管理器将视频存放的创建的路径中
        [fm copyItemAtURL:[info objectForKey:UIImagePickerControllerMediaURL] toURL:mergeFileURL error:nil];
        
//        AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
//
//        //根据AVURLAsset得出视频的时长
//        CMTime   time = [asset duration];
//        int seconds = ceil(time.value/time.timescale);
//        NSString *videoTime = [NSString stringWithFormat:@"%d",seconds];
//
        if (_selectImageBlock) {
            _selectImageBlock(path,(NSString *)kUTTypeMovie);
        }
    }else{
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
