//
//  FareSelectionViewController.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import UIKit

class FareSelectionViewController: UIViewController {
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: - Parameters
    
    /// Currently selected fare data. Represents the fare selection by the 
    /// user.
    var selectedFareDetailsData: FareDetailsDataModel? = nil {
        didSet {
            updateUI()
        }
    }
    
    /// Currently selected fare data. Represents the fare selection by the
    /// user.
    var selectedFareData: FareDataModel? = nil {
        didSet {
            updateUI()
        }
    }
    
    
    /// The number of tickets the user has selected.
    var totalNumberOfTickets = 1
    
    /// The button that will finalize the purchase.
    @IBOutlet var buyButton: UIButton? = nil
    
    /// The add ticket button.
    @IBOutlet var addTicketButton: UIButton? = nil
    
    /// The subtract ticket button.
    @IBOutlet var subtractTicketButton: UIButton? = nil
    
    /// The main label that represents the ticket fare title.
    @IBOutlet var mainFareLabel: UILabel? = nil
    
    /// The secondary label that represents the ticket fare subtext.
    @IBOutlet var secondaryFareLabel: UILabel? = nil

    ////////////////////////////////////////////////////////////////////////////
    // MARK: - View Lifecycle Instance Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Confirm Selection", comment: "")
        
        // Give our button the rounded cornerz
        buyButton?.layer.cornerRadius = 5.0

        // Do any additional setup after loading the view.
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: - Interaction Instance Methods
    @IBAction func buyTickets(sender: UIControl) {
        
        // Build our ticket string
        guard let ticketsProper = selectedFareDetailsData?.ticketTitle(numberOfTickets: totalNumberOfTickets) else { return }
        let purchaseTicketsMessage = NSLocalizedString("You have purchased", comment: "") +
            " \(totalNumberOfTickets) " + NSLocalizedString("\(ticketsProper)", comment: "") + "."
        
        // Create our alert and display it.
        let alertView = UIAlertController(title: NSLocalizedString("Purchase Ticket(s)", comment: ""), message: purchaseTicketsMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    /**
     Toggles the total number of tickets that will be purchased by the user.
    */
    @IBAction func toggleNumberOfTickets(sender: AnyObject) {
        
        // Get the tag to know which button this came from
        let button = sender as! UIButton
        if button.title(for: .normal) == "+" {
            totalNumberOfTickets += 1
        } else if totalNumberOfTickets > 1 {
            totalNumberOfTickets -= 1
        }
        
        updateUI()
    }

    /**
     Updates all the labels and button when the model changes underneath.
     */
    private func updateUI() {
        
        // Update the main title
        mainFareLabel?.attributedText = selectedFareData?.formattedName()
        
        // Update the secondary title
        secondaryFareLabel?.attributedText = selectedFareDetailsData?.formattedDescription()
        
        // Update the buy button title
        buyButton?.setAttributedTitle(selectedFareDetailsData?.formattedButtonTitle(tickets: totalNumberOfTickets), for: .normal)
        
        // Enable or disable the subtract button if necessary
        if totalNumberOfTickets < 2 {
            subtractTicketButton?.isEnabled = false
        } else {
            subtractTicketButton?.isEnabled = true
        }
    }
}
