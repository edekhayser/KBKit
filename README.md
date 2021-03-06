![Logo](https://raw.githubusercontent.com/edekhayser/KBKit/master/KBKit%20Logo.png)

KBKit is a set of classes that extend UIKit navigation using key commands.

This is intended to improve iPad Pro apps by allowed users to do things on-screen using their keyboards.

These are the classes that are currently supported by KBKit:

- [KBTableView](#kbtableview)
- [KBNavigationController](#kbnavigationcontroller)
- [KBTabBarController](#kbtabbarcontroller)

## [KBTableView](https://github.com/edekhayser/KBKit/blob/master/KBKit/KBTableView.swift)

`↑` and `↓` : allow the user to navigate up and down the table view.

`⎋` (escape) : allows the user to stop navigating the table view.

`⏎ or ⌘+D` : allows the user to select the currently highlighted cell.

KBTableView has a property declared as `onSelection: (NSIndexPath) -> Void`. When the user presses `→` or `⏎` while a cell is selected, this method is called with the index path of the selected cell. From here, you can choose to present a new view controller or perform a segue, for example.

KBTableView can be adopted simply by changing the class of your UITableView instances to KBTableView in Interface Builder or in your code.

## [KBNavigationController](https://github.com/edekhayser/KBKit/blob/master/KBKit/KBNavigationController.swift)

`⌘+←` (command + left arrow) : allow the user to go back in the navigation stack without touching the screen.

KBNavigationController can be adopted by changing the class of your UINavigationController instances to KBNavigationController in Interface Builder or in your code.

## [KBTabBarController](https://github.com/edekhayser/KBKit/blob/master/KBKit/KBTabBarController.swift)

`⌘+1...5` : allows the user to switch to the tab that they choose (supports up to 5 tabs).

KBTabBarController can be adopted by changing the class of your UITabBarController instances to KBTabBarController in Interface Builder or in your code.

## Conclusion

Feel free to contribute other classes to support this project. Revisions and improvements are always welcome.

You can contact me on Twitter at [@ERDekhayser](https://twitter.com/ERDekhayser).
