//
//  FareDataModel.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import Foundation
import UIKit

/// Base data model for the representation of fares.
struct FareDataModel {
    
    // MARK: - Parameters
    let fareName: String
    let fareDescription: String?
    let fareDetails: [FareDetailsDataModel]
    
    // MARK: - View Specific Formatting Methods
    
    /**
     A convenience method to return the title in the correct format the client 
     would be expecting.
     
     - returns An attributed string with the appropriate attributes to represent
     the title the client would expect.
    */
    func formattedName() -> NSAttributedString {
        return NSAttributedString(string: fareName, attributes: [NSForegroundColorAttributeName: UIColor.gray,
                                                                 NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16.0)])
    }

    /**
     A convenience method to return the subtext description in the correct format 
     the client would be expecting.
     
     - returns An attributed string with the appropriate attributes to represent
     the subtext the client would expect.
     */
    func formattedDescription() -> NSAttributedString? {
        if let fareDescription = fareDescription {
            return NSAttributedString(string: fareDescription, attributes: [NSForegroundColorAttributeName: UIColor.gray,
                                                                     NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
        } else {
            return nil
        }
    }
    
}

/// Sort and equality methods
extension FareDataModel {
    
    /**
     Sort the current data based on array key.
     
     - returns A sorted array based off of they key
     */
    static func sort(fareData: [FareDataModel]) -> [FareDataModel] {
        return fareData.sorted(by: { $0.fareName < $1.fareName })
    }
    
}


/// Methods pertaining to gathering the payload data related to fares.
extension FareDataModel {
    
    /**
     Fetch the current fare payload.
     
     - returns An array of data models if successful.
     */
    static func fetchFareData() -> [FareDataModel]? {
        
        var fareData: [FareDataModel]? = nil
        
        // Grab the data, if no data then bail gracefully
        if let jsonData = self.dataFromJSONFile() {
            do {
                let processJSONData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                print("Processed Data \(processJSONData)")
                
                // Process the fare data now that we have the generic models
                if let tempData = self.process(fareData: processJSONData) {
                    fareData = tempData
                }
            } catch {
                print("Error processing the json file with the current payload.")
            }
        }
        
        // Try a sort before giving it back
        if let tempFareData = fareData {
            fareData = self.sort(fareData: tempFareData)
        }
        
        return fareData
    }
    
    /**
     Convenience method to process json data into our data models.
     
     - returns An array of the FareDataModels if successful.
    */
    static func process(fareData: Any) -> [FareDataModel]? {
        var returnFareData: [FareDataModel]? = nil
        
        if let tempData = fareData as? [String:Any] {
            
            // Create our data container since we know we have data
            var tempReturnFareData = [FareDataModel]()
        
            // Cycle through our fare objects to grab the appropriate data to 
            // fill in our models
            for (key, data) in tempData {
                
                // First check we have the correct types, otherwise keep going
                guard let fareDetailData = data as? [String:Any],
                let fares = fareDetailData["fares"] as? [[String:Any]] else { continue }
                
                // Try to grab the subtext, if it isn't there lets keep going 
                // because it can be nil according to the documentation.
                var subtext: String? = nil
                if let tempSubtext = fareDetailData["subtext"] as? String? {
                    subtext = tempSubtext
                }
                
                if let detailsData = FareDetailsDataModel.process(fareDetailData: fares) {
                    let tempData = FareDataModel(fareName: key, fareDescription: subtext, fareDetails: detailsData)
                    tempReturnFareData.append(tempData)
                }
            }
            
            // Only set our return data if we have successfully converted data
            if tempReturnFareData.count > 0 {
                returnFareData = tempReturnFareData
            }
        }
        
        return returnFareData
    }
    
    /**
     Grab the Data from the json file to be used to mock the current payload.
     
     - returns The Data object representing the json payload for the current fares
     if successful
     */
    private static func dataFromJSONFile() -> Data? {
        
        var returnData: Data? = nil
        
        guard let faresURL = Bundle.main.url(forResource: "fares", withExtension: "json") else { return returnData }
        
        do {
            returnData = try Data(contentsOf: faresURL, options: NSData.ReadingOptions.mappedIfSafe)
        } catch {
            return nil
        }
        
        return returnData
    }
}
