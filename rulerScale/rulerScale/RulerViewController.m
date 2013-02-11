//
//  RulerViewController.m
//  rulerScale
//
//  Created by Gaurav Gautam on 11/02/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//
#import "RulerViewController.h"


@interface RulerViewController ()

@end

@implementation RulerViewController

@synthesize scrollView1;

const CGFloat kScrollObjHeight	= 199.0;
const CGFloat kScrollObjWidth	= 1.0;
const NSUInteger kNumImages		= 150;

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [scrollView1 subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0.0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth+14.0);
            
		}
        else if ([view isKindOfClass:[UILabel class]]){
            
            CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc-43.0, 20);
			view.frame = frame;

        }
	} //Gaurav
    
   	// set the content size so it can be scrollable
	[scrollView1 setContentSize:CGSizeMake((kNumImages * (kScrollObjWidth+14.0)),scrollView1.frame.size.height)]; //Gaurav
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    

	[scrollView1 setBackgroundColor:[UIColor clearColor]];
	[scrollView1 setCanCancelContentTouches:NO];
	scrollView1.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView1.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView1.scrollEnabled = YES;
    
    scaleCount = 50.0;
	

	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		NSString *imageName = [NSString stringWithFormat:@"black_line.png"];
        
        if (i%11==0 || i == 1) {
            imageName = [NSString stringWithFormat:@"bold.png"];
        }
        
        
        
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image]; 
		CGRect rect = imageView.frame;
		rect.size.height = 10.0;
		rect.size.width = 1.0;
        
        if (i%10==0 || i == 1) {
            rect.size.height = 20.0;
        }
        
        
        
		imageView.frame = rect;
		imageView.tag = i;	
		[scrollView1 addSubview:imageView];
        
        if (i%10==0 || i == 1) {
            
            UILabel *lblVal = [[UILabel alloc] init];
            
            [lblVal setTextAlignment:NSTextAlignmentCenter];
            
            [lblVal setText:[NSString stringWithFormat:@"%d", scaleCount]];
            scaleCount = scaleCount+50;
            
            [lblVal setFrame:CGRectMake(0.00, 0.00, 60.0, 35.0)];
            
            [lblVal setFont:[UIFont boldSystemFontOfSize:30.0]];
            
            [lblVal setBackgroundColor:[UIColor clearColor]];
            
            [scrollView1 addSubview:lblVal];
 
        }
    
	}
	
	[self layoutScrollImages];	// now create scale
    
    [self calculateWeight]; //Calculate inital value
	
	
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) calculateWeight{
    
    CGFloat scale = (CGFloat) 1.0 / scrollView1.zoomScale;
    
    CGRect visibleRect;
    visibleRect.origin = scrollView1.contentOffset;
    visibleRect.size = scrollView1.bounds.size;
    
    float theScale = 1.0 / scale;
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
    
    float var1 = ceil((visibleRect.origin.x+visibleRect.size.width)/2);
    
    float var2 = var1/15.0;
    
    int weight = floor(var2*10);
    
    if (weight%5 !=0) {
        
        int temp1 = weight%5;
        
        weight = weight+(5-temp1);
        
    }
    
    [lblWeight setText:[NSString stringWithFormat:@"%d",weight+5]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self calculateWeight];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self calculateWeight];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self calculateWeight];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self calculateWeight];
}





@end
