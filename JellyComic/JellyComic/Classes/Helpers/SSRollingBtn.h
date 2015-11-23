//
//  SSRollingBtn.h
//  JellyComic
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    DirectionLeft,
    DirectionRigth,
}SSRollingDirection;

@interface SSRollingBtn : UIButton


@property(nonatomic,assign)BOOL isRuned;
@property(nonatomic,assign)BOOL running;
@property(nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong) NSString *textString;
@property(nonatomic) float rollingSpeed;
@property(nonatomic) BOOL loops;
@property(nonatomic) SSRollingDirection direction;
-(void)start;


@end
