//
//  UIBarButtonItem+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/8/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FlatUI)

// styles a single bar button item
- (void) configureFlatButtonWithColor:(UIColor *)color
                     highlightedColor:(UIColor *)highlightedColor
                         cornerRadius:(CGFloat) cornerRadius UI_APPEARANCE_SELECTOR;

// styles all bar button items that exist within a class heirarchy (same as UIAppearanceProxy methods)
+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius
                       whenContainedIn:(Class <UIAppearanceContainer>)containerClass, ... NS_REQUIRES_NIL_TERMINATION;

// styles all bar button items (can be overwritten with the above methods)
+ (void) configureFlatButtonsWithColor:(UIColor *) color
                      highlightedColor:(UIColor *)highlightedColor
                          cornerRadius:(CGFloat) cornerRadius;


// removes the text shadows off a single bar button item (sadly, this can't be easily done for all buttons simultaneously)
- (void) removeTitleShadow;

// sets the title color in normal and highlighted control states and optionally
// removes the title shadow
- (void) setTitleColor:(UIColor *) aColor
           highlighted:(UIColor *) aHighlightedColor
          removeShadow:(BOOL) aRemoveShadow;


#pragma mark - iOS Style Back Button for iOS 5 + 6

/**
 returns an iOS 7 style bar button item (blue cheveron)
 
 should only be used on iOS < 7 (use the iOS 7 default if you want iOS 7 look and feel)
 
 @param aChevronColorNil color of the chevron; if nil is set to Apple iOS 7 blue
 @return a bar button item with no title in the style of iOS 7
 */
+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithChevronColor:(UIColor *) aChevronColorOrNil;


/**
 returns an iOS 7 style bar button item (blue cheveron)
 
 should only be used on iOS < 7 (use the iOS 7 default if you want iOS 7 look and feel)
 
 NB: shadows are removed from the title
 
 @param aTitleOrNil title of button; if nil then it will default to 'Back' in (like iOS 7)
 @param aChevronColorNil color of the chevron; if nil is set to Apple iOS 7 blue
 @param aTitleColorOrNil color of title in control state normal; if nil defaults
 to blue and if title is nil, this is ignored
 @param aHighlightedColorOrNil color of title in control state highlighted; if nil defaults
 to white and if title is nil, this is ignored
 @return a bar button item in the style of iOS 7
 */
+ (UIBarButtonItem *) barButtonItem_iOS7_styleWithTitle:(NSString *) aTitleOrNil
                                           chevronColor:(UIColor *) aChevronColorOrNil
                                             titleColor:(UIColor *) aTitleColorOrNil
                                       highlightedColor:(UIColor *) aHighlightedColorOrNil;

@end
