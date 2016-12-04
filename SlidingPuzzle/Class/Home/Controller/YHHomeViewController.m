//
//  YHHomeViewController.m
//  SlidingPuzzle
//
//  Created by bo LI on 10/28/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import "YHHomeViewController.h"
#import "YHNumView.h"
#import "YHGameTools.h"
#import "YHGameInitTool.h"
#import "YHGameParams.h"


#define MARGIN 40.0f
#define SINGMARGIN 2.0f
#define PADSIZE 4
#define SHUFFLETIME 10

@interface YHHomeViewController ()<YHGameInitToolDelegate, YHGameToolsDelegate>

@property (nonatomic, strong) NSMutableArray* nums;
@property (nonatomic, strong) NSMutableArray* numsPadViews;
@property (nonatomic, strong) YHGameParams* params;

@end

@implementation YHHomeViewController

//lazy load property
- (YHGameParams*) params {
    if (_params == nil) {
        _params = [[YHGameParams alloc]init];
        _params.padSize = PADSIZE;
        _params.shuffleTime = SHUFFLETIME;
        _params.margin = MARGIN;
        _params.singleMargin = SINGMARGIN;
        _params.padSize = PADSIZE;
        _params.nums = self.nums;
        _params.numsPadViews = self.numsPadViews;
        _params.vc = self;
    }
    return _params;
}

//lazy load property
- (NSMutableArray*) nums {
    if (_nums == nil) {
        _nums = [NSMutableArray array];
        int totalNumber = PADSIZE*PADSIZE;
        for (int i = 1; i < totalNumber; i++) {
            [_nums addObject:[NSString stringWithFormat:@"%zd", i]];
        }
        [_nums addObject:@""];
        
        [YHGameTools tools].params = self.params;
        [YHGameTools tools].delegate = self;
        [[YHGameTools tools] shuffleArray:_nums];
    }
    return _nums;
}

//lazy load property
- (NSMutableArray*) numsPadViews {
    if (_numsPadViews == nil) {
        _numsPadViews = [NSMutableArray array];
    }
    return _numsPadViews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGamePad];
}

//create Game Pad
- (void) createGamePad {
    [YHGameInitTool tool].params = self.params;
    [YHGameInitTool tool].delegate = self;
    [[YHGameInitTool tool] initGamePadAtView:self.view];
}


#pragma Delegate Method
- (void) tap:(UITapGestureRecognizer*)sender {
    NSString* tag = [NSString stringWithFormat:@"%zd",sender.view.tag];
    
    if ([[YHGameTools tools] ifMovable:tag]) {
        NSLog(@"is movable");
        NSInteger blankPos = [self.nums indexOfObject:@""];
        NSInteger curPos = [self.nums indexOfObject:tag];
        NSLog(@"blank:%zd, %zd", blankPos, curPos);
        [[YHGameTools tools] exchangeNumPadWithBlankPos:blankPos curPos:curPos];
    }
}

#pragma Delegate Method
- (void) reset {
    _numsPadViews = nil;
    _nums = nil;
    _params = nil;
    [self createGamePad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
