//
//  ToDoListTableViewController.swift
//  MvcUnderstand
//
//  Created by 木村凌祐 on 2016/07/27.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        TaskList().setTask([Task(id: 1, order: 1, content: "最初のテストタスク")])
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.reloadData()
        
        var tasklists = TaskList().readTask()
        print("id")
        for task in tasklists {
            print(task.id)
        }
        print("order")
        for task in tasklists {
            print(task.order)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskList().readTask().count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(TaskList().readTask()[indexPath.row].content)"
        return cell
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.editing = editing
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //TaskList().delete(indexPath.row)
            TaskList().deleteTask(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        TaskList().moveTask(sourceIndexPath.row, fromindex: destinationIndexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPathForCell(cell)!
            assert(segue.destinationViewController.isKindOfClass(DetailViewController))
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.edittext = TaskList().readTask()[indexPath.row].content
            detailViewController.order = indexPath.row
        }
    }
    
}
