//
//  UIFont+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIFont+FlatUI.h"
#import <CoreText/CoreText.h>
#import "NSString+Icons.h"

@implementation UIFont (FlatUI)

+ (void) initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *fontNames = @[@"Lato-Regular", @"Lato-Bold", @"Lato-Italic", @"Lato-Light"];
        for (NSString *fontName in fontNames) {
            NSURL * url = [[NSBundle mainBundle] URLForResource:fontName withExtension:@"ttf"];
            if (url) {
                CFErrorRef error;
                CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
            }
        }
    });
}

+ (UIFont *)flatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lato-Regular" size:size];
}

+ (UIFont *)boldFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)italicFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lato-Italic" size:size];
}

+ (UIFont *)lightFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lato-Light" size:size];
}

+ (UIFont *)iconFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:kFlatUIFontFamilyName size:size];
}
@end
