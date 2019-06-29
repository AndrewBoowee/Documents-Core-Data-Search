//
//  DocumentsTableViewCell.swift
//  Documents Core Data
//
//  Created by Drew Boowee on 6/27/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
