# MSSlidingPanelController Changelog
## [1.3.2.](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.2) (Monday, April 21th, 2014)
### New
- Examples are now compiled with *-Wall* *-Wextra* flags.

### Fixed
- **FIXED** a glitch when the sliding panel was inside a UITabBarController and contained a UINavigationController. Bug discovered thanks to [@nemesyssoft](https://github.com/nemesyssoft)'s question (issue [#8](https://github.com/SebastienMichoy/MSSlidingPanelController/issues/8)).
## [1.3.1.](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.1) (Tuesday, March 25th, 2014)
### Fixed
- **FIXED** warnings which can appear with *-Wall* *-Wextra* flags.
- **FIXED** warnings which occurred when it misses a newline at end of files. Thanks to Ronnie Liew ([@ronnieliew](https://github.com/ronnieliew)) for his contribution.

## [1.3.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.3.0) (Thursday, March 20th, 2014)
### New
- Travis-CI support is there. Thanks to Jens Kohl ([@jk](https://github.com/jk)) for his contribution.
- Adds a new method in the @protocol which allows to work with multiple gesture recognizers (issue [#1](https://github.com/SebastienMichoy/MSSlidingPanelController/issues/1)).
- Adds BSD license in every files' header.

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
- Add a script to update the build number of the exemple.

### Fixed
- **FIXED** a false positive warning reported by clang analyzer.

## [1.1.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.1.0) (Thursday, January 16th, 2014)
### New
- It now possible to add a completion block when we change the maximum width of panels.

## [1.0.0](https://github.com/SebastienMichoy/MSSlidingPanelController/releases/tag/1.0.0) (Wednesday, January 8th, 2014)
- Initial release.