//
//  InfoButton.m
//  BusAP
//
//  Created by dingxin on 13-7-4.
//  Copyright (c) 2013年 BusAP. All rights reserved.
//

#import "InfoButton.h"


@implementation DataButton

//获取某固定文本的显示高度
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font
{
    return [InfoButton heightForString:str Size:size Font:font Lines:0];
}

+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines
{
    if (StringIsNullOrEmpty(str)) {
        return CGRectMake(0, 0, 0, 0);
    }
    static UILabel *lbtext;
    if (lbtext==nil) {
        lbtext    = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }else{
        lbtext.frame=CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.font=font;
    lbtext.text=str;
    lbtext.numberOfLines=lines;
    CGRect rect= [lbtext textRectForBounds:lbtext.frame limitedToNumberOfLines:lines];
    if(rect.size.height<0)
        rect.size.height=0;
    if (rect.size.width<0) {
        rect.size.width=0;
    }
    return rect;
    
}


+(id)buttonWithType:(UIButtonType)buttonType
{
    DataButton *btn=[[DataButton alloc] init];
    
    return btn;
}

-(void)dealloc
{
    self.args=nil;
    
//    [super dealloc];
}
@end



static NSInteger sBackImgVTag = 346574;
static NSInteger sCountLabelTag = 456732;
static CGFloat maxWidth = 50.0f;
static CGFloat minWidth = 17.0f;
static CGFloat maxHeight = 50.0f;
static CGFloat minHeight = 17.0f;
@implementation InfoButton

//这个方法有问题
+(id)buttonWithType:(UIButtonType)buttonType andColorType:(InfoButtonType)infoBtnType
{
    
    InfoButton *btn = [super buttonWithType:buttonType];
    
    if (btn) {
        UIImageView *backImgeV;  //背景
        UILabel *countLabel;     //数字
        backImgeV = [[UIImageView alloc] initWithFrame:CGRectZero];
        if (infoBtnType == InfoButtonTypeRed) {
            [backImgeV setImage:[IMG(@"indexright_red.png") stretchableImageWithLeftCapWidth:8.5 topCapHeight:0]];
        }else if (infoBtnType == InfoButtonTypeBlue)
        {
            [backImgeV setImage:[IMG(@"indexright_blue.png") stretchableImageWithLeftCapWidth:8.5 topCapHeight:0]];
            [backImgeV setBackgroundColor:UIColorFromRGB(0x98c31c)];
            backImgeV.layer.cornerRadius = 10.0f;
            backImgeV.layer.masksToBounds = YES;
        }
        backImgeV.tag = sBackImgVTag;
        [btn addSubview:backImgeV];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        countLabel.tag = sCountLabelTag;
        countLabel.font = [UIFont adaptFontOfSize:9];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:countLabel];
    }
    
    
    return btn;
}

-(id)initWithFrame:(CGRect)frame andType:(InfoButtonType)infoBtnType
{
    CGFloat width = frame.size.width;
    if (width>maxWidth) {
        width = maxWidth;
    }
    if (width<minWidth) {
        width = minWidth;
    }
    
    CGFloat height = frame.size.height;
    if (height>maxHeight) {
        height = maxHeight;
    }
    if (height<minHeight) {
        height = minHeight;
    }
    CGRect correctFrame = CGRectMake(frame.origin.x, frame.origin.y, width, height);
    self = [super initWithFrame:correctFrame];
    
    if (self) {
        UIImageView *backImgeV;  //背景
        UILabel *countLabel;     //数字
        backImgeV = [[UIImageView alloc] initWithFrame:CGRectZero];
        if (infoBtnType == InfoButtonTypeRed) {
            [backImgeV setImage:[IMG(@"indexright_red.png") stretchableImageWithLeftCapWidth:8.5 topCapHeight:0]];
        }else if (infoBtnType == InfoButtonTypeBlue)
        {
            [backImgeV setImage:[IMG(@"indexright_blue.png") stretchableImageWithLeftCapWidth:8.5 topCapHeight:0]];
            [backImgeV setBackgroundColor:UIColorFromRGB(0x98c31c)];
            backImgeV.layer.cornerRadius = 10.0f;
            backImgeV.layer.masksToBounds = YES;
        }
        backImgeV.tag = sBackImgVTag;
        [self addSubview:backImgeV];

        
        countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        countLabel.tag = sCountLabelTag;
        countLabel.font = [UIFont adaptFontOfSize:9];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:countLabel];
        backImgeV.hidden = YES;
        countLabel.hidden = YES;
    }
    //    self.backgroundColor = [UIColor grayColor];
    return self;
}


//设置数字（同时变换背景）
-(void)setCountNumber:(NSString *)countStr
{
    //如果是空(或0)则隐藏控件
    if (StringIsNullOrEmpty(countStr)||[countStr integerValue]<1) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    UIImageView *backImgeV = (UIImageView *)[self viewWithTag:sBackImgVTag];
    UILabel *countLabel = (UILabel *)[self viewWithTag:sCountLabelTag];
    
    backImgeV.hidden = NO;
    countLabel.hidden = NO;
    
    [countLabel setText:countStr];
    
//    CGRect countRect = [NSString rectForString:countStr withSize:CGSizeMake(self.frame.size.width-4, countLabel.height) Font:countLabel.font];
    CGFloat strWidth = 30+4;
    if (strWidth<20) {
        strWidth = 20;
    }
    
    [backImgeV setFrame:CGRectMake((self.width-strWidth)/2, (self.height-20)/2, strWidth, 20)];
    [countLabel setFrame:backImgeV.frame];
}


@end




@implementation UIMultibleStateButton

static CGFloat sActivityIndicatorViewWith = 20.0f;
static CGFloat sActivityIndicatorViewHeight = 20.0f;
static CGFloat sActivityIndicatorViewWith2 = 37.0f;
static CGFloat sActivityIndicatorViewHeight2 = 37.0f;
//
+(id)buttonWithType:(UIButtonType)buttonType
{
    UIMultibleStateButton *muBtn = [[UIMultibleStateButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    return muBtn;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imgAry = [[NSMutableArray alloc] init];
        imgHighlightedAry = [[NSMutableArray alloc] init];

        backImgAry = [[NSMutableArray alloc] init];
        backImgHighlightedAry = [[NSMutableArray alloc] init];
        titleAry = [[NSMutableArray alloc] init];
        titleColorAry = [[NSMutableArray alloc] init];
        self.currentStateIndex = 999;
        waitActivityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        waitActivityV.frame = CGRectMake((frame.size.width-sActivityIndicatorViewWith)/2, (frame.size.height-sActivityIndicatorViewHeight)/2, sActivityIndicatorViewWith, sActivityIndicatorViewHeight);
        [self addSubview:waitActivityV];
        waitActivityV.hidden = YES;
        
        //        self.backgroundColor = [UIColor yellowColor];
        _imgOrImgName = NO;
    }
    return self;
}


-(void)loadButton
{
    if (!imgAry) {
        imgAry = [[NSMutableArray alloc] init];
    }
    if (!imgHighlightedAry) {
        imgHighlightedAry = [[NSMutableArray alloc] init];
    }
    if (!backImgAry) {
        backImgAry = [[NSMutableArray alloc] init];
    }
    if (!backImgHighlightedAry) {
        backImgHighlightedAry = [[NSMutableArray alloc] init];
    }
    if (!titleAry) {
        titleAry = [[NSMutableArray alloc] init];
    }
    if (!titleColorAry) {
        titleColorAry = [[NSMutableArray alloc] init];
    }
    
    self.currentStateIndex = 999;
    if (!waitActivityV) {
        waitActivityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        waitActivityV.frame = CGRectMake((self.frame.size.width-sActivityIndicatorViewWith)/2, (self.frame.size.height-sActivityIndicatorViewHeight)/2, sActivityIndicatorViewWith, sActivityIndicatorViewHeight);
        [self addSubview:waitActivityV];
        waitActivityV.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    waitActivityV.frame = CGRectMake((frame.size.width-sActivityIndicatorViewWith)/2, (frame.size.height-sActivityIndicatorViewHeight)/2, sActivityIndicatorViewWith, sActivityIndicatorViewHeight);
}
//设置各个状态的图片
-(void)setImageAryWithImages:(NSArray *)theImageAry
{
    if (!imgAry) {
        imgAry = [[NSMutableArray alloc] initWithArray:theImageAry];
    }else{
        [imgAry removeAllObjects];
        [imgAry addObjectsFromArray:theImageAry];
    }
    
}

//设置各个状态的图片(hightlighted)
-(void)setImageHighlightedAryWithImages:(NSArray *)theImageAry
{
    if (!imgHighlightedAry) {
        imgHighlightedAry = [[NSMutableArray alloc] initWithArray:theImageAry];
    }else{
        [imgHighlightedAry removeAllObjects];
        [imgHighlightedAry addObjectsFromArray:theImageAry];
    }
    
}

//设置各个状态的背景图片
-(void)setBackImageAryWithImages:(NSArray *)theImageAry
{
    if (!backImgAry) {
        backImgAry = [[NSMutableArray alloc] initWithArray:theImageAry];
    }else{
        [backImgAry removeAllObjects];
        [backImgAry addObjectsFromArray:theImageAry];
    }
}

//设置各个状态的背景图片(hightlighted)
-(void)setBackHightlightedImageAryWithImages:(NSArray *)theImageAry
{
    if (!backImgHighlightedAry) {
        backImgHighlightedAry = [[NSMutableArray alloc] initWithArray:theImageAry];
    }else{
        [backImgHighlightedAry removeAllObjects];
        [backImgHighlightedAry addObjectsFromArray:theImageAry];
    }
}

//设置各个状态标题
-(void)setTitleAryWithTitles:(NSArray *)theTitlesAry
{
    if (!titleAry) {
        titleAry = [[NSMutableArray alloc] initWithArray:theTitlesAry];
    }else{
        [titleAry removeAllObjects];
        [titleAry addObjectsFromArray:theTitlesAry];
    }
    
}

//设置各个状态标题颜色
-(void)setTitleColorAryWithColors:(NSArray *)theTitleColorsAry
{
    if (!titleColorAry) {
        titleColorAry = [[NSMutableArray alloc] initWithArray:theTitleColorsAry];
    }else{
        [titleColorAry removeAllObjects];
        [titleColorAry addObjectsFromArray:theTitleColorsAry];
    }
}
//设置按钮状态
-(void)setButtonState:(NSInteger)theStateIndex
{
    self.currentStateIndex = theStateIndex;
    
    if (theStateIndex>=[imgAry count] && theStateIndex>=[titleAry count] && theStateIndex>=[backImgAry count]) {
        return;
    }
    
    //图片
    if ([imgAry count]>0) {
        if (theStateIndex<[imgAry count]) {
            UIImage *stateImage = nil;
            if (_imgOrImgName) {
                stateImage = [imgAry objectAtIndex:theStateIndex];
            }else{
                stateImage = [UIImage imageNamed:[imgAry objectAtIndex:theStateIndex]];
            }
            
            //        [self setBackgroundImage:stateImage forState:UIControlStateNormal];
            [self setImage:stateImage forState:UIControlStateNormal];
        }else{
            [self setImage:nil forState:UIControlStateNormal];
        }
    }
    
    //hightlighted 图片
    if ([imgHighlightedAry count]>0) {
        if (theStateIndex<[imgHighlightedAry count]) {
            UIImage *stateHImage = nil;
            if (_imgOrImgName) {
                stateHImage = [imgHighlightedAry objectAtIndex:theStateIndex];
            }else{
                stateHImage = [UIImage imageNamed:[imgHighlightedAry objectAtIndex:theStateIndex]];
            }

            [self setImage:stateHImage forState:UIControlStateHighlighted];
        }else{
            [self setImage:nil forState:UIControlStateHighlighted];
        }
    }
    
    //背景图片
    if (theStateIndex<[backImgAry count]) {

        UIImage *stateBackImage = nil;
        if (_imgOrImgName) {
            stateBackImage = [backImgAry objectAtIndex:theStateIndex];
        }else{
            stateBackImage = [UIImage imageNamed:[backImgAry objectAtIndex:theStateIndex]];
        }
        
        if (self.backColorOrImg) {
            //背景色
            [self setBackgroundColor:[UIColor colorWithPatternImage:stateBackImage]];
        }else{
            //背景图
            CGSize orImgSize = stateBackImage.size;
            [self setBackgroundImage:[stateBackImage stretchableImageWithLeftCapWidth:orImgSize.width/2 topCapHeight:orImgSize.height/2] forState:UIControlStateNormal];
        }
    }else{
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
    //背景图片hightlighted
    if (theStateIndex<[backImgHighlightedAry count]) {
        
        UIImage *stateHBackImage = nil;
        if (_imgOrImgName) {
            stateHBackImage = [backImgHighlightedAry objectAtIndex:theStateIndex];
        }else{
            stateHBackImage = [UIImage imageNamed:[backImgHighlightedAry objectAtIndex:theStateIndex]];
        }

        if (self.backColorOrImg) {
            //背景色
            [self setBackgroundColor:[UIColor colorWithPatternImage:stateHBackImage]];
        }else{
            //背景图
            CGSize orImgSize = stateHBackImage.size;
            [self setBackgroundImage:[stateHBackImage stretchableImageWithLeftCapWidth:orImgSize.width/2 topCapHeight:orImgSize.height/2] forState:UIControlStateHighlighted];
        }
    }else{
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
    
    //标题
    if (theStateIndex<[titleAry count]) {
        [self setTitle:[titleAry objectAtIndex:theStateIndex] forState:UIControlStateNormal];
    }else{
        [self setTitle:nil forState:UIControlStateNormal];
    }
    
    //标题颜色
    if (theStateIndex<[titleColorAry count]) {
        UIColor *theColor = [titleColorAry objectAtIndex:theStateIndex];
        [self setTitleColor:theColor forState:UIControlStateNormal];
    }
    
}

//设置activity类型
-(void)setActivStyle:(UIActivityIndicatorViewStyle)activStyle
{
    waitActivityV.activityIndicatorViewStyle = activStyle;
    
    CGFloat actWidth = 0;
    CGFloat actHeight = 0;
    if (activStyle == UIActivityIndicatorViewStyleWhiteLarge) {
        actWidth = sActivityIndicatorViewWith2;
        actHeight = sActivityIndicatorViewHeight2;
    }else{
        actWidth = sActivityIndicatorViewWith;
        actHeight = sActivityIndicatorViewHeight;
    }
    
    waitActivityV.frame = CGRectMake((self.frame.size.width-actWidth)/2, (self.frame.size.height-actHeight)/2, actWidth, actHeight);
}

//获取当前状态
-(NSInteger)getCurrentStateIndex
{
    return self.currentStateIndex;
}

////按钮可用|不可用
//-(void)setEnabled:(BOOL)enabled
//{
//    [super setEnabled:enabled];
//    if (!enabled) {
//        waitActivityV.hidden = NO;
//        [waitActivityV startAnimating];
//
////        [self setBackgroundImage:nil forState:UIControlStateNormal];
//        if ([imgAry count]>0) {
//            [self setImage:nil forState:UIControlStateNormal];
//        }
//
//        [self setTitle:nil forState:UIControlStateNormal];
//    }else{
//        waitActivityV.hidden = YES;
//        [waitActivityV stopAnimating];
//    }
//}

-(void)setStateLoading:(BOOL)loading
{
    [self setEnabled:!loading];
    if (loading) {
        waitActivityV.hidden = NO;
        [waitActivityV startAnimating];
        
        if ([imgAry count]>0) {
            [self setImage:nil forState:UIControlStateNormal];
        }
        
        [self setTitle:nil forState:UIControlStateNormal];
    }else{
        waitActivityV.hidden = YES;
        [waitActivityV stopAnimating];
    }
}

-(void)dealloc
{

    imgAry = nil;
    
    imgHighlightedAry = nil;

    backImgAry = nil;

    backImgHighlightedAry = nil;

    titleAry = nil;

    titleColorAry = nil;

    waitActivityV = nil;
    

}

@end


@implementation UIButton (VCenter)

-(void)setTitleAndImageUpDownLayout
{
    [self setTitleAndImageUpDownLayoutWithSpace:6.0f];
}


-(void)setTitleAndImageUpDownLayoutWithSpace:(CGFloat)theSpaceBetweenImgAndTitle
{
    CGFloat spacing = theSpaceBetweenImgAndTitle;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(
                                            0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = self.titleLabel.frame.size;
    if (IOS7_OR_LATER) {
        titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(
                                            - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
}

@end


