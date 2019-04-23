//
//  TableViewCell.swift
//  UnderPressure
//
//  Created by murph on 4/22/19.
//  Copyright © 2019 k9doghouse. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var cellTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
