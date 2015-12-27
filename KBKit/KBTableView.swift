//
//  KBTableView.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

public class KBTableView : UITableView {
	
	var onSelection: ((NSIndexPath) -> Void)?
	var onFocus: ((current: NSIndexPath, previous: NSIndexPath?) -> Void)?
	private var currentlyFocussedRow: Int?
	
	override public var keyCommands: [UIKeyCommand]?{
		let upCommand = UIKeyCommand(input: UIKeyInputUpArrow, modifierFlags: [], action: "upCommand", discoverabilityTitle: "Move Up")
		let downCommand = UIKeyCommand(input: UIKeyInputDownArrow, modifierFlags: [], action: "downCommand", discoverabilityTitle: "Move Down")
		let returnCommand = UIKeyCommand(input: "\r", modifierFlags: [], action: "returnCommand", discoverabilityTitle: "Enter")
		let escCommand = UIKeyCommand(input: UIKeyInputEscape, modifierFlags: [], action: "escapeCommand", discoverabilityTitle: "Hide Selection")
		
		return [upCommand, downCommand, returnCommand, escCommand]
	}
	
	public func stopHighlighting(){
		if let currentlyFocussed = currentlyFocussedRow, indexPath = indexPathForAbsoluteRow(currentlyFocussed){
			cellForRowAtIndexPath(indexPath)?.highlighted = false
		}
		currentlyFocussedRow = nil
	}
	
	@objc private func escapeCommand(){
		stopHighlighting()
	}
	
	@objc private func upCommand(){
		let previouslyFocussedRow = currentlyFocussedRow
		if let i = currentlyFocussedRow where i != 0{
			currentlyFocussedRow = i - 1
		} else {
			currentlyFocussedRow = numberOfTotalRows() - 1
		}
		guard let currentlyFocussedRow = currentlyFocussedRow else { return }
		
		let indexPath: NSIndexPath = {
			if let i = self.indexPathForAbsoluteRow(currentlyFocussedRow){ return i }
			return NSIndexPath(forRow: self.numberOfRowsInSection(self.numberOfSections - 1), inSection: self.numberOfSections - 1)
		}()
		
		if let previouslyFocussedRow = previouslyFocussedRow{
			onFocus?(current: indexPath, previous: indexPathForAbsoluteRow(previouslyFocussedRow))
		} else {
			onFocus?(current: indexPath, previous: nil)
		}
	}
	
	@objc private func downCommand(){
		let previouslyFocussedRow = currentlyFocussedRow
		if let i = currentlyFocussedRow where i != numberOfTotalRows() - 1{
			currentlyFocussedRow = i + 1
		} else {
			currentlyFocussedRow = 0
		}
		
		guard let currentlySelectedRow = currentlyFocussedRow else { return }
		
		let indexPath: NSIndexPath = {
			if let i = self.indexPathForAbsoluteRow(currentlySelectedRow){ return i }
			return NSIndexPath(forRow: self.numberOfRowsInSection(self.numberOfSections - 1), inSection: self.numberOfSections - 1)
		}()
		
		if let previouslyFocussedRow = previouslyFocussedRow{
			onFocus?(current: indexPath, previous: indexPathForAbsoluteRow(previouslyFocussedRow))
		} else {
			onFocus?(current: indexPath, previous: nil)
		}
	}
	
	@objc private func returnCommand(){
		guard let currentlySelectedRow = currentlyFocussedRow else { return }
		guard let indexPath = indexPathForAbsoluteRow(currentlySelectedRow) else { return }
		onSelection?(indexPath)
	}
	
	public override func reloadData() {
		if let currentlySelectedRow = currentlyFocussedRow, let indexPath = indexPathForAbsoluteRow(currentlySelectedRow){
			cellForRowAtIndexPath(indexPath)?.highlighted = false
		}
		currentlyFocussedRow = nil
		super.reloadData()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "escapeCommand", name: UITableViewSelectionDidChangeNotification, object: self)
	}
	
	override public init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "escapeCommand", name: UITableViewSelectionDidChangeNotification, object: self)
	}
	
	deinit{
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
}

