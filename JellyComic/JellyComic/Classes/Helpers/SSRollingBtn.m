//
//  SSRollingBtn.m
//  JellyComic
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import "SSRollingBtn.h"
#import <QuartzCore/QuartzCore.h>

@implementation SSRollingBtn

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.isRuned = NO;
    }
    return self;
}

-(void)setupView{
    //设置默认背景颜色
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:YES];
    
    //添加滚动内容label
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_contentLabel setBackgroundColor:[UIColor clearColor]];
    [_contentLabel setNumberOfLines:1];
    
    //[_contentLabel setFont:font];
    [self addSubview:_contentLabel];
    //是否重复
    self.loops = YES;
    //滚动方向
    self.direction = DirectionLeft;
}
-(void)animateCurrentTickerString{
    NSString *currentString = self.textString;
    
    //Calculate the size of the text and update the frame size of the ticker label
    CGRect textRect = [currentString boundingRectWithSize:CGSizeMake(9999, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_contentLabel.font,NSFontAttributeName, nil] context:nil];
    // Setup some starting and end points
    float staringX = 0.0f;
    float endX = 0.0f;
    switch (self.direction) {
        case DirectionRigth:
            staringX = -textRect.size.width;
            endX = self.frame.size.width;
            break;
        case DirectionLeft:
            staringX = self.frame.size.width;
            endX = -textRect.size.width;
        default:
            break;
    }
    // Set starting position
    [_contentLabel setFrame:CGRectMake(staringX, _contentLabel.frame.origin.y, textRect.size.width, self.frame.size.height)];
    
    // Set the string
    [_contentLabel setText:currentString];
    
    // Calculate a uniform duration for the item
    float duration = (textRect.size.width + self.frame.size.width) / self.rollingSpeed;
    // Create a UIView animation
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(tickerMoveAnimationDidStop:finish:context:)];
    
    // Update end position
    CGRect tickerFrame = _contentLabel.frame;
    tickerFrame.origin.x = endX;
    [_contentLabel setFrame:tickerFrame];
    
    [UIView commitAnimations];
}
-(void)tickerMoveAnimationDidStop:(NSString *)animationID finish:(NSNumber *)finish context:(void *)context{
    //Check if we should loop
    if (!self.loops) {
        _running = NO;
        return;
    }
    [self animateCurrentTickerString];
}

#pragma mark - Ticker Animation handling
-(void)start{
    [self.layer removeAllAnimations];
    
    _isRuned = YES;
    // Set running
    _running = YES;
    
    //Start the animation
    [self animateCurrentTickerString];
}



@end
