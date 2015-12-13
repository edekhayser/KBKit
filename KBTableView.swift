//
//  KBTableView.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

public class KBTableView : UITableView {
    
    var methodToCallOnSelection: (NSIndexPath) -> Void = { _ in }
    private var currentlySelectedRow: Int?
    
    override public var keyCommands: [UIKeyCommand]?{
        let upCommand = UIKeyCommand(input: UIKeyInputUpArrow, modifierFlags: [], action: "upCommand", discoverabilityTitle: "Move Up")
        let downCommand = UIKeyCommand(input: UIKeyInputDownArrow, modifierFlags: [], action: "downCommand", discoverabilityTitle: "Move Down")
        let returnCommand = UIKeyCommand(input: "\r", modifierFlags: [], action: "returnCommand", discoverabilityTitle: "Enter")
        let escCommand = UIKeyCommand(input: UIKeyInputEscape, modifierFlags: [], action: "escapeCommand", discoverabilityTitle: "Hide Selection")
        return [upCommand, downCommand, returnCommand, escCommand]
    }
    
    @objc private func escapeCommand(){
        if let currentlySelectedRow = currentlySelectedRow, indexPath = indexPathForAbsoluteRow(currentlySelectedRow){
            cellForRowAtIndexPath(indexPath)?.highlighted = false
        }
        currentlySelectedRow = nil
    }
    
    @objc private func upCommand(){
        let previouslySelectedRow = currentlySelectedRow
        if let i = currentlySelectedRow where i != 0{
            currentlySelectedRow!--
        } else {
            currentlySelectedRow = numberOfTotalRows() - 1
        }
        guard let currentlySelectedRow = currentlySelectedRow else { return }
        
        let indexPath: NSIndexPath = {
            if let i = self.indexPathForAbsoluteRow(currentlySelectedRow){ return i }
            return NSIndexPath(forRow: self.numberOfRowsInSection(self.numberOfSections - 1), inSection: self.numberOfSections - 1)
        }()
        
        cellForRowAtIndexPath(indexPath)?.highlighted = true
        if let previouslySelectedRow = previouslySelectedRow where previouslySelectedRow != currentlySelectedRow, let ip = indexPathForAbsoluteRow(previouslySelectedRow){
            cellForRowAtIndexPath(ip)?.highlighted = false
        }
    }
    
    @objc private func downCommand(){
        let previouslySelectedRow = currentlySelectedRow
        if let i = currentlySelectedRow where i != numberOfTotalRows() - 1{
            currentlySelectedRow!++
        } else {
            currentlySelectedRow = 0
        }
        
        guard let currentlySelectedRow = currentlySelectedRow else { return }
        
        let indexPath: NSIndexPath = {
            if let i = self.indexPathForAbsoluteRow(currentlySelectedRow){ return i }
            return NSIndexPath(forRow: self.numberOfRowsInSection(self.numberOfSections - 1), inSection: self.numberOfSections - 1)
        }()
        
        cellForRowAtIndexPath(indexPath)?.highlighted = true
        if let previouslySelectedRow = previouslySelectedRow where previouslySelectedRow != currentlySelectedRow, let ip = indexPathForAbsoluteRow(previouslySelectedRow){
            cellForRowAtIndexPath(ip)?.highlighted = false
        }
    }
    
    @objc private func returnCommand(){
        guard let currentlySelectedRow = currentlySelectedRow else { return }
        guard let indexPath = indexPathForAbsoluteRow(currentlySelectedRow) else { return }
        methodToCallOnSelection(indexPath)
    }
    
    public override func reloadData() {
        if let currentlySelectedRow = currentlySelectedRow, let indexPath = indexPathForAbsoluteRow(currentlySelectedRow){
            cellForRowAtIndexPath(indexPath)?.highlighted = false
        }
        currentlySelectedRow = nil
        super.reloadData()
    }

}

private extension UITableView{
    
    func indexPathForAbsoluteRow(absoluteRow: Int) -> NSIndexPath?{
        var currentRow = 0
        for section in 0..<numberOfSections{
            for row in 0..<numberOfRowsInSection(section){
                if currentRow++ == absoluteRow{
                    return NSIndexPath(forRow: row, inSection: section)
                }
            }
        }
        return nil
    }
    
    func absoluteRowForIndexPath(indexPath: NSIndexPath) -> Int?{
        guard indexPath.section < self.numberOfSections else { return nil }
        var rowNumber = 0
        for section in 0..<indexPath.section{
            rowNumber += numberOfRowsInSection(section)
        }
        guard indexPath.row < numberOfRowsInSection(indexPath.section) else { return nil }
        rowNumber += indexPath.row
        return rowNumber
    }
    
    func numberOfTotalRows() -> Int{
        return Array(0..<numberOfSections).reduce(0, combine: { (sum, section) in numberOfRowsInSection(section) })
    }
    
}

