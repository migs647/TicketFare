//
//  FareDetailsDataModel.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import Foundation

/// Base data model for the representation of fare details / options.
struct FareDetailsDataModel {
    let description: String
    let price: Float
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
                let price = details["price"] as? Float {
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
