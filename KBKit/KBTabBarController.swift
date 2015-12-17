//
//  KBTabBarController.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Xappox, LLC. All rights reserved.
//

import UIKit

public class KBTabBarController: UITabBarController {

    override public var keyCommands: [UIKeyCommand]?{
        let tabCommand = UIKeyCommand(input: "\t", modifierFlags: [], action: "tabCommand", discoverabilityTitle: "Change Tab (Right)")
        let shiftTabCommand = UIKeyCommand(input: "\t", modifierFlags: [.Shift], action: "shiftTabCommand", discoverabilityTitle: "Change Tab (Left)")
        return [tabCommand, shiftTabCommand]
    }
    
    @objc private func tabCommand(){
        guard let viewControllers = viewControllers else { return }
        let nextIndex = selectedIndex + 1
        selectedIndex = viewControllers.count > nextIndex ? nextIndex : 0
    }
    
    @objc private func shiftTabCommand(){
        guard let viewControllers = viewControllers else { return }
        let nextIndex = selectedIndex - 1
        selectedIndex = nextIndex >= 0 ? nextIndex : (viewControllers.count - 1)
    }

}
