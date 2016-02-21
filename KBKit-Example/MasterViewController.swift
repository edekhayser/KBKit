//
//  MasterViewController.swift
//  KBKit
//
//  Created by Evan Dekhayser on 12/13/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [AnyObject]()

    override var keyCommands: [UIKeyCommand]?{
        let addCommand = UIKeyCommand(input: "+", modifierFlags: [], action: "insertNewObject:", discoverabilityTitle: "Add")
        let editCommand = UIKeyCommand(input: "e", modifierFlags: [.Command], action: "editToggled", discoverabilityTitle: "Edit")
        return [addCommand, editCommand]
    }
    
    private lazy var methodToCallWhenEditingDisabled: (NSIndexPath) -> Void = { indexPath in
        self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        self.performSegueWithIdentifier("showDetail", sender: nil)
    }
    
    private lazy var methodToCallWhenEditingEnabled: (NSIndexPath) -> Void = { indexPath in
        self.tableView(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
    }
    
    func editToggled(){
        editing = !editing
        if let tableView = tableView as? KBTableView{
            tableView.onSelection = editing ? methodToCallWhenEditingEnabled : methodToCallWhenEditingDisabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        if let tableView = tableView as? KBTableView{
            tableView.onSelection = editing ? methodToCallWhenEditingEnabled : methodToCallWhenEditingDisabled
			tableView.onFocus = { current, previous in
				if let current = current{
					tableView.cellForRowAtIndexPath(current)?.highlighted = true
				}
				if let previous = previous{
					tableView.cellForRowAtIndexPath(previous)?.highlighted = false
				}
			}
        }
        tableView.becomeFirstResponder()
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		tableView.becomeFirstResponder()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
		self.tableView.reloadData()
	}

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if let tableView = tableView as? KBTableView{
                tableView.stopHighlighting()
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

