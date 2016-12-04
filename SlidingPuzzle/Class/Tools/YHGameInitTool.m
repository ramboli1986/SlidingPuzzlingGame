//
//  YHGameInitTool.m
//  SlidingPuzzle
//
//  Created by bo LI on 10/29/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import "YHGameInitTool.h"
#import "YHNumView.h"
#import "YHGameParams.h"

@interface YHGameInitTool ()
@property (nonatomic, strong) UIView* padView;
@end

@implementation YHGameInitTool
static YHGameInitTool* _instance;

+ (instancetype)tool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (void) initGamePadAtView:(UIView *)view {
    CGFloat width = view.bounds.size.width - 2*self.params.margin;
    [self.padView removeFromSuperview];
    self.padView = [[UIView alloc] initWithFrame:CGRectMake(self.params.margin, self.params.margin, width, width)];
    self.padView.backgroundColor = [UIColor yellowColor];
    CGFloat numPadSize = (view.bounds.size.width - 2*self.params.margin)/self.params.padSize - self.params.singleMargin;
    [self addNumPadInView:self.padView numPadSize:numPadSize];
    [view addSubview:self.padView];
    
}

- (void) addNumPadInView:(UIView*)padView numPadSize:(CGFloat)numPadSize{
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    NSInteger k = 0;
    for (NSInteger i = 0; i < self.params.padSize; i++) {
        for (NSInteger j = 0; j < self.params.padSize; j++) {
            x = j*(numPadSize + self.params.singleMargin);
            y = i*(numPadSize + self.params.singleMargin);
            CGRect frame = CGRectMake(x, y, numPadSize, numPadSize);
            [self addSingleNumPadWithFrame:frame number:self.params.nums[k++] atView:padView];
            
        }
    }
}

- (void) addSingleNumPadWithFrame:(CGRect)frame number:(NSString*)number atView:(UIView*)padView{
    //YHNumView* numview = [[YHNumView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    YHNumView* numView = [[YHNumView alloc]initWithFrame:frame];
    numView.tag = [number integerValue];
    if (![number isEqual:@""]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [numView addGestureRecognizer:tap];
    }
    numView.numberStr = number;
    [self.params.numsPadViews addObject:numView];
    [padView addSubview:numView];
    
}

- (void) tapView:(UITapGestureRecognizer*)sender {
    [self.delegate tap:sender];
}


@end
