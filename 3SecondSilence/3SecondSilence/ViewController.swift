//
//  ViewController.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var countinQueue: NSOperationQueue {
        return NSOperationQueue()
    }
    private var presentationQueue: NSOperationQueue {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }
    private var count = 1
    
    @IBAction private func buttonTapped(sender: AnyObject) {
        let alert = Alert(title: "Alert \(count)", message: "message", buttons: ["OK", "Cool"])
        count++
        
        let operation = CountingOperation(time: alert.time)
        
        operation.completionBlock = {
            print("Completed")
            let presentationOperation = PresentationOperation(viewController: self, alert: alert)
            
            print(self.presentationQueue.operations)
            if let previous = self.presentationQueue.operations.last {
                presentationOperation.addDependency(previous)
            }
            
            self.presentationQueue.addOperation(presentationOperation)
        }
        countinQueue.addOperation(operation)
    }
}
