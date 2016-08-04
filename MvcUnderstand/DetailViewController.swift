//
//  DetailViewController.swift
//  MvcUnderstand
//
//  Created by 木村凌祐 on 2016/07/27.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var edittext: String = ""
    var order: Int = 0
    
    private let disposeBag = DisposeBag()
    private let minWordCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = edittext
        //textfield.text = TaskList().read()[0]
        
        let textValidation = textfield.rx_text.asDriver()
            .map { [weak self] text -> Bool in
                return text.characters.count >= self?.minWordCount
        }
        
        textValidation
            .drive(validationLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        let saveButtonEnabled = [textValidation]
            .combineLatest { !$0.contains(false) }
        
        saveButtonEnabled
            .drive(saveButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        saveButtonEnabled
            .driveNext { [weak self] valid in
                self?.saveButton.backgroundColor = valid ?
                    UIColor(red: 135/255, green: 132/255, blue: 200/255, alpha: 1) : UIColor(red: 135/255, green: 132/255, blue: 200/255, alpha: 0.5)
            }
            .addDisposableTo(disposeBag)
        
    }
    
    @IBAction func saveTask(sender: AnyObject) {
        if edittext == "" {
            let number = TaskList().numberCreate()
            TaskList().addTask(textfield.text!, id: number, order: number)
            self.navigationController?.popViewControllerAnimated(true)
            print("追加されました。")
        } else {
            TaskList().editTask(textfield.text!, order: order)
            print("編集されました。")
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
