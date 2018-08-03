//
//  DZSetHeadPortraitsViewController.m
//  qingqing
//
//  Created by Gavin on 2018/5/9.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZSetHeadPortraitsViewController.h"
//#import "MLImageCrop.h"
#import "DZPopRegisterRemindViewController.h"
#import <AFHTTPSessionManager.h>
#import "AliImageReshapeController.h"

@interface DZSetHeadPortraitsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ALiImageReshapeDelegate>
@property(nonatomic,strong)UIImage *headImage;
@end

@implementation DZSetHeadPortraitsViewController
{
    UIButton *_hintBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"上传照片";
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(15, dzNavigationBarH+16, dzScreen_width-30, dzScreen_width-30+80);
    bgView.layer.cornerRadius=5;
    bgView.layer.borderWidth=1;
    bgView.layer.borderColor=dzRgba(0.83, 0.83, 0.83, 1).CGColor;
    [self.view addSubview:bgView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(5, 5, bgView.width-10, bgView.width-10);
    btn.tag=3001;
    [btn setImage:dzImageNamed(@"headIcon") forState:UIControlStateNormal];
    [btn setBackgroundImage:dzImageNamed(@"headIconBg") forState:UIControlStateNormal];
    btn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=3;
    [bgView addSubview:btn];
    
    UILabel *hintL=[[UILabel alloc]init];
    hintL.frame=CGRectMake((btn.width-194)*0.5, btn.height-74, 194, 44);
    hintL.backgroundColor=dzRgba(0, 0, 0, 0.2);
    hintL.text=@"添加照片";
    hintL.textColor=[UIColor whiteColor];
    hintL.font=dzFont(18);
    hintL.tag=2001;
    hintL.textAlignment=NSTextAlignmentCenter;
    hintL.layer.cornerRadius=22;
    hintL.clipsToBounds=YES;
    [btn addSubview:hintL];
    
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(25, CGRectGetMaxY(btn.frame)+5+i*35, bgView.width-20, 35);
        label.tag=1001+i;
        if (i==0) {
            label.text=@"Hi~";
            label.font=dzFont(20);
            label.textColor=DZColorFromRGB(0x9A9A9A);
        }else{
            label.text=@"上传一张本人的真实照片，匹配度翻倍哦！";
            label.font=dzFont(16);
            label.textColor=DZColorFromRGB(0xCDCDCD);
        }
        [bgView addSubview:label];
    }
    UIImage *image=dzImageNamed(@"btn_bg_n");
    
    UIButton *hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    hintBtn.frame=CGRectMake(20, dzScreen_height-image.size.height-50, dzScreen_width-40, (dzScreen_width-40)*image.size.height/image.size.width);
    hintBtn.enabled=NO;
    if (self.frameTypeI==1) {
        [hintBtn setTitle:@"重新提交" forState:UIControlStateNormal];
    }else{
        [hintBtn setTitle:@"开始情情" forState:UIControlStateNormal];
    }
    [hintBtn setBackgroundImage:image forState:UIControlStateNormal];
    hintBtn.titleLabel.font=dzFont(16);
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateSelected];
    [hintBtn setBackgroundImage:dzImageNamed(@"btn_bg_h") forState:UIControlStateHighlighted];
    [hintBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hintBtn];
    _hintBtn=hintBtn;
}
-(void)btnClick:(UIButton *)btn{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    dzWeakSelf(self);
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        [weakself presentViewController:imagePickerController animated:YES completion:nil];
        //设置是否允许用户自己编辑图片
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"没有找到摄像头");
            
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            }
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = NO;
            //            imagePickerController = picker;
            [weakself presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //设置状态条为白色1.设置状态风格 2.修改系统plist文件
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
   
    
    CGFloat width;
    CGFloat height;
    if ((self.view.width-30)*1.5<=self.view.height-100) {
        width=self.view.frame.size.width-30;
        height=(self.view.frame.size.width-30)*1.5;
    }else{
        width=(self.view.height-100)/1.5;
        height=self.view.height-100;
    }
    AliImageReshapeController *vc = [[AliImageReshapeController alloc] init];
    vc.sourceImage = image;
    vc.reshapeScaleF=CGRectMake((self.view.width-width)*0.5, 0,width,height);
    vc.delegate = self;
    [picker pushViewController:vc animated:YES];
}

#pragma mark - ALiImageReshapeDelegate

- (void)imageReshaperController:(AliImageReshapeController *)reshaper didFinishPickingMediaWithInfo:(UIImage *)image
{
    [self UploadTheBackgroundImage:image];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imageReshaperControllerDidCancel:(AliImageReshapeController *)reshaper
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
#pragma mark - UIImagePickerControllerDelegate
//用户选择取消
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker{
    //设置状态条为白色1.设置状态风格 2.修改系统plist文件
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)UploadTheBackgroundImage:(UIImage *)image{
    NSLog(@"%@",image);
    _hintBtn.enabled=YES;
    _hintBtn.selected=YES;
    UILabel *label1=(UILabel *)[self.view viewWithTag:1001];
    label1.text=@"新照片不错哦";
    
    UILabel *label=(UILabel *)[self.view viewWithTag:2001];
    label.hidden=YES;
    UIButton *btn=(UIButton *)[self.view viewWithTag:3001];
    [btn setImage:image forState:UIControlStateNormal];
    self.headImage=image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)BtnClick{
    dzWeakSelf(self);
    if (self.frameTypeI==1) {
        [DZNetwork hintNetwork:@"调用上传照片接口"];
        dzWeakSelf(self);
        [DZNetwork up_ph:post_uploadPicture np:@{@"upPic":[NSString convertToJSONData:@{@"orderNumber":@1}]} im:self.headImage progress:^(NSProgress *progress) {
            NSLog(@"%@",progress);
        } success:^(id data) {
            if ([[data objectForKey:@"resultCode"] integerValue]==0) {
                [NSString saveMember:data];
                DZAppDelegate *appDelegate = (DZAppDelegate *) [[UIApplication sharedApplication] delegate];
                [appDelegate logout];
            }else{
                [DZNetwork hintNetwork:[data objectForKey:@"desc"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        NSLog(@"%@",@{@"loginname":[NSString getNullStr:self.phoneNumS],@"password":[NSString getNullStr:self.passwordS],@"nickname":[NSString getNullStr:self.nicknameS],@"birthDate":[NSString getNullStr:self.birthDateS],@"sex":@(self.sexS),@"mobilecode":[NSString getNullStr:self.mobileCodeS]});
        [DZNetwork up_ph:post_register np:@{@"registerData":[NSString convertToJSONData:@{@"loginname":[NSString getNullStr:self.phoneNumS],@"password":[NSString getNullStr:self.passwordS],@"nickname":[NSString getNullStr:self.nicknameS],@"birthDate":[NSString getNullStr:self.birthDateS],@"sex":@(self.sexS),@"mobilecode":[NSString getNullStr:self.mobileCodeS]}]} im:weakself.headImage progress:^(NSProgress *progress) {
            NSLog(@"%@",progress);
        } success:^(id data) {
            if ([data[@"resultCode"] integerValue]==0) {
                DZPopRegisterRemindViewController *dz_PRR_VC=[DZPopRegisterRemindViewController new];
                dz_PRR_VC.headImage=weakself.headImage;
                dz_PRR_VC.btnBlock = ^{
                    [DZNetwork post_ph:post_login np:@{@"loginName":[NSString getNullStr:self.phoneNumS],@"password":[NSString getNullStr:self.passwordS]} class:[DZMemberModel class] success:^(DZMemberModel *da) {
                        NSLog(@"%@",da);
                        if (da.resultCode==0) {
                            [NSString saveMember:da];
                            DZAppDelegate *appDelegate = (DZAppDelegate *) [[UIApplication sharedApplication] delegate];
                            [appDelegate logout];
                        }else{
                            [DZNetwork hintNetwork:da.desc];
                        }
                    } failure:^(NSError *error) {
                        NSLog(@"%@",error);
                    }];
                };
                [dz_PRR_VC showPullDownVC];
            }else{
                [DZNetwork hintNetwork:data[@"desc"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
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
