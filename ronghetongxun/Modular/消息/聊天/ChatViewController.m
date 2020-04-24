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

#import "UIColor+YM.h"
#import "NSDate+Extend.h"
#import "UIView+Extension.h"

#import "ChatEmojiView.h"
#import "Define.h"
#import "ChatMoreView.h"
#import "ZZYPhotoHelper.h"
#import "ICMessageHelper.h"

#import "ICPhotoBrowserController.h"
#import "GroupChatInfoVC.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChatEmojiDelegate,ChatMoreViewDelegate,BaseChatCellDelegate>
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
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *emojiBtn;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) UITapGestureRecognizer *textFieldTapGes;

@property (strong, nonatomic) ChatEmojiView *emojiView;
@property (strong, nonatomic) ChatMoreView *moreView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"#F7F8F9"];
    self.title = self.group.gName;
    
    self.group.unReadCount = 0;
    
    [self setTableViewConfig];
    
    [self setChatRightItem];
    
    [self.textField addGestureRecognizer:self.textFieldTapGes];
    
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
        
        self.textField.placeholder      = @"按住说话";
        self.textField.textAlignment    = NSTextAlignmentCenter;
        self.textField.text             = @"";
        [self.textField resignFirstResponder];
        [self.textField addGestureRecognizer:self.longPress];
    }else{
        [self.textField removeGestureRecognizer:self.longPress];
        self.textField.placeholder      = @"";
        self.textField.textAlignment    = NSTextAlignmentLeft;
    }
}

///切换表情键盘
- (IBAction)emojiAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.voiceBtn.isSelected) {
        self.voiceBtn.selected = NO;
        [self.textField removeGestureRecognizer:self.longPress];
        self.textField.placeholder      = @"";
        self.textField.textAlignment    = NSTextAlignmentLeft;
    }
    
    if (_keyBoardIsShow && self.textField.inputView == self.emojiView) {
        [self.textField resignFirstResponder];
    }
    
    if (self.textField.inputView != self.emojiView) {
        self.textField.inputView = self.emojiView;
        self.textField.tintColor = [UIColor clearColor];
        [self.textField reloadInputViews];
        if (!_keyBoardIsShow) {
            [self.textField becomeFirstResponder];
        }
    }else{
        if (!_keyBoardIsShow) {
            self.textField.tintColor = [UIColor clearColor];
            [self.textField becomeFirstResponder];
        }
    }
}

///弹出更多功能视图
- (IBAction)moreAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.textField resignFirstResponder];
    
    [self.moreView show];
}

///替换掉原有的单击操作
- (void)textFieldTapPressGestureAction:(UITapGestureRecognizer *)ges{
    
    if (self.textField.inputView == self.emojiView) {
        self.textField.inputView = nil;
        [self.textField reloadInputViews];
        self.textField.tintColor = [UIColor blackColor];
    }
    [self.textField becomeFirstResponder];
    NSLog(@"单击！");
}

///长按输入框操作
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按！");
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

#pragma mark textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.voiceBtn.isSelected) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField.text.length >0) {
        
        ICMessage *msgRight = [ICMessageHelper createMessageModel:TypeText
                                                          content:textField.text path:nil
                                                             from:@"ts"
                                                               to:self.group.gId
                                                          fileKey:nil
                                                         isSender:YES];
        [self.dataSource addObject:msgRight];
        [self.tableView reloadData];
        [self setTableViewPositionAtBottom];
        [self messageSendSucced:msgRight];
    }
    textField.text = @"";
    return YES;
}
#pragma mark 点击表情键盘发送按钮事件
- (void)ChatEmojiViewClickSendButtonAction{
    [self.textField resignFirstResponder];
    if (self.textField.text.length >0) {
        ICMessage *msgRight = [ICMessageHelper createMessageModel:TypeText
                                                          content:self.textField.text
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
    self.textField.text = @"";
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self->_dataArray.count>0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.tableView numberOfRowsInSection:0]-1) inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    });
}

#pragma mark ChatEmojiViewDelegate
- (void)ChatEmojiView:(nonnull ChatEmojiView *)emojiView didSelectEmojiItemAtText:(nonnull NSString *)emojiText {
    
    self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,emojiText];
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
    
    if (messageModel.isSender) {
        
        [[UIMenuController sharedMenuController] setMenuItems:@[_copyMenuItem,_deleteMenuItem,_forwardMenuItem,_addScheduleMenuItem]];
        
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
#pragma mark 查看图片 播放视频 录音
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
}


#pragma mark lazy
- (UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    }
    return _longPress;
}
- (UITapGestureRecognizer *)textFieldTapGes{
    
    if (!_textFieldTapGes) {
        _textFieldTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldTapPressGestureAction:)];
    }
    return _textFieldTapGes;
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
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
