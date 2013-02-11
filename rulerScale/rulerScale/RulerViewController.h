//
//  RulerViewController.h
//  rulerScale
//
//  Created by Gaurav Gautam on 11/02/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulerViewController : UIViewController<UIScrollViewAccessibilityDelegate>{
    
    IBOutlet UIScrollView *scrollView1;
    
    int scaleCount;
    
    IBOutlet UILabel *lblWeight;
    
}

@property (nonatomic, retain) UIView *scrollView1;


@end
