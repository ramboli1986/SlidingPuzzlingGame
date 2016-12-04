//
//  YHGameInitTool.h
//  SlidingPuzzle
//
//  Created by bo LI on 10/29/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YHGameParams;

@protocol YHGameInitToolDelegate <NSObject>

- (void) tap:(UITapGestureRecognizer*)sender;

@end

@interface YHGameInitTool : NSObject

@property (nonatomic, weak) id<YHGameInitToolDelegate> delegate;

@property (nonatomic, strong) YHGameParams* params;

+ (instancetype)tool;
- (void) initGamePadAtView:(UIView*)view;

@end
