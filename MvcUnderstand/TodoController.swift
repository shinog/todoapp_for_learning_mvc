//
//  Todo.swift
//  MvcUnderstand
//
//  Created by 木村凌祐 on 2016/07/28.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation

class TaskList {
    var tasklist: [Task] = [Task(id: 1, order: 1, content: "本屋に行く"), Task(id: 2, order: 2, content: "CD屋に行く")]
    
    func userDefault() -> (NSUserDefaults) {
        return NSUserDefaults.standardUserDefaults()
    }
    
    func setTask(task : [Task]) {
        if let data = userDefault().objectForKey("tests") as? NSData {
        } else {
            let archive = NSKeyedArchiver.archivedDataWithRootObject(task)
            userDefault().setObject(archive, forKey: "tests")
        }
    }
    
    func readTask() -> ([Task]) {
        if  let data = userDefault().objectForKey("tests") as? NSData {
            let unarchive = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            return unarchive as! [Task] //orderの順にどうタスクを出力していくか
        } else {
            return [Task]()
        }
    }
    
    func moveTask(toindex: Int, fromindex: Int) {
        let targetTask = TaskList().readTask()[toindex]
        var data = userDefault().objectForKey("tests") as! NSData
        var unarchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Task]
        unarchive.removeAtIndex(toindex)
        unarchive.insert(targetTask, atIndex: fromindex)
        let archive = NSKeyedArchiver.archivedDataWithRootObject(unarchive)
        userDefault().setObject(archive, forKey: "tests")
    }
    
    func addTask(content: String, id: Int, order: Int) {
        //let count = readTask().count + 1
        var data = userDefault().objectForKey("tests") as! NSData
        var unarchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Task]
        unarchive.append(Task(id: id, order: order, content: content)) //Listsとは別のキーでタスクの総数を把握する必要あり(タスクが削除された場合、idが重複するため)
        let archive = NSKeyedArchiver.archivedDataWithRootObject(unarchive)
        userDefault().setObject(archive, forKey: "tests")
    }
    
    func editTask(content: String, order: Int) {
        var data = userDefault().objectForKey("tests") as! NSData
        var unarchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Task]
        //var number = order + 1
        unarchive[order].content = content
        let archive = NSKeyedArchiver.archivedDataWithRootObject(unarchive)
        userDefault().setObject(archive, forKey: "tests")
    }
    
    func deleteTask(order: Int) {
        var data = userDefault().objectForKey("tests") as! NSData
        var unarchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Task]
        unarchive.removeAtIndex(order)
        let archive = NSKeyedArchiver.archivedDataWithRootObject(unarchive)
        userDefault().setObject(archive, forKey: "tests")
    }
    
    func numberCreate() -> Int {
        userDefault().registerDefaults(["counts": 0])
        var count = userDefault().objectForKey("counts") as! Int
        let newcount = count + 1
        userDefault().setObject(newcount, forKey:"counts")
        userDefault().synchronize()
        return newcount
    }
    
}
