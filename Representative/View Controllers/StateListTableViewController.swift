//
//  StateListTableViewController.swift
//  Representative
//
//  Created by Kyle Jennings on 11/20/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateListTableViewController: UITableViewController {

    // MARK: - VARIABLES
    var zip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        zipcodeAlert()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return States.all.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)

        let state = States.all[indexPath.row]

        cell.textLabel?.text = state
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReps" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StateDetailTableViewController else {return}
            destinationVC.state = States.all[indexPath.row]
        } else if segue.identifier == "zipToReps" {
            guard let destinationVC = segue.destination as? StateDetailTableViewController else {return}
            destinationVC.zip = zip
        }
    }
    
    // MARK: - CUSTOM FUNCTIONS
    func zipcodeAlert() {
        let alert = UIAlertController(title: "Search By Zip", message: "Search for Reps using your Zip", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let searchAction = UIAlertAction(title: "Search", style: .default) { (_) in
            guard let zipcode = alert.textFields?[0].text, !zipcode.isEmpty else {return}
            self.zip = zipcode
            self.performSegue(withIdentifier: "zipToReps", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
}
