//
//  ViewController.h
//  ImagePickerDemo
//
//  Created by magnimage on 15/6/29.
//  Copyright (c) 2015年 Lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn11;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn12;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn13;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn14;

@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn21;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn22;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn23;
@property (strong, nonatomic) IBOutlet UIButton *logoImageBtn24;

- (void)updateScreenPureColorBkg:(UIColor *)color;
@end


extern ViewController *singletonViewController;