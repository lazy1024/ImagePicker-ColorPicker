//
//  ColorPickerViewController.h
//  ImagePickerDemo
//
//  Created by magnimage on 15/7/1.
//  Copyright (c) 2015年 Lazy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZColorPicker.h"

@protocol ColorPickerViewControllerDelegate;

@interface ColorPickerViewController : UIViewController
{
//    UIColor *selectedColor;
//    id<ColorPickerViewControllerDelegate> delegate;
}
@property(nonatomic, assign) id<ColorPickerViewControllerDelegate> delegate;
@property(nonatomic, retain) UIColor *selectedColor;
@end

@protocol ColorPickerViewControllerDelegate
- (void) defaultColorController:(ColorPickerViewController *)controller didChangeColor:(UIColor *)color;
@end
