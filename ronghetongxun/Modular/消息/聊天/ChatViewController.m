//
//  ChatViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatViewController.h"
#import "BaseChatCell.h"
#import "ChatInfoLeftCell.h"
#import "ChatInfoRightCell.h"
#import "ChatImageLeftCell.h"
#import "ChatImageRightCell.h"
#import "ChatVideoLeftCell.h"
#import "ChatVideoRightCell.h"
#import "ChatTimeCell.h"
#import "ChatVoiceLeftCell.h"
#import "ChatVoiceRightCell.h"

#import "ChatEmojiView.h"
#import "YMAlertView.h"

#import "UIColor+YM.h"
#import "NSDate+Extend.h"
#import "UIView+Extension.h"

#import "ChatMoreView.h"
#import "ZZYPhotoHelper.h"
#import "ICMessageHelper.h"
#import "ICRecordManager.h"

#import "ICPhotoBrowserController.h"
#import "GroupChatInfoVC.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,ChatEmojiDelegate,ChatMoreViewDelegate,BaseChatCellDelegate,YMAlertViewDelegate>
{
    NSMutableArray *_dataArray;
    NSArray *_types;
    BOOL _keyBoardIsShow;
    
    UIMenuItem * _copyMenuItem;
    UIMenuItem * _deleteMenuItem;
    UIMenuItem * _forwardMenuItem;
    UIMenuItem * _addScheduleMenuItem;
    UIMenuItem * _recallMenuItem;
    NSIndexPath *_longIndexPath;
}


@property (weak, nonatomic) IBOutlet UITextView *textView;

///暂未需求自适应高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightLayout;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *emojiBtn;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) UITapGestureRecognizer *textViewTapGes;

@property (strong, nonatomic) ChatEmojiView *emojiView;
@property (strong, nonatomic) ChatMoreView *moreView;
@property (strong, nonatomic) YMAlertView *alertView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"#F7F8F9"];
    self.title = self.group.gName;
    
    self.group.unReadCount = 0;
    
    [self setTableViewConfig];
    
    [self setChatRightItem];
    
    [self.textView addGestureRecognizer:self.textViewTapGes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark 导航栏右侧按钮
- (void)setChatRightItem{
    [self setNavigationItem:@"设置" imageName:@"" position:itemRight addTarget:self action:@selector(rightItemClickAction)];
}
- (void)rightItemClickAction{
    
    switch (self.group.gType) {
        case ICGroup_MULTI:
        {
            [self.navigationController pushViewController:[[GroupChatInfoVC alloc]init] animated:YES];
        }
            break;
        case ICGroup_DOUBLE:
            
            break;
        default:
            break;
    }
}

///切换语音模式
- (IBAction)voiceAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.isSelected) {
        
        self.textView.text          = @"按住说话";
        self.textView.textAlignment = NSTextAlignmentCenter;
        
        [self.textView resignFirstResponder];
        [self.textView addGestureRecognizer:self.longPress];
    }else{
        [self.textView removeGestureRecognizer:self.longPress];
        self.textView.text          = @"";
        self.textView.textAlignment = NSTextAlignmentLeft;
    }
}

///切换表情键盘
- (IBAction)emojiAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.voiceBtn.isSelected) {
        self.voiceBtn.selected      = NO;
        [self.textView removeGestureRecognizer:self.longPress];
        self.textView.text          = @"";
        self.textView.textAlignment = NSTextAlignmentLeft;
    }
    
    if (_keyBoardIsShow && self.textView.inputView == self.emojiView) {
        [self.textView resignFirstResponder];
    }
    
    if (self.textView.inputView != self.emojiView) {
        self.textView.inputView = self.emojiView;
        self.textView.tintColor = [UIColor clearColor];
        [self.textView reloadInputViews];
        if (!_keyBoardIsShow) {
            [self.textView becomeFirstResponder];
        }
    }else{
        if (!_keyBoardIsShow) {
            self.textView.tintColor = [UIColor clearColor];
            [self.textView becomeFirstResponder];
        }
    }
}

///弹出更多功能视图
- (IBAction)moreAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.textView resignFirstResponder];
    
    [self.moreView show];
}

- (void)textViewTapPressGestureAction:(UITapGestureRecognizer *)ges{
    
    if (self.textView.inputView == self.emojiView) {
        self.textView.inputView = nil;
        [self.textView reloadInputViews];
        self.textView.tintColor = [UIColor blackColor];
    }
    [self.textView becomeFirstResponder];
    NSLog(@"单击！");
}
///长按输入框操作
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始时录音！");
        
        [[ICRecordManager shareManager] startRecordingWithFileName:@"chatVoice" completion:^(NSError *error) {
            
        }];
        
    }
    if (longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"录音结束发送录音消息！");
        
        [[ICRecordManager shareManager] stopRecordingWithCompletion:^(NSString *recordPath) {
            
            NSLog(@"录制完成后的路径：%@",recordPath);
            
            ///现在测试数据 所有录音占用同一个路径  所以会造成录音数据覆盖 数据一致的情况
            ///后续对接后台接口逻辑    发送语音文件到后台服务器 服务器返回语音文件url  存储 播放
            
            ///录制完成上传 需要转码 amr上传服务器  适配安卓 容量小
            
            ICMessage *voiceMsg = [ICMessageHelper createVoiceMessagevoicePath:recordPath from:@"test" to:self.group.gId isSender:YES];
            
            [self.dataSource addObject:voiceMsg];
            [self.tableView reloadData];
            [self setTableViewPositionAtBottom];
            [self messageSendSucced:voiceMsg];
        }];
    }
}

//键盘即将出现
- (void)keyboardDidShow:(NSNotification *)notification{
    _keyBoardIsShow = YES;
}
//键盘即将消失
- (void)keyboardDidHide:(NSNotification *)notification{
    _keyBoardIsShow = NO;
}

#pragma mark textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.voiceBtn.isSelected) {
        return NO;
    }else{
        return YES;
    }
}

///判断输入的字是否是回车，即按下return
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        
        if (textView.text.length >0) {
            
            ICMessage *msgRight = [ICMessageHelper createMessageModel:TypeText
                                                              content:textView.text path:nil
                                                                 from:@"ts"
                                                                   to:self.group.gId
                                                              fileKey:nil
                                                             isSender:YES];
            [self.dataSource addObject:msgRight];
            [self.tableView reloadData];
            [self setTableViewPositionAtBottom];
            [self messageSendSucced:msgRight];
        }
        textView.text = @"";
        return YES;
    }
    return YES;
}

#pragma mark 点击表情键盘发送按钮事件
- (void)ChatEmojiViewClickSendButtonAction{
    [self.textView resignFirstResponder];
    if (self.textView.text.length >0) {
        ICMessage *msgRight = [ICMessageHelper createMessageModel:TypeText
                                                          content:self.textView.text
                                                             path:nil
                                                             from:@"ts"
                                                               to:self.group.gId
                                                          fileKey:nil
                                                         isSender:YES];
        ICMessage *msgDate = [ICMessageHelper createDateMessageModel:TypeMessageDate
                                                                date:[NSDate stringWithFormat:[NSDate ymdHmsFormat]]
                                                                from:@"system"
                                                                  to:self.group.gId];
        [self.dataSource addObject:msgRight];
        [self.dataSource addObject:msgDate];
        [self.tableView reloadData];
        [self setTableViewPositionAtBottom];
        [self messageSendSucced:msgRight];
    }
    self.textView.text = @"";
}

///模拟网络请求 延迟一秒后  改变发送的消息状态
- (void)messageSendSucced:(ICMessage *)message{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        message.deliveryState = ICMessageDeliveryState_Delivered;
        [self.tableView reloadData];
        
        [self receiveMessageSuccen:message];
    });
}

///模拟对方收到消息回复消息，收到消息
- (void)receiveMessageSuccen:(ICMessage *)message{
    
    NSString *messageContent = [NSString stringWithFormat:@"已收到%@的消息！",message.from];
    
    ICMessage *msgLeft = [ICMessageHelper createMessageModel:TypeText
                                                     content:messageContent
                                                        path:nil
                                                        from:@"马云"
                                                          to:self.group.gId
                                                     fileKey:nil
                                                    isSender:NO];
    [self.dataSource addObject:msgLeft];
    [self.tableView reloadData];
    [self setTableViewPositionAtBottom];
}

#pragma mark config
- (void)setTableViewPositionAtBottom{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        if (self->_dataArray.count>0) {
    //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    //            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    //        }
    //    });
}

#pragma mark ChatEmojiViewDelegate
- (void)ChatEmojiView:(nonnull ChatEmojiView *)emojiView didSelectEmojiItemAtText:(nonnull NSString *)emojiText {
    
    self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,emojiText];
}

#pragma mark - baseCell delegate
- (void)longPress:(UILongPressGestureRecognizer *)longRecognizer{
    
    if (longRecognizer.state    == UIGestureRecognizerStateBegan) {
        CGPoint location        = [longRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath  = [self.tableView indexPathForRowAtPoint:location];
        _longIndexPath          = indexPath;
        id object               = [self.dataSource objectAtIndex:indexPath.row];
        if (![object isKindOfClass:[ICMessage class]]) return;
        BaseChatCell *cell      = [self.tableView cellForRowAtIndexPath:indexPath];
        [self showMenuViewController:cell andIndexPath:indexPath message:cell.messageModel];
    }
}

///显示menu视图
- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath message:(ICMessage *)messageModel
{
    if (_copyMenuItem   == nil) {
        _copyMenuItem   = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMessage:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMessage:)];
    }
    if (_forwardMenuItem == nil) {
        _forwardMenuItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(forwardMessage:)];
    }
    if (_addScheduleMenuItem == nil) {
        _addScheduleMenuItem = [[UIMenuItem alloc] initWithTitle:@"添加到日程" action:@selector(addScheduleAction:)];
    }
    if (_recallMenuItem == nil) {
        _recallMenuItem = [[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(recallMessage:)];
    }
    if (messageModel.isSender) {
        
        [[UIMenuController sharedMenuController] setMenuItems:@[_copyMenuItem,_deleteMenuItem,_forwardMenuItem,_recallMenuItem,_addScheduleMenuItem]];
        
    } else {
        [[UIMenuController sharedMenuController] setMenuItems:@[_copyMenuItem,_deleteMenuItem,_forwardMenuItem,_addScheduleMenuItem]];
    }
    
    BaseChatCell *cell = (BaseChatCell *)showInView;
    ///获取cell内容视图实际frame
    UIView *cellSubView = [cell getContentView];
    
    CGRect rect = CGRectMake(cellSubView.x, cell.y, cellSubView.width, cell.height);
    [[UIMenuController sharedMenuController] setTargetRect:rect inView:showInView.superview ];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

#pragma mark MenuViewController点击事件
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)addScheduleAction:(UIMenuItem *)copyMenuItem{
    
    NSLog(@"添加到日程!");
}
- (void)copyMessage:(UIMenuItem *)copyMenuItem
{
    UIPasteboard *pasteboard  = [UIPasteboard generalPasteboard];
    ICMessage * message       = [self.dataSource objectAtIndex:_longIndexPath.row];
    pasteboard.string         = message.content;
    
    NSLog(@"复制的内容：%@",pasteboard.string);
}

- (void)recallMessage:(UIMenuItem *)recallMuneItem{
    [self.alertView show];
}

- (void)YMAlertView:(YMAlertView *)alertView didSelectRowAtSEL:(SEL)action{
    
    YMPerformSelectorMacro(self, NSStringFromSelector(action));
}

- (void)recallAction{
    [self.alertView dismiss];
    
    NSLog(@"撤回!");
}

- (void)deleteMessage:(UIMenuItem *)deleteMenuItem{
    // 这里还应该把本地的消息附件删除
    ICMessage * message = [self.dataSource objectAtIndex:_longIndexPath.row];
    [self statusChanged:message];
}
- (void)forwardMessage:(UIMenuItem *)forwardItem
{
    NSLog(@"需要用到的数据库，等添加了数据库再做转发...");
}

- (void)statusChanged:(ICMessage *)message
{
    [self.dataSource removeObject:message];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[_longIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

/**
 * 响应者链事件
 * 例如点击图片、录音、视频
 * @param eventName 事件名称
 * @param userInfo 传递的数据
 */
#pragma mark 查看图片 播放视频 播放录音
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    if ([eventName isEqualToString:YMRouterEventVideoTapEventName]) {
        
        NSLog(@"播放视频！");
        
        NSString *webVideoPath = userInfo[@"videoPath"];
        NSURL *webVideoUrl = [NSURL fileURLWithPath:webVideoPath];
        
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
        
        AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
        avPlayerVC.player = avPlayer;
        
        [self presentViewController:avPlayerVC animated:YES completion:nil];
    }
    
    if ([eventName isEqualToString:YMRouterEventImageTapEventName]) {
        
        ICMessage *msg = (ICMessage *)userInfo[@"msgModel"];
        
        ICPhotoBrowserController *photoVC = [[ICPhotoBrowserController alloc] initWithImage:msg.image];
        //        photoVC.transitioningDelegate     = self;
        photoVC.modalPresentationStyle    = UIModalPresentationCustom;
        [self presentViewController:photoVC animated:YES completion:nil];
    }
    
    if ([eventName isEqualToString:YMRouterEventVoiceTapEventName]) {
        
        ///如果 录音正在播放  则停止 再播放当前点击的录音
        
        ///播放如果是接收到的消息  需要转为wav格式 播放 iOS4.3以后不在支持 amr
        ///安卓 amr  可以直接录制播放
        
        NSString *voicePath = userInfo[@"voicePath"];
        
        NSLog(@"播放的录音路径%@",voicePath);
        
        [[ICRecordManager shareManager] startPlayRecorder:voicePath];
    }
    NSLog(@"%@",userInfo);
}

#pragma mark ChatMoreViewDelegate
- (void)ChatMoreView:(ChatMoreView *)moreView didSelectRowAtIndex:(NSInteger)index{
    
    switch (index) {
        case 1:{
            [self.moreView dismiss];
            [[ZZYPhotoHelper shareHelper] creatWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) ResultBlock:^(id data, NSString *mediaType) {
                ICMessage *msgRight;
                if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
                    
                    msgRight = [ICMessageHelper createImageMessageModel:TypeImage
                                                                  image:(UIImage *)data
                                                                   from:@"ts"
                                                                     to:self.group.gId
                                                               isSender:YES];
                }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
                    
                    msgRight = [ICMessageHelper createVideoMessageModel:TypeVideo
                                                           videoUrlPath:(NSString *)data
                                                                   from:@"ts"
                                                                     to:self.group.gId
                                                               isSender:YES];
                };
                [self.dataSource addObject:msgRight];
                [self.tableView reloadData];
                [self setTableViewPositionAtBottom];
                [self messageSendSucced:msgRight];
            }];
        }
            break;
        case 2:{
            [self.moreView dismiss];
            [[ZZYPhotoHelper shareHelper] creatWithSourceType:(UIImagePickerControllerSourceTypeCamera) ResultBlock:^(id data, NSString *mediaType) {
                ICMessage *msgRight;
                if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
                    
                    msgRight = [ICMessageHelper createImageMessageModel:TypeImage
                                                                  image:(UIImage *)data
                                                                   from:@"ts"
                                                                     to:self.group.gId
                                                               isSender:YES];
                }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
                    
                    msgRight = [ICMessageHelper createVideoMessageModel:TypeVideo
                                                           videoUrlPath:(NSString *)data
                                                                   from:@"ts"
                                                                     to:self.group.gId
                                                               isSender:YES];
                };
                [self.dataSource addObject:msgRight];
                [self.tableView reloadData];
                [self setTableViewPositionAtBottom];
                [self messageSendSucced:msgRight];
            }];
        }
            break;
        case 3:{
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"10086"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ICMessage *msgModel            = self.dataSource[indexPath.row];
    
    BaseChatCell *cell             = [tableView dequeueReusableCellWithIdentifier:msgModel.type forIndexPath:indexPath];
    cell.longPressDelegate         = self;
    cell.messageModel              = msgModel;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

#pragma mark 注册cell
- (void)setTableViewConfig{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatInfoLeftCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_left",TypeText]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatInfoRightCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_right",TypeText]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatImageLeftCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_left",TypeImage]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatImageRightCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_right",TypeImage]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatVideoLeftCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_left",TypeVideo]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatVideoRightCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_right",TypeVideo]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatTimeCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@",TypeMessageDate]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatVoiceLeftCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_left",TypeVoice]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatVoiceRightCell class]) bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_right",TypeVoice]];
}

- (NSArray <YMAlertModel *>*)getPhoneAlertData{
    NSMutableArray <YMAlertModel *> *listArray = [NSMutableArray array];
    YMAlertModel *model = [YMAlertModel new];
    model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    model.itemTitleColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    [model setAction:@selector(recallAction)];
    [model setValuesForKeysWithDictionary:@{@"content":@"确定"}];
    [listArray addObject:model];
    return listArray;
}

#pragma mark lazy
- (UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    }
    return _longPress;
}
- (UITapGestureRecognizer *)textViewTapGes{
    
    if (!_textViewTapGes) {
        _textViewTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapPressGestureAction:)];
    }
    return _textViewTapGes;
}

- (ChatEmojiView *)emojiView{
    if (!_emojiView) {
        _emojiView = [[ChatEmojiView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 300)];
        _emojiView.backgroundColor = [UIColor whiteColor];
        _emojiView.delegate = self;
    }
    return _emojiView;
}
- (ChatMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[ChatMoreView alloc] init];
        _moreView.delegate = self;
    }
    return _moreView;
}

- (YMAlertView *)alertView{
    if (!_alertView) {
        _alertView = [YMAlertView alertControllerWithTitle:@"是否撤回该条消息？" dataList:[self getPhoneAlertData]];
        _alertView.delegate = self;
    }
    return _alertView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
