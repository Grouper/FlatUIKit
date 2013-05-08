FlatUIKit
======

FlatUIKit is a collection of iOS components styled with the "Flat UI" aesthetic. It's inspired by http://designmodo.github.io/Flat-UI/ . Styling is implemented via categories on existing UIKit components when possible, meaning integrating it into your project is often as simple as:

    #import <FlatUI/FlatUI.h>
    UISlider *mySlider = [[UISlider alloc] init];
    // your existing slider code
    [mySlider configureFlatSliderWithTrackColor:[UIColor whiteColor]
                                progressColor:[UIColor redColor]
                                   thumbColor:[UIColor redColor];

How to Get Started
-------

FlatUIKit can be installed via Cocoapods.

The Components
-------

- Buttons

- Switches

- Alert Views

- Steppers

- Bar Button Items

- Navigation Bars


Colors
-------

For convenience, FlatUIKit includes the colors defined at http://designmodo.github.io/Flat-UI/ . Using them is as simple as:

    #import <FlatUIKit/UIColor+FlatUI.h>
    UIColor *myColor = [UIColor turquoiseColor];

Fonts
-------

FlatUIKit comes bundled with the Lato font, a clean, beautiful open font.