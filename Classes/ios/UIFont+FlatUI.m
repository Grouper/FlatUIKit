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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Regular" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
    });
    return [UIFont fontWithName:@"Lato-Regular" size:size];
}

+ (UIFont *)boldFlatFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Bold" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
    });
    return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)italicFlatFontOfSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"Lato-Italic" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
    });
    return [UIFont fontWithName:@"Lato-Italic" size:size];
}

@end
