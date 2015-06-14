//
//  ViewController.m
//  HV动画适配
//
//  Created by shoule on 15/6/13.
//  Copyright (c) 2015年 SaiDicaprio. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
}

- (void)initControls{
    _ExtraHeight = 0;
    _SelectViewY = SELECT_VIEW_Y;
    _SelectViewH = SELECT_VIEW_H;
    _HeaderViewH = HEADER_VIEW_H;
    //底层DropDown
    self.selectView.alpha = 0;
    self.selectView.frame=CGRectMake(0, _HeaderViewH-_SelectViewH, Screen_width, _SelectViewH);
    //灰线
    self.lineView=[UIView new];
    self.lineView.backgroundColor = HJWColor(204, 204, 204);
    self.lineView.alpha=0;
    self.lineView.frame=CGRectMake(0, _SelectViewY, Screen_width, 1);

    if ( Screen_height*0.4 > _HeaderViewH) {
        float imageW = self.imageScrollView.frame.size.width;
        float imageH = self.imageScrollView.frame.size.height;
        float AspectRatio = imageW / imageH;
        float SVImg_AspectRatio = 320/SELECT_VIEW_H;
        NSInteger NewImageHeight = (NSInteger)Screen_width / AspectRatio;
        _SelectViewH = (NSInteger) Screen_width / SVImg_AspectRatio;
        _ExtraHeight = NewImageHeight - self.imageScrollView.frame.size.height;
        _HeaderViewH += _ExtraHeight;
        self.headerView.frame = CGRectMake(0, 0, Screen_width, _HeaderViewH);
        self.headerUpView.frame = CGRectMake(0, 0, Screen_width, _HeaderViewH);
        //将多出的高度全部加在图片上
        self.imageScrollView.frame = CGRectMake(0, 0, Screen_width, NewImageHeight);
        self.seperatorRect.frame = CGRectMake(0, NewImageHeight, Screen_width, 11);
        self.lineView.frame=CGRectMake(0, _SelectViewY+_ExtraHeight, Screen_width, 1);
        
        UIView *Btn1 = [self.headerUpView viewWithTag:2000];
        NSInteger NEW_BTN_HEIGHT = Btn1.frame.origin.y+_ExtraHeight;
        Btn1.frame = CGRectMake(Screen_width*ASPECT_RATIO1-BTN_LENGTH_NORMAL/2, NEW_BTN_HEIGHT, BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
        UIView *Btn2 = [self.headerUpView viewWithTag:2001];
        Btn2.frame = CGRectMake(Screen_width*ASPECT_RATIO2-BTN_LENGTH_NORMAL/2, NEW_BTN_HEIGHT, BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
        UIView *Btn3 = [self.headerUpView viewWithTag:2002];
        Btn3.frame = CGRectMake(Screen_width*ASPECT_RATIO3-BTN_LENGTH_NORMAL/2, NEW_BTN_HEIGHT, BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
        UIView *Btn4 = [self.headerUpView viewWithTag:2003];
        Btn4.frame = CGRectMake(Screen_width*ASPECT_RATIO4-BTN_LENGTH_NORMAL/2, NEW_BTN_HEIGHT, BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
        
        UIView *Txt1 = [self.headerUpView viewWithTag:1000];
        NSInteger Txt1W = Txt1.frame.size.width;
        NSInteger Txt1H = Txt1.frame.size.height;
        NSInteger NewTxtHeight = NEW_BTN_HEIGHT + 48;//BTN的Y值 和TXT的Y值的差值为48
        Txt1.frame = CGRectMake(Screen_width*ASPECT_RATIO1 - Txt1W/2, NewTxtHeight, Txt1W, Txt1H);
        UIView *Txt2 = [self.headerUpView viewWithTag:1001];
        NSInteger Txt2W = Txt1.frame.size.width;
        NSInteger Txt2H = Txt1.frame.size.height;
        Txt2.frame = CGRectMake(Screen_width*ASPECT_RATIO2 - Txt2W/2, NewTxtHeight, Txt2W, Txt2H);
        UIView *Txt3 = [self.headerUpView viewWithTag:1002];
        NSInteger Txt3W = Txt1.frame.size.width;
        NSInteger Txt3H = Txt1.frame.size.height;
        Txt3.frame = CGRectMake(Screen_width*ASPECT_RATIO3 - Txt3W/2, NewTxtHeight, Txt3W, Txt3H);
        UIView *Txt4 = [self.headerUpView viewWithTag:1003];
        NSInteger Txt4W = Txt1.frame.size.width;
        NSInteger Txt4H = Txt1.frame.size.height;
        Txt4.frame = CGRectMake(Screen_width*ASPECT_RATIO4 - Txt4W/2, NewTxtHeight, Txt4W, Txt4H);
        
        _SelectViewY += _ExtraHeight;
        self.selectView.frame = CGRectMake(0, _HeaderViewH-_SelectViewH, Screen_width, _SelectViewH);
    }
    [self.headerUpView addSubview:self.lineView];
    //在headView上添加Dropdown，则在headUpView下层
    [self.headerView addSubview:self.selectView];
    self.tableView.tableHeaderView = self.headerView;
}

- (IBAction)chooseButton:(UIButton *)button {
    if (button.tag  != self.lastButton.tag) {  //当前点击Btn不为上一个点击的Btn时
        for (int i=1000; i<1004; i++) {  //隐藏Label文字
            UIView* view=[self.headerUpView viewWithTag:i];
            view.alpha=0;
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7];
        for (int i=2000; i<2004; i++) { //处理Btn图标
            UIView* view=[self.headerUpView viewWithTag:i];
            CGPoint Origin = view.frame.origin;
            if (button.tag == view.tag) { //将当前被点击的Btn的图标宽高变大为40
                view.frame=CGRectMake(Origin.x, Origin.y+BTH_OFFSET_HEIGHT,BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
                _lineView.alpha = 1;  //显示灰线
                [self.headerUpView bringSubviewToFront:view];
            }
            else{ //其它Btn的宽高通通变为24的宽高
                if (self.lastButton.tag == view.tag) { //lastBtn的y坐标－10 重归原位
                    CGPoint Origin = self.lastButton.frame.origin;
                    self.lastButton.frame=CGRectMake(Origin.x, Origin.y-BTH_OFFSET_HEIGHT,BTN_LENGTH_SMALL, BTN_LENGTH_SMALL);
                } else view.frame=CGRectMake(Origin.x, Origin.y,BTN_LENGTH_SMALL, BTN_LENGTH_SMALL);
            }
        }
        self.headerView.frame=CGRectMake(0, 0, Screen_width, _SelectViewY+_SelectViewH);//headView变长
        self.headerUpView.frame=CGRectMake(0, 0, Screen_width, _HeaderViewH - HEADUPVIEW_MASK_H);
        self.selectView.frame=CGRectMake(0, _SelectViewY, Screen_width, _SelectViewH); //Dropdown出现
        self.selectView.alpha=1; // 调整selectView的alpha值为1
        self.lastButton = button;// 标记当前Btn为上一次被点击的Btn
        self.tableView.tableHeaderView=self.headerView;//将tableView的HeaderView设置为自定义的View
        [UIView commitAnimations];
        
    } else { //当前点击的Btn就是lastBtn时：
        self.lastButton = nil;
        [self performSelector:@selector(showLabel) withObject:nil afterDelay:0.4]; //所有Label重现现
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7];
        for (int i=2000; i<2004; i++) { //处理Btn图标
            UIView* view = [self.headerUpView viewWithTag:i];
            CGPoint Origin = view.frame.origin;//取到所有Btn图标
            if (button.tag == i) { //当为当前点击Btn时候
                //被点击Btn的位置还原
                view.frame=CGRectMake(Origin.x, Origin.y-BTH_OFFSET_HEIGHT,BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
                _lineView.alpha = 0;//灰线消失
            } else view.frame=CGRectMake(Origin.x, Origin.y,BTN_LENGTH_NORMAL, BTN_LENGTH_NORMAL);
        }
        //headView重回原位
        self.headerView.frame = CGRectMake(0, 0, Screen_width, _HeaderViewH);
        //Dropdown隐藏在下面
        self.selectView.frame = CGRectMake(0, _HeaderViewH - _SelectViewH, Screen_width, _SelectViewH);
        self.selectView.alpha = 0;
        _tableView.tableHeaderView = self.headerView;
        [UIView commitAnimations];
    }
    [self.headerView bringSubviewToFront:self.headerUpView];
}

//所有Label重现现
-(void)showLabel{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    for (int j=0; j<3; j++) {
        for (int i=1000; i<1004; i++) {
            UIView* view=[self.headerUpView viewWithTag:i];
            view.alpha=1;
        }
    }
    [UIView commitAnimations];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

@end
