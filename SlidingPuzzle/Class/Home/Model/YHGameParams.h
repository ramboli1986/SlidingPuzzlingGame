//
//  YHGameParams.h
//  SlidingPuzzle
//
//  Created by bo LI on 10/29/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHGameParams : NSObject

@property (nonatomic, strong) NSMutableArray* nums;

@property (nonatomic, strong) NSMutableArray* numsPadViews;

@property (nonatomic, assign) NSInteger padSize;

@property (nonatomic, assign) NSInteger shuffleTime;

@property (nonatomic, strong) UIViewController* vc;

@property (nonatomic, assign) NSInteger margin;

@property (nonatomic, assign) NSInteger singleMargin;

@end
