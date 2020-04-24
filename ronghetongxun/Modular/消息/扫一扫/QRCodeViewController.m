//
//  QRCodeViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "QRCodeViewController.h"
#import <ZBarSDK/ZBarSDK.h>

#import <Masonry.h>
@interface QRCodeViewController ()<ZBarReaderDelegate,ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    ZBarReaderView *_readview;
    UIImagePickerController *_picker;
}
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self configuredZBarReader];
    
}
/**
 *初始化扫描二维码对象ZBarReaderView
 *@param 设置扫描二维码视图的窗口布局、参数
 */
-(void)configuredZBarReader{
    //初始化照相机窗口
    _readview = [[ZBarReaderView alloc] init];
    //设置扫描代理
    _readview.readerDelegate = self;
    //关闭闪光灯
    _readview.torchMode = 0;
    //显示帧率
    _readview.showsFPS = NO;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:_readview];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _readview.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    //Layout ZBarReaderView
    __weak __typeof(self) weakSelf = self;
    [_readview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
    }];
      
    //初始化扫描二维码视图的子控件
    [self configuredZBarReaderMaskView];
      
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    [_readview start];
//    [_qrRectView startScan];
}
/**
 *自定义扫描二维码视图样式
 *@param 初始化扫描二维码视图的子控件
 */
- (void)configuredZBarReaderMaskView{

}

- (void)buttonClicked:(UIButton *)sender{
//    switch (sender.tag) {
//        case LIGHTBUTTONTAG://照明按钮
//        {
//            if(0 != _readview.torchMode){
//                //关闭闪光灯
//                _readview.torchMode = 0;
//            }else if (0 == _readview.torchMode){
//                //打开闪光灯
//                _readview.torchMode = 1;
//            }
//
//        }
//            break;
//        case IMPORTBUTTONTAG://导入二维码图片
//        {
//            [self presentImagePickerController];
//        }
//            break;
//
//        default:
//            break;
//    }
}
  
/**
 *打开二维码扫描视图ZBarReaderView
 *@param 关闭闪光灯
 */
- (void)setZBarReaderViewStart{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview start];//开始扫描二维码
}
  
/**
 *关闭二维码扫描视图ZBarReaderView
 *@param 关闭闪光灯
 */
- (void)setZBarReaderViewStop{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview stop];//关闭扫描二维码
}
  
//弹出系统相册、相机
-(void)presentImagePickerController{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker = [[UIImagePickerController alloc] init];
    _picker.sourceType               = sourceType;
    _picker.allowsEditing            = YES;
    //    NSArray *temp_MediaTypes        = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    //    picker.mediaTypes               = temp_MediaTypes;
    _picker.delegate                 = self;
      
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_picker.view];
    [_picker.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.size.equalTo(window);
    }];
}
  
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //收起相册
    [picker.view removeFromSuperview];
}
#pragma mark -
#pragma mark ZBarReaderViewDelegate
//扫描二维码的时候，识别成功会进入此方法，读取二维码内容
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{
    //停止扫描
    [self setZBarReaderViewStop];
      
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    NSString *urlStr = symbol.data;
      
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
          
        return;
    }
      
    NSLog(@"urlStr: %@",urlStr);
      
    //二维码扫描成功，弹窗提示
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描成功" message:[NSString stringWithFormat:@"二维码内容:\n%@",urlStr] preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self) weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //继续扫描
        [weakSelf setZBarReaderViewStart];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:^{
          
    }];
      
}
  
#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//导入二维码的时候会进入此方法，处理选中的相片获取二维码内容
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //停止扫描
    [self setZBarReaderViewStop];
      
    //处理选中的相片,获得二维码里面的内容
    ZBarReaderController *reader = [[ZBarReaderController alloc] init];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGImageRef cgimage = image.CGImage;
    ZBarSymbol *symbol = nil;
    for(symbol in [reader scanImage:cgimage])
        break;
    NSString *urlStr = symbol.data;
      
    [picker.view removeFromSuperview];
      
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
  
        return;
    }
      
    NSLog(@"urlStr: %@",urlStr);
      
    //二维码扫描成功，弹窗提示
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描成功" message:[NSString stringWithFormat:@"二维码内容:\n%@",urlStr] preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self) weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //继续扫描
        [weakSelf setZBarReaderViewStart];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
}

@end
