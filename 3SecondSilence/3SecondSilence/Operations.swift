//
//  Operations.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-27.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit


class PresentationOperation: NSOperation {
    
    private let viewController: UIViewController
    private let alert: Alert
    private var _finished: Bool = false
    override var finished: Bool {
        get {
            return _finished
        }
        set {
            _finished = newValue
        }
    }
    
    init(viewController: UIViewController, alert: Alert) {
        self.viewController = viewController
        self.alert = alert
        super.init()
    }
    
    override func main() {
        if cancelled {
            return
        }
        
        showAlert(alert, buttonAction: { _ in
            self._finished = true
        })
    }
    
    func showAlert(alert: Alert, buttonAction: (() -> Void)?) {
        dispatch_async(dispatch_get_main_queue(),{
            let alertCon = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .Alert)
            if let buttons = alert.buttons {
                for (index, title) in buttons.enumerate() {
                    alertCon.addAction(UIAlertAction(title: title, style: index == 0 ? .Cancel : .Default, handler: { _ in
                        if let comp = buttonAction {
                            comp()
                        }
                    }))
                }
            } else {
                alertCon.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { _ in
                    if let comp = buttonAction {
                        comp()
                    }
                }))
            }
            self.viewController.presentViewController(alertCon, animated: true, completion: nil)
        })
    }
}

class CountingOperation: NSOperation {
    
    private let time: NSTimeInterval
    private var _finished: Bool = false
    override var finished: Bool {
        get {
            return _finished
        }
        set {
            _finished = newValue
        }
    }
    
    init(time: NSTimeInterval) {
        self.time = time
        super.init()
    }
    
    override func main() {
        if cancelled {
            return
        }
        
        let counter = Counter()
        counter.countDown(time, completion: {
            if self.cancelled {
                return
            }
            self._finished = true
        })
    }
    
    
}

private struct Counter {
    func countDown(time: NSTimeInterval, completion: (() -> Void)?) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { _ in
            if let comp = completion {
                comp()
            }
        }
    }
}
