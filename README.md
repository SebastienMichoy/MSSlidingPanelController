# MSSlidingPanelController [![Build Status](https://travis-ci.org/SebastienMichoy/MSSlidingPanelController.png?branch=master)](https://travis-ci.org/SebastienMichoy/MSSlidingPanelController)
The `MSSlidingPanelController` is a library which allows to **easily integrate** in your **iOS 7** project a **sliding panel controller** mechanism.

<p align="center" >
<img src="http://sebastienmichoy.github.io/MSSlidingPanelController/images/MSSlidingPanelController.png" />
</p>

## Requirements
- iOS 7.0+
- ARC

## Features
### MSSlidingPanelController
Either for the left and right panel, it is possible to set:

- the width,
- the status bar color,
- the status bar color transition,
- the opening gestures,
- the closing gestures,
- the interaction with the center view.

The status bar color transition can be:

- abrupt,
- smoothly.

The panels can be opened by:

- dragging the navigation bar of the center view (if there is one),
- dragging the content of the center view.

The panels can be closed by:

- dragging the navigation bar of the center view (if there is one),
- dragging the content of the center view,
- tapping the navigation bar of the center view (if there is one),
- tapping the content of the center view.

The interactions with the center view can be:

- nonexistent,
- only with the navigation bar (if there is one),
- with the entire center view.

### MSSlidingPanelControllerDelegate
The protocol `MSSlidingPanelControllerDelegate` allows to know when:

- a panel begins to bring out,
- a panel has been closed,
- a panel has been opened.

### UIViewController (MSSlidingPanel)
This extension allows view controllers to easily get a pointer on a sliding panel controller if this one is a parent.

## Installation
There are two ways to use `MSSlidingPanelController` in your project.

The first one is to manually add these files to your project:

- MSSlidingPanelController.h
- MSSlidingPanelController.m
- MSViewControllerSlidingPanel.h (optional)
- MSViewControllerSlidingPanel.m (optional)

The second way is by using [CocoaPods](https://github.com/cocoapods/cocoapods).

```Ruby
pod 'MSSlidingPanelController'
```

## Documentation
The documentation of `MSSlidingPanelController` can be found on [CocoaDocs](http://cocoadocs.org/docsets/MSSlidingPanelController/).

## Creating a MSSlidingPanelController
That's very easy to create a `MSSlidingPanelController`. Only write this few lines *et voila*!

```Objective-C
UIViewController            *centerViewController;
UIViewController            *leftPanelController;
UIViewController            *rightPanelController;
MSSlidingPanelController    *slidingPanelController;

centerViewController = [[UIViewController alloc] init];
leftPanelController = [[UIViewController alloc] init];
rightPanelController = [[UIViewController alloc] init];

slidingPanelController = [[MSSlidingPanelController alloc] initWithCenterViewController:centerViewController
																	leftPanelController:leftPanelController
																andRightPanelController:rightPanelController];
```
You can also create it by using *Storyboard*. Take a look at the examples to see how it works!

## Credit
The library and the examples are developed and designed by [Sébastien MICHOY](http://www.linkedin.com/in/sebastienmichoy).

## Feedback
If you find a bug, feel free to create a Github issue!

## License
`MSSlidingPanelController` is available under the BSD license. Please see the LICENSE file for more information.
