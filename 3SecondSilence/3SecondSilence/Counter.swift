//
//  Counter.swift
//  3SecondSilence
//
//  Created by Kai Aldag on 2015-10-27.
//  Copyright © 2015 Kai Aldag. All rights reserved.
//

import Foundation


struct Counter {
    func countDown(time: NSTimeInterval, completion: (() -> Void)?) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { _ in
            if let comp = completion {
                comp()
            }
        }
    }
}