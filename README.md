# KBKit
Classes to extend UIKit navigation using key commands.

This is intended to improve iPad Pro apps by allowed users to do things on-screen using their keyboards.

These are the classes that are currently supported by KBKit:

- [KBTableView](#kbtableview)
- [KBNavigationController](#kbnavigationcontroller)
- [KBTabBarController](#kbtabbarcontroller)

## KBTableView

`↑` and `↓` : allow the user to navigate up and down the table view.

`⎋` (escape) : allows the user to stop navigating the table view.

`⏎` : allows the user to select the currently highlighted cell.

KBTableView has an instance variable `onSelection: (NSIndexPath) -> Void`. When the user presses `→` or `⏎` while a cell is selected, this method is called with the index path of the selected cell. From here, you can choose to present a new view controller or perform a segue, for example.

KBTableView can be adopted simply by changing the class of your UITableView instances to KBTableView in Interface Builder or in your code.

## KBNavigationController

`⌫` and `⌘+←` (command + left arrow) : allow the user to go back in the navigation stack without touching the screen.

KBNavigationController can be adopted by changing the class of your UINavigationController instances to KBNavigationController in Interface Builder or in your code.

## KBTabBarController

`⇥` (tab) : allows the user to switch to the next tab.

`⇧+⇥` (shift + tab) : allows the user to switch to the previous tab.

KBTabBarController can be adopted by changing the class of your UITabBarController instances to KBTabBarController in Interface Builder or in your code.

## Conclusion

Feel free to contribute other classes to support this project. Revisions and improvements are always welcome.

You can contact me on Twitter at [@ERDekhayser](https://twitter.com/ERDekhayser).
