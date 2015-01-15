//
//  NSString+Icons.m
//  FlatUIKitExample
//
//  Created by Jamie Matthews on 12/24/14.
//
// Credit to https://github.com/designmodo/Flat-UI
// for the aweseome flat icons!

#import "NSString+Icons.h"


@implementation NSString (Icons)
+ (NSString*)iconStringForEnum:(FlatUIIcon)value {
    NSString *toReturn = [NSString iconUnicodeStrings][value];
    return toReturn;
}

+ (NSArray *)iconUnicodeStrings {
    
    static NSArray *iconUnicodeStrings;
    
    static dispatch_once_t unicodeStringsOnceToken;
    dispatch_once(&unicodeStringsOnceToken, ^{
        
        iconUnicodeStrings = @[@"\ue600", @"\ue601", @"\ue602", @"\ue603", @"\ue604", @"\ue605", @"\ue606", @"\ue607", @"\ue608", @"\ue609", @"\ue60a", @"\ue60b", @"\ue60c", @"\ue60d", @"\ue60e", @"\ue60f", @"\ue610", @"\ue611", @"\ue612", @"\ue613", @"\ue614", @"\ue615", @"\ue616", @"\ue617", @"\ue618", @"\ue619", @"\ue61a", @"\ue61b", @"\ue61c", @"\ue61d", @"\ue61e", @"\ue61f", @"\ue620", @"\ue621", @"\ue622", @"\ue623", @"\ue624", @"\ue625", @"\ue626", @"\ue627", @"\ue628", @"\ue629", @"\ue62a", @"\ue62b", @"\ue62c", @"\ue62d", @"\ue62e", @"\ue62f", @"\ue630", @"\ue631", @"\ue632", @"\ue633", @"\ue634", @"\ue635", @"\ue636", @"\ue637", @"\ue638", @"\ue639", @"\ue63a", @"\ue63b", @"\ue63c", @"\ue63d", @"\ue63e", @"\ue63f", @"\ue640", @"\ue641", @"\ue642", @"\ue643", @"\ue644", @"\ue645", @"\ue646", @"\ue647", @"\ue648", @"\ue649", @"\ue64a", @"\ue64b", @"\ue64c", @"\ue64d", @"\ue64e", @"\ue64f", @"\ue650", @"\ue651", @"\ue652", @"\ue653", @"\ue654", @"\ue655", @"\ue656", @"\ue657", @"\ue658", @"\ue659", @"\ue65a", @"\ue65b", @"\ue65c", @"\ua65d", @"\ue65e", @"\ue65f", @"\ue660"];
        
    });
    
    return iconUnicodeStrings;
}

@end
