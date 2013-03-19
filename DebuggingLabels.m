//
//  DebuggingLabels.m
//  BlurtScroll
//
//  Created by Mike Place on 3/18/13.
//  Copyright (c) 2013 Super Top Secret. All rights reserved.
//

#import "DebuggingLabels.h"



@implementation ScrollOffsetLabel

-(UILabel*)init
{
    self = [super initWithFrame:CGRectMake(0,0,140,10)];
    self.backgroundColor = [UIColor clearColor];
    self.text = @"SCROLL OFFSET";
    self.font = [self.font fontWithSize:8];
    
    return self;
}
@end

@implementation OffsetLabel

-(UILabel*)init
{
    self = [super initWithFrame: CGRectMake(0, 10, 80, 10)];
    self.backgroundColor = [UIColor clearColor];
    self.text = @"OFFSET";
    self.font = [self.font fontWithSize:8];
    return self;
}
@end

@implementation TargetOffsetLabel
-(UILabel*)init
{
    self = [super initWithFrame: CGRectMake(0, 20, 140, 10)];
    self.backgroundColor = [UIColor clearColor];
    self.text = @"TARGET OFFSET";
    self.font = [self.font fontWithSize:8];
    return self;
}
@end


@implementation DisplayedCellId
-(UILabel*)init
{
    self = [super initWithFrame:CGRectMake(0, 30, 140, 10)];
    self.backgroundColor = [UIColor clearColor];
    self.text = @"OFFSET";
    self.font = [self.font fontWithSize:8];

    return self;
}

@end
