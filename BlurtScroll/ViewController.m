//
//  ViewController.m
//  BlurtScroll
//
//  Created by Mike Place on 3/13/13.
//  Copyright (c) 2013 Super Top Secret. All rights reserved.
//

#import "ViewController.h"
#import "Magnifier.h"
#import "PercentageMath.h"
#import "DebuggingLabels.h"

#define CELL_HEIGHT 100

#define STANDARD_LABEL_FONT_SIZE  10
#define MAGNIFIED_LABEL_FONT_SIZE  50

#define MAGNIFIER_HEIGHT 100
#define MAGNIFIER_UPPER_BOUND 200
#define MAGNIFIER_LOWER_BOUND 300

#define MAGNIFIER_LABEL_HEIGHT 40

#define MAGNIFY_STRENGTH 1.3f

#define DEBUG 1

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scroll;
@property (nonatomic, strong) UIView* magnifier;
@property (nonatomic, strong) UILabel* magnifierLabel;

@property (nonatomic, retain) NSMutableArray *items;

@property (nonatomic, assign) int lastContentOffset;

@property (nonatomic) ScrollDirection direction; // True is up, false is down

#if DEBUG
@property (nonatomic, strong) OffsetLabel* offsetLabel;
@property (nonatomic, strong) ScrollOffsetLabel* scrollOffsetLabel;
@property (nonatomic, strong) TargetOffsetLabel* targetOffsetLabel;
@property (nonatomic, strong) DisplayedCellId* displayedCellId;
#endif

@end

@implementation ViewController

@synthesize items;

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self scroll];
    
}

-(UIScrollView*)scroll
{
    if (!_scroll){
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _scroll = [[UIScrollView alloc] initWithFrame:frame];
        _scroll.backgroundColor = [UIColor clearColor];
        _scroll.delegate = self;
        _scroll.pagingEnabled = NO;
        [_scroll setContentSize:CGSizeMake(self.view.frame.size.width, 1000 * 100)];
        [self fakeData];
        [self.view addSubview:_scroll];
        [self.view addSubview:[self maginfier]];
        
    
#if DEBUG
        
        self.offsetLabel = [[OffsetLabel alloc]init];
        self.scrollOffsetLabel = [[ScrollOffsetLabel alloc]init];
        self.targetOffsetLabel = [[TargetOffsetLabel alloc]init];
        self.displayedCellId = [[DisplayedCellId alloc]init];
        
        [self.view addSubview:self.offsetLabel];
        [self.view addSubview:self.scrollOffsetLabel];
        [self.view addSubview:self.targetOffsetLabel];
        [self.view addSubview:self.displayedCellId];
#endif
        
    }
    return _scroll;
}

-(UIView*)maginfier
{
    if(!_magnifier) {
        CGRect frame = CGRectMake(0, MAGNIFIER_UPPER_BOUND, self.view.frame.size.width, MAGNIFIER_HEIGHT);
        
        _magnifier = [[Magnifier alloc] initWithFrame:frame];
        
        NSLog(@"Bounds: %@", NSStringFromCGRect(_magnifier.bounds));
        NSLog(@"Frame: %@", NSStringFromCGRect(_magnifier.frame));
        _magnifier.backgroundColor = [UIColor grayColor];
        
        [_magnifier setClipsToBounds:YES]; // Must be set through method, not setter. (Thanks Apple, you bastards.)
        [_magnifier addSubview:[self magnifierLabel]];
        
        
    }
    return _magnifier;
}

-(UILabel*)magnifierLabel
{
    if(!_magnifierLabel) {
        _magnifierLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.magnifier.frame.size.width, MAGNIFIER_LABEL_HEIGHT)];
        _magnifierLabel.backgroundColor= [UIColor clearColor];
        _magnifierLabel.text = @"2";
        _magnifierLabel.textAlignment = NSTextAlignmentCenter;
        _magnifierLabel.font = [_magnifierLabel.font fontWithSize:MAGNIFIED_LABEL_FONT_SIZE];
    }
    return _magnifierLabel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)fakeData
{
    self.items = [NSMutableArray array];
    
    UILabel* label = nil;
    
    int y=0;
    for (int i = 0; i < 1000; i++)
    {
        CGRect frame = CGRectMake(0, y, self.view.frame.size.width, 100);
        y += 100;
        
        UIView* view = [[UIScrollView alloc]initWithFrame:frame];
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        [label setText:[NSString stringWithFormat:@"%i", i]];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1;
        label.font = [label.font fontWithSize:STANDARD_LABEL_FONT_SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        view.backgroundColor = [self genRandomColor];
//        view.backgroundColor = [UIColor clearColor];
        
        [view addSubview:label];
        [self.scroll addSubview:view];
    }
}

-(UIColor*)genRandomColor
{
    // https://gist.github.com/kylefox/1689973
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}



#pragma mark -

#pragma mark UIScrollViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    int frameId = ((offset.y - 50)/ CELL_HEIGHT) + 3;

#if DEBUG
    NSLog(@"Scroll offset: %i", (int) offset.y);
    self.scrollOffsetLabel.text  = [NSString stringWithFormat:@"%@ %f", @"SCROLL OFFSET: ", offset.y];
#endif
    
    int cellOffset = ( ((int)offset.y + 50) % 100); // This range is 0 - 100. A 50 indicates the cell is at rest and aligned, a 100 indicates that the cell is at the top of its range.
    
#if DEBUG
    self.offsetLabel.text = [NSString stringWithFormat:@"%@ %i", @"CELL OFFSET:", cellOffset];
    self.displayedCellId.text = [NSString stringWithFormat:@"%@ %d", @"CELL ID: ", frameId];
#endif

    float targetPoint = ValueBetweenByPercent(cellOffset, 0, 100, 100, -40);

    CGRect frame = self.magnifierLabel.frame;
    
#if DEBUG
    NSLog(@"Target offset: %f", targetPoint);
#endif
    
    self.targetOffsetLabel.text = [NSString stringWithFormat:@"%@ %f", @"TARGET OFFSET:", targetPoint];
    frame.origin.y = targetPoint;
    
    
    self.magnifierLabel.frame = frame;
    
    
    self.magnifierLabel.text = [NSString stringWithFormat:@"%i", frameId];
    
    ScrollDirection scrollDirection;
    if (self.lastContentOffset > scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionUp;
    else if (self.lastContentOffset < scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionDown;
    
    self.lastContentOffset = scrollView.contentOffset.y;
    
    self.direction = scrollDirection;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int targetFrameId = 0;
    if (self.direction == ScrollDirectionUp){
        targetFrameId =  (scrollView.contentOffset.y / CELL_HEIGHT)-1;
    } else {
        targetFrameId =  (scrollView.contentOffset.y / CELL_HEIGHT);
    }
    
    
    CGPoint targetPoint = CGPointMake(0, (targetFrameId * CELL_HEIGHT ));
    [scrollView setContentOffset:targetPoint animated:YES];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int targetFrameId = 0;
    if (self.direction == ScrollDirectionUp){
        targetFrameId =  (scrollView.contentOffset.y / CELL_HEIGHT)-1;
    } else {
        targetFrameId =  (scrollView.contentOffset.y / CELL_HEIGHT);
    }
    
    
    CGPoint targetPoint = CGPointMake(0, (targetFrameId * CELL_HEIGHT));
    [scrollView setContentOffset:targetPoint animated:YES];
}


@end
