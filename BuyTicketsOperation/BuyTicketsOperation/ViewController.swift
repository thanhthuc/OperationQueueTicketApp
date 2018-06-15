//
//  ViewController.swift
//  BuyTicketsOperation
//
//  Created by Mr Thuc on 6/11/18.
//  Copyright © 2018 ntthuc. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var buyTicketButton: UIButton!
    @IBOutlet var outputTextView: UITextView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var anphaSlider: UISlider!
    @IBOutlet var resetTicketButton: UIButton!
    
    
    fileprivate var _customerNames: [String] = []
    fileprivate var currentCustomerIndex = 0
    fileprivate var ticketQueue: OperationQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _customerNames = ["lmtu", "dphan", "nmduong", "nguyen", "nhdung",
                          "trungvo", "lvdiep", "ldhung", "duyet", "phat"]
        ticketQueue = OperationQueue()
        initActionButton()
        
    }
    
    func initActionButton() {
        outputTextView.text = ""
        customerNameLabel.text = _customerNames[currentCustomerIndex]
        buyTicketButton.addTarget(self, action: #selector(buyButtonClicked(sender:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked(sender:)), for: .touchUpInside)
        resetTicketButton.addTarget(self, action: #selector(resetButtonClicked(sender:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buyButtonClicked(sender: UIButton) {
        let currentCustomerName: NSString = _customerNames[currentCustomerIndex] as NSString
        let buyTicketsOp = BuyTicketsOperation(customerName: currentCustomerName as String)
        buyTicketsOp.delegate = self
        
        // MARK: Pay operation simulate
        let payOp = BlockOperation {
            let time = Simulator.runSimulation(withMinTime: 4, maxTime: 10)
            DispatchQueue.main.async {
               self.logResult(message: String.init(format: "%@ paid in %.02f seconds.", currentCustomerName, time))
            }
        }
        buyTicketsOp.addObserver(self, forKeyPath: "isCancelled", options: .new, context: bridge(obj: currentCustomerName))
        payOp.addDependency(buyTicketsOp)
        
        ticketQueue.addOperation(payOp)
        ticketQueue.addOperation(buyTicketsOp)
        
        if currentCustomerIndex == _customerNames.count - 1 {
            buyTicketButton.isEnabled = false
            customerNameLabel.text = "No more customer"
        } else {
            currentCustomerIndex = currentCustomerIndex + 1
            customerNameLabel.text = _customerNames[currentCustomerIndex]
        }
    }
    
    func bridge<T: AnyObject>(obj: T) -> UnsafeMutableRawPointer {
        return UnsafeMutableRawPointer.init(Unmanaged.passUnretained(obj).toOpaque())
    }
    
    @objc func cancelButtonClicked(sender: UIButton) {
        ticketQueue.cancelAllOperations()
    }
    
    @objc func resetButtonClicked(sender: UIButton) {
        customerNameLabel.text = ""
        currentCustomerIndex = 0
        buyTicketButton.isEnabled = true
        outputTextView.text = ""
    }
    
    func logResult(message: String) {
        var contents = ""
        if outputTextView.hasText {
            contents = outputTextView.text.appending("\n")
        }
        contents = contents.appending(message)
        outputTextView.text = contents
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "isCancelled" {
            if let context = context {
                print("Buying for \(context.assumingMemoryBound(to: NSString.self).pointee) is cancelled")
            }
        }
    }
}

extension ViewController: BuyTicketsDelegate {
    func displayBuyTicketsResult(result: SimulationResult, waitUntilDone: Bool) {
        
    }
}

