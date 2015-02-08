# MSSlidingPanelController Changelog
## [1.3.5](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.5) (Sunday, February 8th, 2015)
### Modify
- The README image is loaded from a new location (branch `assets`).

## [1.3.4](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.4) (Saturday, July 26th, 2014)
### Fixed
- Fixed a bug which called the delegate method `slidingPanelController:hasClosedSide:` when a panel begin to be open. Thanks to [@kajensen](https://github.com/kajensen) to discover this bug.

## [1.3.3](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.3) (Sunday, July 13th, 2014)
### New
- Added a remark in documentation about the usage of MSSlidingPanelController in others containers.

### Removed
- Removed the fix appeared with release [1.3.2.](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.2). This one didn't work correctly in some cases. It is now advised to adjust your controller in function of your need.

## [1.3.2](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.2) (Tuesday, April 22nd, 2014)
### New
- Examples are now compiled with *-Wall* *-Wextra* flags.

### Fixed
- Fixed a glitch when the sliding panel was inside a `UITabBarController` and contained a `UINavigationController`. Bug discovered thanks to [@nemesyssoft](https://github.com/nemesyssoft)'s question (issue [#8](https://github.com/SebastienMichoy/MSSlidingPanelController/issues/8)).

## [1.3.1](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.1) (Tuesday, March 25th, 2014)
### Fixed
- Fixed warnings which can appear with *-Wall* *-Wextra* flags.
- Fixed warnings which occurred when it misses a newline at end of files. Thanks to Ronnie Liew ([@ronnieliew](https://github.com/ronnieliew)) for his contribution.

## [1.3.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.0) (Thursday, March 20th, 2014)
### New
- Travis-CI support is there. Thanks to Jens Kohl ([@jk](https://github.com/jk)) for his contribution.
- Added a new method in the @protocol which allows to work with multiple gesture recognizers (issue [#1](https://github.com/SebastienMichoy/MSSlidingPanelController/issues/1)).
- BSD license added in every files' header.

### Comment
- Tag has been moved (initial release Wednesday, March 12th, 2014).

## [1.2.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.2.0) (Saturday, March 1st, 2014)
- Update the version number to follow the [semantic versioning](http://semver.org).

## [1.1.2](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.1.2) (Friday, February 28th, 2014)
### New
- It is now possible to use **MSSlidingPanelController** with *Storyboard*.
- A new example using *Storyboard* has been added.

## [1.1.1](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.1.1) (Wednesday, January 29th, 2014)
### New
- Added a script to update the build number of exemples.

### Fixed
- Fixed a false positive warning reported by clang analyzer.

## [1.1.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.1.0) (Thursday, January 16th, 2014)
### New
- It now possible to add a completion block when we change the maximum width of panels.

## [1.0.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.0.0) (Wednesday, January 8th, 2014)
- Initial release.
