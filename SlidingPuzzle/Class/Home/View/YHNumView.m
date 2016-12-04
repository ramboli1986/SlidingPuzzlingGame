//
//  YHNumView.m
//  SlidingPuzzle
//
//  Created by bo LI on 10/28/16.
//  Copyright © 2016 bo LI. All rights reserved.
//

#import "YHNumView.h"


@implementation YHNumView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.label = [[UILabel alloc]init];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        [self addSubview:self.label];
    }
    

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (![self.numberStr isEqualToString:@""]) {
        self.backgroundColor = [UIColor blueColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    CGFloat width = self.bounds.size.width;
    self.label.frame = CGRectMake(0, 0, width, width);
    self.label.text = self.numberStr;
    //self.label.backgroundColor = [UIColor greenColor];
}

- (void) tapView:(UITapGestureRecognizer*)sender {
    //NSLog(@"xxx");
}

@end
