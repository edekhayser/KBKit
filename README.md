# KBKit
Classes to extend UIKit navigation using key commands.

This is intended to improve iPad Pro apps by allowed users to do things on-screen using their keyboards.

These are the classes that are currently supported by KBKit:

- [UITableView](#kbtableview)
- [UIViewController](#kbviewcontroller)
- [UITabBarController](#kbtabbarcontroller)

## KBTableView

`↑` and `↓` : allow the user to navigate up and down the table view.

`⎋` (escape) : allows the user to stop navigating the table view.

`→` and `⏎` : allow the user to select the currently highlighted cell.

KBTableView has an instance variable `methodToCallOnSelection: (NSIndexPath) -> Void`. When the user presses `→` or `⏎` while a cell is selected, this method is called with the index path of the selected cell. From here, you can choose to present a new view controller or perform a segue, for example.

## KBViewController

`⌫` and `←` : allow the user to go back in the navigation stack without touching the screen.

## KBTabBarController

`⇥` (tab) : allows the user to switch to the next tab.

`⇧+⇥` (shift + tab) : allows the user to switch to the previous tab.

## Conclusion

Feel free to contribute other classes to support this project. Revisions and improvements are always welcome.

You can contact me on Twitter at @ERDekhayser.
