//
//  HXShareView.h
//  information
//
//  Created by MING.Z on 13-2-7.
//  Copyright (c) 2013年 MING.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

#define bgClolor [UIColor colorWithRed:0.89   green:0.89 blue:0.89 alpha:1]
#define bgNightClolor [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1]
#define titelClolor [UIColor blackColor]
#define titelNightClolor [UIColor lightGrayColor]
//默认的分享名称和图片 可以自定义

#define SHARENAME [NSMutableArray arrayWithObjects:@"和讯微博",@"新浪微博",@"腾讯微博",@"微信好友",@"微信朋友圈",@"短信",@"邮件", nil]
#define SHAREIMAGE [NSMutableArray arrayWithObjects:@"HXWeiBo",@"SinaWeiBo",@"QQWeiBo",@"WeiXin",@"pengyouquan",@"HXSMS",@"HXMail", nil]
@class ZDMShareView;
@protocol ZDMShareViewDelegate <NSObject>
- (void)shareViewForClickActionAtIndex:(int)index;

@end
@interface ZDMShareView : UIView<UIGestureRecognizerDelegate>
{
    //显示标题@"分享到";
    NSString *titel;
    //每行显示几列;默认4列
    int columnNumber;
    //显示分享去处的名字:例:新浪微博
    NSMutableArray *showName;
    //分享图标的名字(必须png格式):@"sina"(注:夜间模式对应的名字必须为@"sina-night")80*80
    NSMutableArray *ImageName;
    //isNight==yes,夜间模式
    BOOL isNight;
    //是否已经展示
    BOOL isShow;
}
@property (nonatomic,retain) NSString *titel;
@property (nonatomic,retain) NSMutableArray *showName;
@property (nonatomic,retain) NSMutableArray *ImageName;
@property (nonatomic,assign) id<ZDMShareViewDelegate>shareDelegate;
@property (nonatomic,assign) int columnNumber;
@property (nonatomic,assign) BOOL isNight;
@property (nonatomic,assign) BOOL isShow;

//初始化数据
-(id)initWithFrame:(CGRect)frame ColumnNumber:(int)column withName:(NSMutableArray*)_name withImage:(NSMutableArray*)_image withNight:(BOOL)_night;
//创建显示的view
-(void)buildShowShareView;
//显示view
-(void)showShareView;
//隐藏view
-(void)hiddenShareView;

@end
