//
//  BuyTicketsOperation.swift
//  BuyTicketsOperation
//
//  Created by Mr Thuc on 6/11/18.
//  Copyright © 2018 ntthuc. All rights reserved.
//

import UIKit

protocol BuyTicketsDelegate: class {
    func displayBuyTicketsResult(result: SimulationResult, waitUntilDone: Bool)
}

// Test 8
// Test continue branch
class BuyTicketsOperation: Operation {
    
    weak var delegate: BuyTicketsDelegate?
    
    fileprivate var _customerName: String
    
    init(customerName: String) {
        self._customerName = customerName
    }
    
    // THIS IS BRANCH 1
    override func main() {
        print("RUN MAIN FUNCTION")
        var totalTime = 0.0
        for _ in 0..<10 {
            if isCancelled {
                return
            }
            totalTime = totalTime + Simulator.runSimulation(withMinTime: 1, maxTime: 4)
        }
        let result = SimulationResult()
        result.simulationTime = totalTime
        result.customerName = self._customerName
        DispatchQueue.main.async {
            self.delegate?.displayBuyTicketsResult(result: result, waitUntilDone: false)
        }
    }
    
    override func start() {
        print("RUN START FUNCTION")
    }
    
    func branch2() {
        print("branch 2")
        // add to 2
    }
    
    func branch3() {
        print("branch 3")
    }
    
    func branch5() {
        
    }
    
    
    func master() {
        // Create master func
        // Create master func again
        // Edit master
    }
    
    
    func funcA() {
        
    }
    
    
    func funcB() {
        
    }
}
