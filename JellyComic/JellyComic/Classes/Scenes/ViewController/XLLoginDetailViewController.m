//
//  XLLoginDetailViewController.m
//  测试5
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XLLoginDetailViewController.h"

#import "XLAmendNickNameViewController.h"
#import "XLAmendPwdViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVOSCloud/AVOSCloud.h>
#import "XLLocalDataManager.h"

@interface XLLoginDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (nonatomic ,strong) NSString *lastChosenMediaType;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;


@end

@implementation XLLoginDetailViewController

- (void)loadUserInfo {
    AVQuery *query = [AVQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userName" equalTo:self.userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.userInfo = objects.firstObject;
            self.nickNameLabel.text = [self.userInfo objectForKey:@"nickName"];
            self.headImageView.image = [UIImage imageWithData:[self.userInfo objectForKey:@"photo"]];
        } else if (error.code == 28) {
            self.hintLabel.text = @"连接超时，请重试";
        } else {
            self.hintLabel.hidden = NO;
            self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
        }
    }];
}

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hintLabel.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    [self loadUserInfo];
    self.headImageView.layer.cornerRadius = 50;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.headImageView addGestureRecognizer:tapGesture];
    self.nickNameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taPAction:)];
    [self.nickNameLabel addGestureRecognizer:tapGesture1];
}
#pragma mark - label点击事件
- (void)taPAction:(id)sender
{
    XLAmendNickNameViewController *xlAmendNickName = [XLAmendNickNameViewController new];
    xlAmendNickName.returnBlock = ^(NSString *string)
    {
        self.nickNameLabel.text = string;
        [self.userInfo setObject:string forKey:@"nickName"];
        [self.userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
            } else {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
            }
        }];
    };
    xlAmendNickName.string = self.nickNameLabel.text;
    [self.navigationController pushViewController:xlAmendNickName animated:YES];
}
#pragma mark - 图片点击事件
- (void)tapAction:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shootPiicturePrVideo];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectExistingPictureOrVideo];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - 修改密码
- (IBAction)changePWD:(UIButton *)sender
{
//    XLAmendPwdViewController *xlAmendPwd = [XLAmendPwdViewController new];
//    [self.navigationController pushViewController:xlAmendPwd animated:YES];
}
#pragma mark - 上传
- (IBAction)synchronousData:(UIButton *)sender {
    [[XLLocalDataManager shareManager] open];
    NSArray *collectArray = [[XLLocalDataManager shareManager] selectAllSComic:tableListcollect];
    [[XLLocalDataManager shareManager] close];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:collectArray];
    [self.userInfo setObject:data forKey:@"collectArray"];
    [self.userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self showDetailViewController:alertController sender:nil];
        } else {
            self.hintLabel.hidden = NO;
            self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
        }
    }];
}
#pragma mark - 下载
- (IBAction)downLoad:(UIButton *)sender {
    NSArray *collectArray = [NSKeyedUnarchiver unarchiveObjectWithData:[self.userInfo objectForKey:@"collectArray"]];
    
}
#pragma mark - 注销
- (IBAction)cancelAction:(UIButton *)sender {
    [AVUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shootPiicturePrVideo
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (void)selectExistingPictureOrVideo
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.lastChosenMediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([_lastChosenMediaType isEqual:(NSString *) kUTTypeImage]) {
        UIImage *chosenImage =[info objectForKey:UIImagePickerControllerEditedImage];
        self.headImageView.image = chosenImage;
        [self.userInfo setObject:UIImageJPEGRepresentation(chosenImage, 1) forKey:@"photo"];
        [self.userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
            } else {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = [NSString stringWithFormat:@"%@(%ld)", error.localizedDescription, error.code];
            }
        }];
    }
    if ([_lastChosenMediaType isEqual:(NSString *) kUTTypeMovie]) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        //        [alert show];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"系统只支持图片格式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediatypes count] > 0){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediatypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        NSString *requiredmediatype = (NSString *)kUTTypeImage;
        NSArray *arrmediatypes = [NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {

        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误信息" message:@"当前设备不支持拍照功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
static UIImage *shrinkImage(UIImage *orignal,CGSize size)
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale, size.height * scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width * scale, size.height *scale), orignal.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    CGContextRelease(context);
    CGImageRelease(shrunken);
    return final;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
