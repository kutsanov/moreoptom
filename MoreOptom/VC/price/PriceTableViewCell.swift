//
//  PriceTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 06.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet var olName: UILabel!
    @IBOutlet var olOblast: UILabel!
    @IBOutlet var olNote: UILabel!
    @IBOutlet var olCost: UILabel!
    @IBOutlet var olImage: UIImageView!
    
    var tovar: PriceItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        olName.text = tovar?.name
        olOblast.text = tovar?.oblast
        olNote.text = tovar?.note
        
        if let costMin = tovar?.costMin {
            olCost.text = "от " + Utils.shared.separatedNumber(costMin) + " р."
        }
        
    
        if let photo = tovar?.photo {
                NetworkManager.shared.getImage(from: photo, comletion: { (img) in
                    DispatchQueue.main.async {
                    self.olImage.image = img
                    }
                })
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
