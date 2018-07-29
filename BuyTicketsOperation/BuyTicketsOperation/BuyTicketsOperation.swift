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

class BuyTicketsOperation: Operation {
    
    weak var delegate: BuyTicketsDelegate?
    
    fileprivate var _customerName: String
    
    init(customerName: String) {
        self._customerName = customerName
    }
    
    // Add commit for new branch 5
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
    
    
    
}
