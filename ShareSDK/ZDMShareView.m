//
//  HXShareView.m
//  information
//
//  Created by MING.Z on 13-2-7.
//  Copyright (c) 2013年 MING.Z. All rights reserved.
//

#import "ZDMShareView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green: ((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ZDMShareView (){
    int row;//行数
    UIView *showView;
    float height;
    float width;
    BOOL isClick;
}
@end
@implementation ZDMShareView
@synthesize titel,shareDelegate;
@synthesize columnNumber;
@synthesize showName,ImageName;
@synthesize isNight,isShow;

-(id)initWithFrame:(CGRect)frame ColumnNumber:(int)column withName:(NSMutableArray*)_name withImage:(NSMutableArray*)_image withNight:(BOOL)_night{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        width = 320;
        height = frame.size.height;
        columnNumber = column;
        self.showName = [NSMutableArray arrayWithArray:_name];
        self.ImageName = [NSMutableArray arrayWithArray:_image];
        isNight = _night;
    }
    return self;
}
-(void)buildShowShareView{
    self.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShareView)];
    tap.cancelsTouchesInView=NO;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    [tap release];
    if (![self.showName count]) {
        self.showName = SHARENAME;
        self.ImageName = SHAREIMAGE;
    }
    //cancelBtn:80 title:50 button:66 butttonTitel:30
    self.columnNumber = self.columnNumber?self.columnNumber:4;
    if (([self.showName count]%columnNumber)>0) {
        row = (int)[self.showName count]/columnNumber+1;
    }else{
        row = (int)[self.showName count]/columnNumber;
    }
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, height, width, 100+row*90)];
    showView.center = self.center;

    UILabel *titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 280, 40)];
    titelLabel.backgroundColor = [UIColor clearColor];
    if (isNight == NO) {
        showView.backgroundColor = bgClolor;
        titelLabel.textColor = titelClolor;
        
    }else{
        showView.backgroundColor = bgNightClolor;
        titelLabel.textColor = titelNightClolor;
    }
    titelLabel.font = [UIFont systemFontOfSize:21];
    titelLabel.text = titel?titel:@"分享到";
    titelLabel.textAlignment = 1;
    [showView addSubview:titelLabel];
    [titelLabel release];
    [self initShareButton];
    showView.hidden = YES;
    isShow = NO;
    [self addSubview:showView];
    showView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(width-55, 10, 40, 30);
    cancelButton.tag = [self.showName count];
    [cancelButton addTarget:self action:@selector(shareViewClickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (isNight==NO) {
        [cancelButton setTitleColor:UIColorFromRGB(0x007aff) forState:UIControlStateNormal];
//        [cancelButton setBackgroundImage:[UIImage imageNamed:@"shareCancel"] forState:UIControlStateNormal];
    }else{
        [cancelButton setTitleColor:titelNightClolor forState:UIControlStateNormal];
//        [cancelButton setBackgroundImage:[UIImage imageNamed:@"shareCancel-night"] forState:UIControlStateNormal];
    }
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [showView addSubview:cancelButton];
    showView.layer.cornerRadius = 4;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 60, width-40, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [showView addSubview:line];
    [line release];

}
-(void)initShareButton{
    
    for (int i=0; i< row; i++) {
        for (int j=0; j< columnNumber; j++) {
            if ((i*columnNumber+j)>=[self.showName count]) {
                break;
            }
//            (width-40)-columnNumber*66)/(columnNumber-1) 间距
            UIButton *sharBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            sharBtn.frame = CGRectMake(20+((width-40)-columnNumber*66)/columnNumber*(j%columnNumber+0.5)+j*66, 75+i*95, 66, 66);
            sharBtn.tag = 4*i+j;
            sharBtn.backgroundColor = [UIColor clearColor];
            [sharBtn addTarget:self action:@selector(shareViewClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [showView addSubview:sharBtn];
            
            UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+((width-40)-columnNumber*70)/columnNumber*(j%columnNumber+0.5)+j*70, 75+i*95+66, 70, 25)];
            shareLabel.backgroundColor = [UIColor clearColor];
            if (isNight==NO) {
                shareLabel.textColor = titelClolor;
                [sharBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.ImageName objectAtIndex:columnNumber*i+j]]] forState:UIControlStateNormal];
            }else{
                shareLabel.textColor = titelNightClolor;
                [sharBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-night.png",[self.ImageName objectAtIndex:columnNumber*i+j]]] forState:UIControlStateNormal];

            }
            shareLabel.font = [UIFont systemFontOfSize:12];
            shareLabel.text = [self.showName objectAtIndex:i*columnNumber+j];
            shareLabel.textAlignment = 1;
            [showView addSubview:shareLabel];
            [shareLabel release];
            
        }
    }
    
}
-(void)hiddenShareView{
    if (isClick) {
        //屏蔽快速点击
        return;
    }
    isClick = YES;
    self.isShow = NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        showView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        isClick = NO;
    }];
}

-(void)showShareView{
    if (isClick) {
        //屏蔽快速点击
        return;
    }
    self.isShow = YES;
    isClick = YES;
    self.hidden = NO;
    
    [[[[UIApplication sharedApplication] delegate]window]addSubview:self];
    if([[[UIDevice currentDevice] systemVersion]floatValue]>=7){
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            showView.transform = CGAffineTransformMakeScale(0.93, 0.93);
            showView.hidden = NO;
        } completion:^(BOOL finished) {
            isClick = NO;
        }];
    }else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            showView.transform = CGAffineTransformMakeScale(0.93, 0.93);
            showView.hidden = NO;
        } completion:^(BOOL finished) {
            isClick = NO;
        }];
    }
}
-(void)changeClick{
    isClick = NO;
}
-(void)shareViewClickButton:(UIButton*)btn
{
    if (isClick) {
        //屏蔽快速点击
        return;
    }
    [self hiddenShareView];
    if ([shareDelegate respondsToSelector:@selector(shareViewForClickActionAtIndex:)]) {
        [shareDelegate shareViewForClickActionAtIndex:(int)btn.tag];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view !=self) {
        return NO;
    }
    return YES;
}
-(void)dealloc{
    shareDelegate = nil;
    [showView release];
    [super dealloc];
}
@end
