//
//  InfoButton.h
//  BusAP
//
//  Created by dingxin on 13-7-4.
//  Copyright (c) 2013年 BusAP. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil||[str isEqualToString:@""])
//取得指定名称的图片
#define IMG(name) [UIImage imageNamed:name]

@interface DataButton : UIButton

@property(nonatomic, strong) id args;//一个用于保存数据的button

//获取某固定文本的显示高度
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font;
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines;

@end



typedef enum
{
    InfoButtonTypeRed = 0,
    InfoButtonTypeBlue
}
InfoButtonType;
//更新数按钮
@interface InfoButton : DataButton
{
    
}

+(id)buttonWithType:(UIButtonType)buttonType andColorType:(InfoButtonType)infoBtnType;

-(id)initWithFrame:(CGRect)frame andType:(InfoButtonType)infoBtnType;
//设置数字（同时变换背景）
-(void)setCountNumber:(NSString *)countStr;
@end



//多状态按钮


@interface UIMultibleStateButton : DataButton
{
    //不同状态下的图片
    NSMutableArray *imgAry;
    NSMutableArray *imgHighlightedAry;
    NSMutableArray *titleAry;
    NSMutableArray *backImgAry;
    NSMutableArray *backImgHighlightedAry;
    NSMutableArray *titleColorAry;
    //    NSInteger currentStateIndex;
    UIActivityIndicatorView *waitActivityV;    //加载指示器
}
@property (nonatomic, assign) NSInteger currentStateIndex;
@property (nonatomic, assign) BOOL backColorOrImg;         //是否是背景色
@property (nonatomic, assign) BOOL imgOrImgName;           //图片名称还是图片对象（默认图片名称）
-(void)loadButton;   //按钮特殊功能初始化
//设置各个状态的图片
-(void)setImageAryWithImages:(NSArray *)theImageAry;
//设置各个状态的图片(hightlighted)
-(void)setImageHighlightedAryWithImages:(NSArray *)theImageAry;
//设置各个状态的背景图片
-(void)setBackImageAryWithImages:(NSArray *)theImageAry;
//设置各个状态的背景图片(hightlighted)
-(void)setBackHightlightedImageAryWithImages:(NSArray *)theImageAry;
//设置各个状态标题
-(void)setTitleAryWithTitles:(NSArray *)theTitlesAry;
//设置各个状态标题颜色
-(void)setTitleColorAryWithColors:(NSArray *)theTitleColorsAry;
//设置按钮状态
-(void)setButtonState:(NSInteger)theStateIndex;
//获取当前状态
-(NSInteger)getCurrentStateIndex;
//设置activity类型
-(void)setActivStyle:(UIActivityIndicatorViewStyle)activStyle;
//设置按钮加载中状态
-(void)setStateLoading:(BOOL)loading;

@end


//图片标题竖直方向排列的按钮
@interface UIButton (VCenter)
-(void)setTitleAndImageUpDownLayout;

-(void)setTitleAndImageUpDownLayoutWithSpace:(CGFloat)theSpaceBetweenImgAndTitle;

@end