//
//  UIFont+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIFont+FlatUI.h"
#import <CoreText/CoreText.h>

@implementation UIFont (FlatUI)

+ (UIFont *)flatFontOfSize:(CGFloat)size {
    static UIFont          *flatFont = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Regular" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
        
        flatFont = [UIFont fontWithName:@"Lato-Regular" size:size];
    });
    
    return flatFont;
}

+ (UIFont *)boldFlatFontOfSize:(CGFloat)size {
    static UIFont *boldFont = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Bold" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
        
        boldFont = [UIFont fontWithName:@"Lato-Bold" size:size];
    });

    return boldFont;
}

+ (UIFont *)italicFlatFontOfSize:(CGFloat)size {
    static UIFont          *italicFont = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Italic" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
        
        italicFont = [UIFont fontWithName:@"Lato-Italic" size:size];
    });
    
    return italicFont;
}

@end
