//
//  MainStatFishTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 05.04.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class MainStatFishTableViewCell: UITableViewCell {
    @IBOutlet var olName: UILabel!
    @IBOutlet var olMinCost: UILabel!
    @IBOutlet var olMaxCost: UILabel!
    @IBOutlet var olImage: UIImageView!
    
    var tovar: MainStatTovar?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let tovar = tovar{
            olName.text = tovar.fishName
            olMinCost.text = "Минимальная цена: \(tovar.costMin) р."
            olMaxCost.text = "Минимальная цена: \(tovar.costMax) р."
            NetworkManager.shared.getImage(from: tovar.photo, comletion: { (img) in
                DispatchQueue.main.async {
                    self.olImage.image = img
                }
            })
        }
    }
    
}
