//
//  Simulator.swift
//  BuyTicketsOperation
//
//  Created by Mr Thuc on 6/11/18.
//  Copyright © 2018 ntthuc. All rights reserved.
//

import UIKit

class Simulator {
    
    class func runSimulation(withMinTime minTime: Int, maxTime: Int) -> Double {
        
        let distanceTime = (UInt32(maxTime - minTime) * 1000)
        
        let milisecond = (arc4random() % distanceTime) + UInt32(minTime * 1000)
        
        let waitTime = milisecond / 1000
        
        // Thread is blocked for a while
        Thread.sleep(forTimeInterval: TimeInterval(waitTime))
        
        return Double(waitTime)
    }
}
