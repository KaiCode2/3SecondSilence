//
//  ViewController.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-21.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func didDismissAlert(sender: UIViewController, alert: UIAlertController)
}

class ViewController: UIViewController, QueueDelegate {
    
    private var queue: Queue?
    private var count = 1
    private var alertVisible: Bool = false
    var delegate: ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = queue
        queue = Queue(delegate: self)
    }
    
    @IBAction private func buttonTapped(sender: AnyObject) {
        let alert = Alert(title: "Alert \(count)", message: "message", buttons: ["OK", "Cool"])
        count++
        queue?.addToQueue(alert)
    }
    
    func isAlertVisible() -> Bool {
        return alertVisible
    }
    
    func shouldShowAlert(alert: Alert) {
        let alertCon = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .Alert)
        if let buttons = alert.buttons {
            for (index, title) in buttons.enumerate() {
                alertCon.addAction(UIAlertAction(title: title, style: index == 0 ? .Cancel : .Default, handler: { _ in
                    self.delegate?.didDismissAlert(self, alert: alertCon)
                    self.alertVisible = false
                }))
            }
        } else {
            alertCon.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { _ in
                self.delegate?.didDismissAlert(self, alert: alertCon)
                self.alertVisible = false
            }))
        }
        alertVisible = true
        presentViewController(alertCon, animated: true, completion: nil)
    }
}

