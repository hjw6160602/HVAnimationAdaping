//
//  ViewController.h
//  HV动画适配
//
//  Created by shoule on 15/6/13.
//  Copyright (c) 2015年 SaiDicaprio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTN_LENGTH_NORMAL       40
#define BTN_LENGTH_SMALL        24
#define HEADUPVIEW_MASK_H       20
#define BTH_OFFSET_HEIGHT       10
#define ASPECT_RATIO1           0.125
#define ASPECT_RATIO2           0.375
#define ASPECT_RATIO3           0.625
#define ASPECT_RATIO4           0.875
#define HEADER_VIEW_H           230
#define SELECT_VIEW_Y           194
#define SELECT_VIEW_H           106

#define Screen_width            [[UIScreen mainScreen] bounds].size.width
#define Screen_height           [[UIScreen mainScreen] bounds].size.height
#define HJWColor(R, G, B)       [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

@interface ViewController : UIViewController{
    NSInteger _ExtraHeight;
    NSInteger _HeaderViewH;
    NSInteger _SelectViewY;
    NSInteger _SelectViewH;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *headerUpView;

@property (weak, nonatomic) IBOutlet UIImageView *imageScrollView;

@property (weak, nonatomic) IBOutlet UIView *seperatorRect;

@property (strong, nonatomic) IBOutlet UIView *selectView;

@property (strong, nonatomic) UIView *lineView;  //灰线
@property (strong, nonatomic) UIButton *lastButton;  //标记上一个被点击的按钮

@end

