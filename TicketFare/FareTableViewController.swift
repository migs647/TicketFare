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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
