//
//  FareDetailsDataModel.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import Foundation
import UIKit

/// Base data model for the representation of fare details / options.
struct FareDetailsDataModel {
    let description: String
    let price: Double
    
    // MARK: - View Specific Formatting Methods
    
    /**
     A convenience method to return the title in the correct format the client
     would be expecting for the fare name.
     
     - returns An attributed string with the appropriate attributes to represent
     the title the client would expect.
     */
    func formattedDescription() -> NSAttributedString {
        return NSAttributedString(string: description, attributes: [NSForegroundColorAttributeName: UIColor.gray,
                                                                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
    }
    
    /**
     A convenience method to return the subtext description in the correct format
     the client would be expecting.
     
     - returns An attributed string with the appropriate attributes to represent
     the subtext the client would expect.
     */
    func formattedPrice(quantity: Int = 1) -> NSAttributedString {
        
        // Check if there are hax0rs
        var quantity = quantity
        if quantity < 1 {
            quantity = 1
        }
        
        // First convert to NSDecimalNumber so we can format appropriately
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let tempValue = formatter.string(from: NSNumber(value: price * Double(quantity)))
        
        var formattedValue = "0"
        if let _ = tempValue {
            formattedValue = tempValue!
        }
        
        return NSAttributedString(string: formattedValue, attributes: [NSForegroundColorAttributeName: UIColor.gray,
                                                                       NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)])
    }

    func formattedButtonTitle(tickets: Int) -> NSAttributedString {
        
        // Generate the raw string first
        var rawButtonTitle = NSLocalizedString("Buy", comment: "") + " \(tickets) " + NSLocalizedString("\(ticketTitle(numberOfTickets: tickets))", comment: "")
        
        // Get the price first
        rawButtonTitle += " - \(formattedPrice(quantity: tickets).string)"
        
        let returnTitle = NSAttributedString(string: rawButtonTitle, attributes: [NSForegroundColorAttributeName: UIColor.white,
                                                                                  NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12.0)])
        
        return returnTitle
    }

    /// Helps format tickets correctly based on how many are available
    func ticketTitle(numberOfTickets: Int) -> String {
        var ticketsTitle = "Tickets"
        if numberOfTickets == 1 {
            ticketsTitle = "Ticket"
        }
        
        return ticketsTitle
    }
}

/// Methods pertaining to organizing the payload data related to fare details.
extension FareDetailsDataModel {
    
    /**
     Convenience method to process json data into our detail data models.
     
     - returns An array of the FareDetailsDataModels if successful.
     */
    static func process(fareDetailData: [[String:Any]]) -> [FareDetailsDataModel]? {
        
        var returnDetailsDataModels: [FareDetailsDataModel]? = nil
        
        // Check for description
        var tempReturnDetails = [FareDetailsDataModel]()
        for details in fareDetailData {
            
            // Make sure the types convert appropriately
            if let description = details["description"] as? String,
                let price = details["price"] as? Double {
                let fareDetails = FareDetailsDataModel(description: description, price: price)
                tempReturnDetails.append(fareDetails)
            }
        }
        
        // Only set our return data if we have successfully converted the data
        if tempReturnDetails.count > 0 {
            returnDetailsDataModels = tempReturnDetails
        }
        
        return returnDetailsDataModels
    }

}
