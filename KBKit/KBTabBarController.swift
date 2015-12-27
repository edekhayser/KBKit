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
		guard let viewControllers = viewControllers else { return nil }
		
		let oneCommand = UIKeyCommand(input: "1", modifierFlags: [.Command], action: "oneCommand", discoverabilityTitle: "First Tab")
		let twoCommand = UIKeyCommand(input: "2", modifierFlags: [.Command], action: "twoCommand", discoverabilityTitle: "Second Tab")
		let threeCommand = UIKeyCommand(input: "3", modifierFlags: [.Command], action: "threeCommand", discoverabilityTitle: "Third Tab")
		let fourCommand = UIKeyCommand(input: "4", modifierFlags: [.Command], action: "fourCommand", discoverabilityTitle: "Fourth Tab")
		let fiveCommand = UIKeyCommand(input: "5", modifierFlags: [.Command], action: "fiveCommand", discoverabilityTitle: "Fifth Tab")
		var commands = [UIKeyCommand]()
		
		if viewControllers.count >= 1{ commands.append(oneCommand) }
		if viewControllers.count >= 2{ commands.append(twoCommand) }
		if viewControllers.count >= 3{ commands.append(threeCommand) }
		if viewControllers.count >= 4{ commands.append(fourCommand) }
		if viewControllers.count == 5{ commands.append(fiveCommand) }
		return commands
	}

	@objc private func oneCommand(){
		selectedIndex = 0
	}
	
	@objc private func twoCommand(){
		selectedIndex = 1
	}
	
	@objc private func threeCommand(){
		selectedIndex = 2
	}
	
	@objc private func fourCommand(){
		selectedIndex = 3
	}
	
	@objc private func fiveCommand(){
		selectedIndex = 4
	}

}
