//
//  AlertPresenterCommunicater.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-23.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol AlertPresenterControllerDelegate {
    func presentAlert(alert: Alert)
    func isAlertVisible() -> Bool
}


struct AlertPresenterController: QueueDelegate, ViewControllerDelegate {
    private var queue: [Alert]?
    var delegate: AlertPresenterControllerDelegate? = ViewController()
    
    func alertReady(alert: Alert) {
        guard (delegate != nil) else {
            fatalError("Delegate not implemented")
        }
        
        if delegate?.isAlertVisible() == false {
            delegate?.presentAlert(alert)
        } else {
            if queue == nil {
//                queue = [alert]
            } else {
//                queue?.append(alert)
            }
        }
    }
    
    func alertDismissed() {
        if queue == nil {
            return
        } else if queue!.isEmpty {
            return
        } else {
            delegate?.presentAlert(queue!.first!)
        }
    }
}