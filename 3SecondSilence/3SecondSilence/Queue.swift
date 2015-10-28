//
//  Queue.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

struct Alert {
    var time: NSTimeInterval = 3
    
    var title: String?
    var message: String?
    var buttons: [String]?
    
    init(title: String?, message: String?, buttons: [String]?) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}

struct Counter {
    func countDown(time: NSTimeInterval, completion: (() -> Void)?) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { _ in
            completion()
        }
    }
}

