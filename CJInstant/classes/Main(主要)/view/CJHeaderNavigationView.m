//
//  CJHeaderNavigationView.m
//  instant
//
//  Created by chjsun on 16/5/22.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "CJHeaderNavigationView.h"

#define onlyValue 78

@interface CJHeaderNavigationView ()

/** 标签计数器 */
@property (nonatomic, assign) CGFloat btnCount;
/** 设置按钮弹出的界面 */
@property (nonatomic, weak) UIButton *addView;

@end

@implementation CJHeaderNavigationView

/**
 *  导航栏按钮下方白色示意滚动条懒加载
 *
 *  @return scrollView
 */
-(UIView *)selectStatView{
    if (!_selectStatView) {
        CGRect navitationFrame = CGRectMake(10, 60, 44, 4);
        _selectStatView = [[UIScrollView alloc] initWithFrame:navitationFrame];
        _selectStatView.backgroundColor = [UIColor whiteColor];
    }
    return _selectStatView;
    
}


#pragma mark - 设置头部导航栏

/**
 *  设置头部导航的按钮
 */
-(void)setUpNavitation{
    
    UIButton *btn1 = [[UIButton alloc] init];
    [self setUpButton:btn1 title:@"全"];
    //默认选择第一个按钮
    btn1.selected = YES;
    self.selectButton = btn1;
    
    UIButton *btnWeek = [[UIButton alloc] init];
    [self setUpButton:btnWeek title:@"周"];
    
    UIButton *btnMonth = [[UIButton alloc] init];
    [self setUpButton:btnMonth title:@"月"];
    
    UIButton *btnOld = [[UIButton alloc] init];
    [self setUpButton:btnOld title:@"昔"];
    
    UIButton *btnAdd = [[UIButton alloc] init];
    self.addView = btnAdd;
    [self setupButtonAdd:btnAdd];
    
    
    [self addSubview:self.selectStatView];
    
}

/**
 *  为每一个按钮设置属性
 *
 *  @param btn   对应按钮
 *  @param title 按钮上的文字
 */
-(void)setUpButton:(UIButton *)btn title:(NSString *)title{
    //设置按钮的属性
    CGFloat width = 10 + 44 * self.btnCount;
    CGRect btnFrame = CGRectMake(width, 20, 44, 44);
    btn.frame = btnFrame;
    btn.tag = self.btnCount + onlyValue;
    btn.backgroundColor = CJHeaderColor;
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(switchControl:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    self.btnCount += 1;
}

-(void) setupButtonAdd:(UIButton *)button{
    
    [button setImage:[UIImage imageNamed:@"ic_add_white"] forState:UIControlStateNormal];
    button.frame = CGRectMake(CJWIDTH - CJItemHeight/2, 20, 44, 44);
    [button addTarget:self action:@selector(addCleck:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

-(void) addCleck:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(HeaderNavitation:didSelectAdd:)]) {
        [self.delegate HeaderNavitation:self didSelectAdd:button];
    }
    
}


/**
 *  按钮点击事件
 *
 *  @param button 点击的按钮
 */
-(void)switchControl:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(HeaderNavitation:didSelectButton:)]) {
        [self.delegate HeaderNavitation:self didSelectButton:button];
    }

}

@end
