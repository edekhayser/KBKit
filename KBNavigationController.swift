//
//  KBNavigationController.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

public class KBNavigationController: UINavigationController {

    override public var keyCommands: [UIKeyCommand]?{
        if viewControllers.count < 2 { return [] }
        let backCommand = UIKeyCommand(input: "\u{8}", modifierFlags: [], action: "backCommand", discoverabilityTitle: "Back")
        let leftCommand = UIKeyCommand(input: UIKeyInputLeftArrow, modifierFlags: [.Command], action: "backCommand", discoverabilityTitle: "Back")
        return [backCommand, leftCommand]
    }
    
    @objc private func backCommand(){
        popViewControllerAnimated(true)
    }

}
