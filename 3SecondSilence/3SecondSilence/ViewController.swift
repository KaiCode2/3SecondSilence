//
//  ViewController.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func alertDismissed()
}

class ViewController: UIViewController, AlertPresenterControllerDelegate {
    
    private var queue: Queue?
    private var count = 1
    private var alertVisible: Bool = false
    var delegate: ViewControllerDelegate?
    
    override func viewDidAppear(animated: Bool) {
        print(view.superview)
    }
    
    @IBAction private func buttonTapped(sender: AnyObject) {
        let alert = Alert(title: "Alert \(count)", message: "message", buttons: ["OK"])
        
        if queue == nil {
            queue = Queue()
            queue?.addToQueue(alert)
        }
    }
    
    func presentAlert(alert: Alert) {
//        let alertCon = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .Alert)
//        alertCon.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { _ in
//            self.delegate?.alertDismissed()
//            self.alertVisible = false
//        }))
//        alertVisible = true
//        presentViewController(alertCon, animated: true, completion: nil)
        let vi = UIAlertController(title: "title", message: "message", preferredStyle: .Alert)
        print(self.view.superview)
        presentViewController(vi, animated: true, completion: nil)
    }
    
    private func helper(alert: Alert) {
        let vi = UIAlertController(title: "title", message: "message", preferredStyle: .Alert)
        print(self.view.superview)
        presentViewController(vi, animated: true, completion: nil)
    }
    
    func isAlertVisible() -> Bool {
        return alertVisible
    }
}

