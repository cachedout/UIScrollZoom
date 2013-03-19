//
//  Magnifier.m
//  BlurtScroll
//
//  Created by Mike Place on 3/14/13.
//  Copyright (c) 2013 Super Top Secret. All rights reserved.
//

#import "Magnifier.h"

@implementation Magnifier

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self setClipsToBounds: YES];
    }

    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = NO;
    return pointInside;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
