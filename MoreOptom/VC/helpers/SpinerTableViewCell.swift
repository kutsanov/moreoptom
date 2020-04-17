//
//  SpinerTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 06.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class SpinerTableViewCell: UITableViewCell {
    @IBOutlet var olSpiner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
