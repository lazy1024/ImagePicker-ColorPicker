//
//  ColorPickerViewController.m
//  ImagePickerDemo
//
//  Created by magnimage on 15/7/1.
//  Copyright (c) 2015年 Lazy. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "UIColor-Expanded.h"

#include "ViewController.h"

@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

@synthesize delegate;
@synthesize selectedColor;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *container = [[UIView alloc] initWithFrame: IS_IPAD ? CGRectMake(0, 0, 320, 480) :[[UIScreen mainScreen] applicationFrame]];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    container.backgroundColor = [UIColor blackColor];
    self.view = container;
    
    UIImage *bkgImage = [UIImage imageNamed:@"defaultLogo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: IS_IPAD ? CGRectMake(0, 0, 320, 480) :[[UIScreen mainScreen] applicationFrame]];
    imageView.image = bkgImage;
    [container addSubview:imageView];
    
    KZColorPicker *picker = [[KZColorPicker alloc] initWithFrame:container.bounds];
    picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    picker.selectedColor = self.selectedColor;
    picker.oldColor = self.selectedColor;
    [picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:picker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Funcs
- (void) pickerChanged:(KZColorPicker *)cp
{
    self.selectedColor = cp.selectedColor;
    [delegate defaultColorController:self didChangeColor:cp.selectedColor];
    
    [singletonViewController updateScreenPureColorBkg:cp.selectedColor];
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
