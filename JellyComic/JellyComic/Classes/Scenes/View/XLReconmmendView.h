//
//  XLReconmmendView.h
//  ad
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLReconmmendViewController;

@interface XLReconmmendView : UIView
@property (assign) NSInteger tabCount;
- (instancetype)initWithFrame:(CGRect)frame WithCount:(NSInteger)count;

@property (nonatomic, strong) XLReconmmendViewController *xlReconmmendViewController;
@end
