//
//  RepresentativeTableViewCell.swift
//  Representative
//
//  Created by Kyle Jennings on 11/20/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {
    // MARK: - OUTLETS
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repPartyLabel: UILabel!
    @IBOutlet weak var repDistrictLabel: UILabel!
    @IBOutlet weak var repPhoneLabel: UILabel!
    @IBOutlet weak var repWebsiteLabel: UILabel!
    
    var representative: Representative? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let rep = representative else {return}
        repNameLabel.text = rep.name
        repPartyLabel.text = rep.party
        repDistrictLabel.text = "District \(rep.district)"
        repPhoneLabel.text = rep.phone
        repWebsiteLabel.text = rep.link
    }
}
