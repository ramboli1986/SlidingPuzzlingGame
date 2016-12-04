//
//  YHGameTools.h
//  SlidingPuzzle
//
//  Created by bo LI on 10/29/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YHGameParams;
@protocol YHGameToolsDelegate <NSObject>

- (void)reset;

@end

@interface YHGameTools : NSObject

@property (nonatomic, weak) id<YHGameToolsDelegate> delegate;

@property (nonatomic, strong) YHGameParams* params;

- (BOOL) ifMovable:(NSString*)tag;

- (BOOL) checkDone;

- (void) shuffleArray:(NSMutableArray*)arr;

- (void) exchangeNumPadWithBlankPos:(NSInteger)blankPos curPos:(NSInteger)curPos;

+ (instancetype) tools;

@end
