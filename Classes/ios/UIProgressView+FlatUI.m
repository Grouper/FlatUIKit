//
//  UIProgressView_FlatUI.h
//  FlatUITestProj
//
//  Created by Alex Medearis on 5/16/13.
//  Copyright (c) 2013 Bazaarvoice. All rights reserved.
//

#import "UIImage+FlatUI.h"


@implementation UIProgressView (FlatUI)

- (void) configureFlatSliderWithTrackColor:(UIColor *)trackColor
                             progressColor:(UIColor *)progressColor {
    
    
    UIImage *progressImage = [[UIImage imageWithColor:progressColor cornerRadius:5.0]
                              imageWithMinimumSize:CGSizeMake(10, 10)];
    UIImage *trackImage = [[UIImage imageWithColor:trackColor cornerRadius:5.0]
                           imageWithMinimumSize:CGSizeMake(10, 10)];
    
    self.trackImage = trackImage;
    self.progressImage = progressImage;
}
@end
