//
//  FareTableViewController.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import UIKit

class FareTableViewController: UITableViewController {
    
    var fareData: FareDataModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the fare selection
        self.title = NSLocalizedString("Select Fare", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let fareData = fareData {
            return fareData.fareDetails.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fareIdentifierCell", for: indexPath)

        if let fareData = fareData {
            if indexPath.row < fareData.fareDetails.count {
                let cellData = fareData.fareDetails[indexPath.row]
                cell.textLabel?.attributedText = cellData.formattedDescription()
                cell.detailTextLabel?.attributedText = cellData.formattedPrice()
            }
        } else {
            // Configure an error cell
            cell.textLabel?.text = NSLocalizedString("Failed to initialize the fare data.", comment: "")
        }

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // First check to see if we have a selected row (we should)
        if let currentlySelectedRow = self.tableView.indexPathForSelectedRow {
            
            // Grab the fare controller before it is pushed so we can pass the correct
            // data.
            if let fareController = segue.destination as? FareSelectionViewController {
                
                if let tempFareData = fareData,
                    currentlySelectedRow.row < fareData!.fareDetails.count {
                    fareController.selectedFareDetailsData = tempFareData.fareDetails[currentlySelectedRow.row]
                    fareController.selectedFareData = fareData
                }
                
            }
        }
    }

}
