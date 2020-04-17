//
//  MainStatTableViewCell.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 29.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class MainStatTableViewCell: UITableViewCell {
    @IBOutlet var olFirmLabel: UILabel!
    @IBOutlet var olTovarLabel: UILabel!
    @IBOutlet var olFirmCnt: UILabel!
    @IBOutlet var olTovarCnt: UILabel!
    
    var mainStat: MainStat?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let firmCnt = mainStat?.firmCnt {
            olFirmCnt.text = Utils.shared.separatedNumber(firmCnt)
        }
        if let tovarCnt = mainStat?.tovarCnt {
            olTovarCnt.text = Utils.shared.separatedNumber(tovarCnt)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        olFirmLabel.textColor =  UtilsSettings.shared.colorGray
        olTovarLabel.textColor =  UtilsSettings.shared.colorGray
    }
    
    @IBAction func actionGoPrice(_ sender: Any) {
        guard let tabBarController: UITabBarController = self.window?.rootViewController as? UITabBarController else {return}        
        tabBarController.selectedIndex = 1
    }
    
    
}
