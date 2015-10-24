//
//  AlertPresenterCommunicater.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-23.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol AlertPresenterControllerDelegate: class {
    func presentAlert(alert: Alert)
    func isAlertVisible() -> Bool
}


class AlertPresenterController: QueueDelegate, ViewControllerDelegate {
    private var queue: [Alert]?
    weak var delegate: AlertPresenterControllerDelegate?
    
    func alertReady(alert: Alert) {
        guard (delegate != nil) else {
            fatalError("Delegate not implemented")
        }
        
        if delegate?.isAlertVisible() == false {
            delegate?.presentAlert(alert)
        } else {
            if queue == nil {
                queue = [alert]
            } else {
                queue?.append(alert)
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
            queue!.removeFirst()
        }
    }
}

