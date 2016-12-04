//
//  YHGameTools.m
//  SlidingPuzzle
//
//  Created by bo LI on 10/29/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import "YHGameTools.h"
#import "YHNumView.h"
#import "YHGameParams.h"

@implementation YHGameTools

static YHGameTools* _instance;

+ (instancetype)tools {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (BOOL) checkDone {
    for (int i = 0; i < self.params.padSize*self.params.padSize-1; i++) {
        //NSLog(@"%zd",[self.nums[i] integerValue]);
        if ([self.params.nums[i] integerValue] != i+1) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) ifMovable:(NSString*)tag{
    NSInteger pos = [self.params.nums indexOfObject:tag];
    NSInteger x = pos/self.params.padSize;
    NSInteger y = pos%self.params.padSize;
    if (x + 1 < self.params.padSize) {
        NSInteger tmp = (x+1)*self.params.padSize + y;
        if ([self.params.nums[tmp] isEqualToString:@""]) {
            return YES;
        }
    }
    if (x - 1 >= 0) {
        NSInteger tmp = (x-1)*self.params.padSize + y;
        if ([self.params.nums[tmp] isEqualToString:@""]) {
            return YES;
        }
    }
    if (y + 1 < self.params.padSize) {
        NSInteger tmp = (x)*self.params.padSize + y+1;
        if ([self.params.nums[tmp] isEqualToString:@""]) {
            return YES;
        }
    }
    if (y - 1 >= 0) {
        NSInteger tmp = x*self.params.padSize + y-1;
        if ([self.params.nums[tmp] isEqualToString:@""]) {
            return YES;
        }
    }
    return NO;
}


- (void) shuffleArray:(NSMutableArray*)arr {
    NSInteger times = self.params.shuffleTime;
    while (times--) {
        NSInteger blankIndex = [arr indexOfObject:@""];
        
        NSArray* neigbors = [self findBlankNeighbors:arr];
        NSInteger randIndex = arc4random()%neigbors.count;
        //NSInteger neiIndex = [arr indexOfObject:neigbors[randIndex+1]];
        NSInteger neiIndex = [neigbors[randIndex] integerValue];
        [arr exchangeObjectAtIndex:blankIndex withObjectAtIndex:neiIndex];
    }
}

- (NSArray*) findBlankNeighbors:(NSMutableArray*)arr{
    NSInteger pos = [arr indexOfObject:@""];
    NSMutableArray* res = [NSMutableArray array];
    
    NSInteger x = pos/self.params.padSize;
    NSInteger y = pos%self.params.padSize;
    if (x + 1 < self.params.padSize) {
        NSInteger tmp = (x+1)*self.params.padSize + y;
        [res addObject:[NSString stringWithFormat:@"%zd", tmp]];
    }
    if (x - 1 >= 0) {
        NSInteger tmp = (x-1)*self.params.padSize + y;
        [res addObject:[NSString stringWithFormat:@"%zd", tmp]];
    }
    if (y + 1 < self.params.padSize) {
        NSInteger tmp = (x)*self.params.padSize + y+1;
        [res addObject:[NSString stringWithFormat:@"%zd", tmp]];
    }
    if (y - 1 >= 0) {
        NSInteger tmp = x*self.params.padSize + y-1;
        [res addObject:[NSString stringWithFormat:@"%zd", tmp]];
    }
    
    
    return res;
}

- (void) exchangeNumPadWithBlankPos:(NSInteger)blankPos curPos:(NSInteger)curPos {
    YHNumView* blankView = self.params.numsPadViews[blankPos];
    YHNumView* curView = self.params.numsPadViews[curPos];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect curFrame = curView.frame;
        curView.frame = blankView.frame;
        blankView.frame = curFrame;
    } completion:^(BOOL finished) {
        //exchange view
        [self.params.numsPadViews exchangeObjectAtIndex:blankPos withObjectAtIndex:curPos];
        //exchange array
        [self.params.nums exchangeObjectAtIndex:blankPos withObjectAtIndex:curPos];
        //check if finish
        if ([[YHGameTools tools] checkDone]) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Congratulations"
                                                                           message:@"You Win!"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                            
                                                                      [self.delegate reset];
                                                                      
                                                                  }];
            
            [alert addAction:defaultAction];
            [self.params.vc presentViewController:alert animated:YES completion:nil];
        }
    }];
}




@end
