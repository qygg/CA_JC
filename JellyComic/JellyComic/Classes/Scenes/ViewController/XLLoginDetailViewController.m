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
@interface XLLoginDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (nonatomic ,strong) NSString *lastChosenMediaType;

@end

@implementation XLLoginDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    };
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
    XLAmendPwdViewController *xlAmendPwd = [XLAmendPwdViewController new];
    [self.navigationController pushViewController:xlAmendPwd animated:YES];
}
#pragma mark - 同步数据
- (IBAction)synchronousData:(UIButton *)sender {
}
#pragma mark - 注销
- (IBAction)cancelAction:(UIButton *)sender {
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
        NSString *requiredmediatype = (NSString *)kUTTypeImage;
        NSArray *arrmediatypes = [NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误信息" message:@"当前设备不支持拍照功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        //        [alert show];
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