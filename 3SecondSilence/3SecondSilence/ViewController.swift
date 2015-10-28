//
//  ViewController.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var queue: NSOperationQueue?
    private var count = 1
    private var alertVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queue = NSOperationQueue()
    }
    
    @IBAction private func buttonTapped(sender: AnyObject) {
        let alert = Alert(title: "Alert \(count)", message: "message", buttons: ["OK", "Cool"])
        count++
        
        let counter = Counter()
//        let operation = NSBlockOperation(block: counter.countDown(3, completion: nil))
        // TODO: add to queue
    }
    
    func isAlertVisible() -> Bool {
        return alertVisible
    }
    
    func shouldShowAlert(alert: Alert) {
        let alertCon = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .Alert)
        if let buttons = alert.buttons {
            for (index, title) in buttons.enumerate() {
                alertCon.addAction(UIAlertAction(title: title, style: index == 0 ? .Cancel : .Default, handler: { _ in
                    self.alertVisible = false
                    // TODO: remove from queue
                }))
            }
        } else {
            alertCon.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { _ in
                self.alertVisible = false
            }))
        }
        alertVisible = true
        presentViewController(alertCon, animated: true, completion: nil)
    }
}

