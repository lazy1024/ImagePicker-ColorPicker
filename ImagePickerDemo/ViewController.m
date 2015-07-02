//
//  ViewController.m
//  ImagePickerDemo
//
//  Created by magnimage on 15/6/29.
//  Copyright (c) 2015年 Lazy. All rights reserved.
//

#import "ViewController.h"

#define LOGOTAG     1090

typedef enum
{
    LOGOINDEX11,
    LOGOINDEX12,
    LOGOINDEX13,
    LOGOINDEX14,
    LOGOINDEX21,
    LOGOINDEX22,
    LOGOINDEX23,
    LOGOINDEX24,

    LOGOINDEXMAX,
}LogoImageTypedef;

NSString *LogoImageName[LOGOINDEXMAX] =
{
    @"logoImage11.jpg",
    @"logoImage12.jpg",
    @"logoImage13.jpg",
    @"logoImage14.jpg",
    @"logoImage21.jpg",
    @"logoImage22.jpg",
    @"logoImage23.jpg",
    @"logoImage24.jpg",
};

UIButton *LogoImageButton[LOGOINDEXMAX] = {nil};


ViewController *singletonViewController;

typedef enum
{
    CEScreen1,
    CEScreen2,
}CurrentEditScreen;

@interface ViewController ()
{
    LogoImageTypedef _logoImageIndex;
    UIColor *screen1Color;
    UIColor *screen2Color;
    CurrentEditScreen currentEditScreen;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    singletonViewController = self;
    
    // ----
    LogoImageButton[LOGOINDEX11] = self.logoImageBtn11;
    LogoImageButton[LOGOINDEX12] = self.logoImageBtn12;
    LogoImageButton[LOGOINDEX13] = self.logoImageBtn13;
    LogoImageButton[LOGOINDEX14] = self.logoImageBtn14;
    LogoImageButton[LOGOINDEX21] = self.logoImageBtn21;
    LogoImageButton[LOGOINDEX22] = self.logoImageBtn22;
    LogoImageButton[LOGOINDEX23] = self.logoImageBtn23;
    LogoImageButton[LOGOINDEX24] = self.logoImageBtn24;
    
    // ------
    _logoImageBtn14.backgroundColor = [UIColor grayColor];
    _logoImageBtn24.backgroundColor = [UIColor grayColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectImageFromPhotosAlbum:(LogoImageTypedef)logoImageIndex
{
    _logoImageIndex = logoImageIndex;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (IBAction)selectLogoImage11:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX11];
}

- (IBAction)selectLogoImage12:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX12];
}

- (IBAction)selectLogoImage13:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX13];
}

- (IBAction)selectLogoImage14:(id)sender {
    currentEditScreen = CEScreen1;
}

- (IBAction)selectLogoImage21:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX21];
}

- (IBAction)selectLogoImage22:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX22];
}

- (IBAction)selectLogoImage23:(UIButton *)sender {
    [self selectImageFromPhotosAlbum:LOGOINDEX23];
}

- (IBAction)selectLogoImage24:(UIButton *)sender {
    currentEditScreen = CEScreen2;
}



#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:LogoImageName[_logoImageIndex]];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:LogoImageName[_logoImageIndex]];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:path];
    [LogoImageButton[_logoImageIndex] setImage:savedImage forState:UIControlStateNormal];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Func
- (void)saveImage:(UIImage *)image withName:(NSString *)name
{
    NSData *jpgImageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    [jpgImageData writeToFile:path atomically:NO];
}

- (void)updateScreenPureColorBkg:(UIColor *)color
{
    if(currentEditScreen == CEScreen1)
    {
        screen1Color = color;
        self.logoImageBtn14.backgroundColor = color;
    }
    else
    {
        screen2Color = color;
        self.logoImageBtn24.backgroundColor = color;
    }
}


#if 0
- (void)selectImage:(UIButton *)sender
{
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:@"取消"
                                         otherButtonTitles:@"拍照", @"相册", nil];
    }
    else
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:@"取消"
                                         otherButtonTitles:@"相册", nil];
    }
    
    actionSheet.tag = LOGOTAG;
    [actionSheet showInView:self.view];
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == LOGOTAG)
    {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
        }
        else
        {
           if(buttonIndex == 0)
           {
               return;
           }
           else
           {
//               sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
               sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
           }
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
#endif


@end
