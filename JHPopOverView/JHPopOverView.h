//
//  JHPopOverView.h
//  JHPopOverView
//
//  Created by Jon Hocking on 03/04/2012.
//  Copyright (c) 2012 Jon Hocking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHPopOverView : UIView{

    UIBezierPath *mOuterPath;
    UIBezierPath *mInnerPath;
    
    CGFloat mXPeak;
    CGFloat mYPeak;
    CGFloat mPeakWidth;
    CGFloat mPeakHeight;
    CGFloat mCornerRadius;
    CGFloat mShadowRadius;
    
}


@end
