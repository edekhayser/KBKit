//
//  KBViewController.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Xappox, LLC. All rights reserved.
//

import UIKit

public class KBViewController: UIViewController {

    override public var keyCommands: [UIKeyCommand]?{
        let backCommand = UIKeyCommand(input: "\u{8}", modifierFlags: [], action: "backCommand", discoverabilityTitle: "Back")
        let leftCommand = UIKeyCommand(input: UIKeyInputLeftArrow, modifierFlags: [], action: "backCommand", discoverabilityTitle: "Back")
        return [backCommand, leftCommand]
    }
    
    @objc private func backCommand(){
        guard let navigationController = navigationController else { return }
        guard navigationController.viewControllers.count > 1 else { return }
        navigationController.popViewControllerAnimated(true)
    }

}
