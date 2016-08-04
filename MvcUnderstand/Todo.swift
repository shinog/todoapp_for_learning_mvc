//
//  Todo.swift
//  MvcUnderstand
//
//  Created by 木村凌祐 on 2016/08/04.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation


class Task: NSObject, NSCoding {
    let id: Int
    var order: Int
    var content: String
    init(id: Int, order: Int, content: String) {
        self.id = id; self.order = order; self.content = content
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: "id")
        aCoder.encodeInteger(order, forKey: "order")
        aCoder.encodeObject(content, forKey: "content")
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeIntegerForKey("id")
        order = aDecoder.decodeIntegerForKey("order")
        content = aDecoder.decodeObjectForKey("content") as! String
        super.init()
    }
}
