//
//  NSMutableArray+Shuffle.m
//  SlidingPuzzle
//
//  Created by bo LI on 10/28/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

@end
