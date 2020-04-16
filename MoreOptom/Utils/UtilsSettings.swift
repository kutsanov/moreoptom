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
    let colorWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let apiUrl = "http://api.moreoptom.ru/v1"
    let apiKey = "kklPNkKwHfY345JMKHJFDhdv"

    var typeKey = 0
    var fishKey = 0
    var oblastKey = 0
    var boardTypeKey = 0
    
    var updateCompany = true
    var updatePrice = true
    var updateBoard = true

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
    
    private func getId(models: [UtilsSelectOption], key: Int) -> Int {
        var retId = 0
        
        for i in 0..<models.count {
            let model = models[i] as UtilsSelectOption
            if key == i {
                retId = model.id
                break
            }
        }
        
        return retId
    }
    
    func getFishId() -> Int {
        return getId(models: UtilSelect.shared.fishLst(), key: UtilsSettings.shared.fishKey)
    }
    
    func getTypeId() -> Int {
        return getId(models: UtilSelect.shared.typeLst(), key: UtilsSettings.shared.typeKey)
    }
    
    func getOblastId() -> Int {
        return getId(models: UtilSelect.shared.oblastLst(), key: UtilsSettings.shared.oblastKey)
    }
    
    func getBoardTypeId() -> Int {
        return getId(models: UtilSelect.shared.boardTypeLst(), key: UtilsSettings.shared.boardTypeKey)
    }
    
    func getFishKey(from id: Int) -> Int {
        let models = UtilSelect.shared.fishLst()
        for i in 0..<models.count {
            if models[i].id == id {
                return i
            }
        }
        
        return 0
    }
    
    
    func updateDataTrue() {
        self.updateCompany = true
        self.updatePrice = true
        self.updateBoard = true
    }
    
}

