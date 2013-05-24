//
//  UIProgressView+FlatUI.h
//  FlatUITestProj
//
//  Created by Alex Medearis on 5/16/13.
//  Copyright (c) 2013 Alex Medearis. All rights reserved.
//

#import "UIImage+FlatUI.h"


@implementation UIProgressView (FlatUI)

- (void) configureFlatProgressViewWithTrackColor:(UIColor *)trackColor
                                   progressColor:(UIColor *)progressColor {
    
    UIImage *progressImage = [UIImage imageWithColor:progressColor cornerRadius:4.0];
    UIImage *trackImage = [[UIImage imageWithColor:trackColor cornerRadius:4.0]
                           imageWithMinimumSize:CGSizeMake(10, 10)];
    
    self.trackImage = trackImage;
    self.progressImage = progressImage;
    
}
@end
