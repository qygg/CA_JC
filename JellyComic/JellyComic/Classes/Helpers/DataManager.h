//
//  DataManager.h
//  JellyComic
//
//  Created by 胡智超 on 15/11/11.
//  Copyright © 2015年 胡智超. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Callback)();

@interface DataManager : NSObject

+ (instancetype)sharedDataManager;

- (void)loadScrollingImageWithCompletion:(Callback)completion;

- (void)loadHotlistWithPage:(NSInteger)page completion:(Callback)completion;

- (void)loadEditorlistWithPage:(NSInteger)page completion:(Callback)completion;

- (void)loadHothklistWithPage:(NSInteger)page completion:(Callback)completion;

- (void)loadRecentUpdateWithPage:(NSInteger)page completion:(Callback)completion;

@end








