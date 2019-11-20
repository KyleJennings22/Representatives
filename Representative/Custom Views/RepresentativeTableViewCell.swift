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
    @IBOutlet weak var repPhoneTextView: UITextView!
    @IBOutlet weak var repWebsiteTextView: UITextView!
    
    
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
        repPhoneTextView.text = rep.phone
        repWebsiteTextView.text = rep.link
    }
}
