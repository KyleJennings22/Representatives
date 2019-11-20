//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Kyle Jennings on 11/20/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {

    
    // MARK: - VARIABLES
    
    var representatives: [Representative]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var state: String?
    var zip: String?
    
    // MARK: - LIFECYCLE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        if let state = state {
            RepresentativeController.searchRepresentatives(forState: state) { (reps) in
                if !reps.isEmpty {
                    self.representatives = reps
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.presentAlertController()
                    }
                }
            }
        } else if let zip = zip {
            RepresentativeController.searchRepresentativesForZip(zipcode: zip) { (reps) in
                if !reps.isEmpty {
                    self.representatives = reps
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.presentAlertController()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return representatives?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as? RepresentativeTableViewCell else {return UITableViewCell()}

        cell.representative = representatives?[indexPath.row]

        return cell
    }
    func presentAlertController() {
        let alertController = UIAlertController(title: "No Reps!", message: "We can't seem to find your Representatives", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
}
