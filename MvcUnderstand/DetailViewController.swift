//
//  DetailViewController.swift
//  MvcUnderstand
//
//  Created by 木村凌祐 on 2016/07/27.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    
    var edittext: String = ""
    var order: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = edittext
        //textfield.text = TaskList().read()[0]
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        if edittext == "" {
            let number = TaskList().numberCreate()
            TaskList().addTask(textfield.text!, id: number, order: number)
            self.navigationController?.popViewControllerAnimated(true)
            print("追加されました！")
        } else {
            TaskList().editTask(textfield.text!, order: order)
            print("編集されました！")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
