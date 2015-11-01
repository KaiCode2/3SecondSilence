//
//  ViewController.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var queue = NSOperationQueue()
    private var last: NSOperation?
    private var count = 1
    
    @IBAction private func buttonTapped(sender: AnyObject) {
        let alert = Alert(title: "Alert \(count)", message: "message", buttons: ["OK", "Cool"])
        count++
        
        let countdownOperation = CountingOperation(time: alert.time)
        
        countdownOperation.completionBlock = {
            print("Countdown done")
        }
        
        let presentationOperation = PresentationOperation(viewController: self, alert: alert)
        presentationOperation.addDependency(countdownOperation)
        
        if let previous = last {
            presentationOperation.addDependency(previous)
        }
        
        queue.addOperation(countdownOperation)
        queue.addOperation(presentationOperation)
        
        last = presentationOperation
        print(last)
        print(queue.operations)
    }
}
