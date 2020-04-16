//
//  BoardTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 13.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    @IBOutlet var olTypeName: UILabel!
    @IBOutlet var olTitle: UILabel!
    @IBOutlet var olTxt: UILabel!
    @IBOutlet var olImage: UIImageView!
    
    var tovar: BoardProviderItem?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        olTypeName.text = tovar?.tName
        olTitle.text = tovar?.title
        olTxt.text = tovar?.txtShort ?? tovar?.txt
        
        if let photo = tovar?.photo {
                NetworkManager.shared.getImage(from: photo, comletion: { (img) in
                    DispatchQueue.main.async {
                    self.olImage.image = img
                    }
                })
        }
        
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
