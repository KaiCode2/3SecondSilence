//
//  AlertPresenterCommunicater.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-23.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import UIKit

protocol AlertPresenterControllerDelegate: class {
    func shouldPresentAlert(alert: Alert)
    func isAlertVisible() -> Bool
}


class AlertPresenterController: QueueDelegate, ViewControllerDelegate {
    private var queue: [Alert]?
    private weak var delegate: AlertPresenterControllerDelegate?
    
    init(delegate: AlertPresenterControllerDelegate) {
        self.delegate = delegate
    }
    
    func shouldShowAlert(alert: Alert) {
        if delegate?.isAlertVisible() == false {
            delegate?.shouldPresentAlert(alert)
        } else {
            if queue == nil {
                queue = [alert]
            } else {
                queue?.append(alert)
            }
        }
    }
    
    func didDismissAlert(sender: UIViewController, alert: UIAlertController) {
        if queue == nil {
            return
        } else if queue!.isEmpty {
            return
        } else {
            guard queue?.first != nil else {
                return
            }
            delegate?.shouldPresentAlert(queue!.first!)
            queue?.removeFirst()
        }
    }
}

