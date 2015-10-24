//
//  Queue.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol QueueDelegate {
    func shouldShowAlert(alert: Alert)
    func isAlertVisible() -> Bool
}

class Queue: ViewControllerDelegate {
    private var delegate: QueueDelegate
    let operationQueue = NSOperationQueue()
    
    init(delegate: QueueDelegate) {
        self.delegate = delegate
    }
    
    func addToQueue(alert: Alert) {
        let countingOperation = CountingOperation(time: alert.time) { _ in
            if self.delegate.isAlertVisible() {
            }
        }
        
        operationQueue.addOperations([countingOperation], waitUntilFinished: true)
    }
    
    func didDismissAlert(sender: UIViewController, alert: UIAlertController) {
        
    }
}

private class CountingOperation: NSOperation {
    private let time: NSTimeInterval
    
    init(time: NSTimeInterval, completion: (() -> Void)?) {
        self.time = time
        super.init()
        self.completionBlock = completion
    }
    
    override func start() {
        let counter = Counter()
        counter.countDown(time) { _ in
            self.completionBlock?()
        }
    }
}

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
    func countDown(time: NSTimeInterval, completion: () -> Void) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { _ in
            completion()
        }
    }
}

