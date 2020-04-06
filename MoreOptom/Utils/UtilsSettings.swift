//
//  UtilsSettings.swift
//  MoreOptom
//
//  Created by Vova Kutsanov on 21.03.2020.
//  Copyright © 2020 Vova Kutsanov. All rights reserved.
//

import UIKit

class UtilsSettings {
    static let shared = UtilsSettings()
    init() {}
    
    let colorBgTint = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    let colorTint = #colorLiteral(red: 0.7389025092, green: 0.8933499455, blue: 1, alpha: 1)
    let colorGray = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    let apiUrl = "http://api.moreoptom.ru/v1"
    let apiKey = "kklPNkKwHfY345JMKHJFDhdv"

    var typeKey = 0
    var fishKey = 0
    var oblastKey = 0
    var boardTypeKey = 0

    var typeName: String {
        get {
            UtilSelect.shared.typeLst().indices.contains(self.typeKey) == true ? UtilSelect.shared.typeLst()[self.typeKey].title : ""
        }
    }
    
    var fishName: String {
        get {
            UtilSelect.shared.fishLst().indices.contains(self.fishKey) == true ? UtilSelect.shared.fishLst()[self.fishKey].title : ""
        }
    }
    
    var oblastName: String {
        get {
            UtilSelect.shared.oblastLst().indices.contains(self.oblastKey) == true ? UtilSelect.shared.oblastLst()[self.oblastKey].title : ""
        }
    }

    var boardTypeName: String {
        get {
            UtilSelect.shared.boardTypeLst().indices.contains(self.boardTypeKey) == true ? UtilSelect.shared.boardTypeLst()[self.boardTypeKey].title : ""
        }
    }


}

