//
//  RiderTableViewController.swift
//  TicketFare
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import UIKit

class RiderTableViewController: UITableViewController {
    
    var fareData: [FareDataModel]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the title of the first vc to the appropriate related content
        self.title = NSLocalizedString("Select Rider", comment: "")
        
        if let fareData = FareDataModel.fetchFareData() {
            self.fareData = fareData
        }
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
            return fareData.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riderIdentifierCell", for: indexPath)
        
        if let fareData = fareData {
            if indexPath.row < fareData.count {
                let cellData = fareData[indexPath.row]
                cell.textLabel?.attributedText = cellData.formattedName()
                cell.detailTextLabel?.attributedText = cellData.formattedDescription()
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
            if let fareController = segue.destination as? FareTableViewController {
                
                if let tempFareData = fareData,
                    currentlySelectedRow.row < fareData!.count {
                    fareController.fareData = tempFareData[currentlySelectedRow.row]
                }
                
            }
        }
        
    }

}
